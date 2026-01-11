import 'package:collection/collection.dart';
import 'package:vils/src/ids.dart';
import 'package:vils/src/location.dart';
import 'package:vils/src/utils/tables.dart';
import 'package:vils/src/value.dart';
import 'package:vils/src/vm/lib/lang.dart';
import 'package:vils/src/vm/lib/math.dart';
import 'package:vils/src/vm/trace.dart';

class VMachine {
  late List<VNode> nodes = [];

  late Map<NodeId, VNode> nodeMap = {};

  final Map<String, VFunction> functions = {};

  void addNode(VNode node) {
    if (nodeMap.containsKey(node.id)) {
      throw Exception("Node with id ${node.id} already exists");
    }
    nodes.add(node);
    nodeMap[node.id] = node;
  }

  VFunction? getFunction(String name, {String? package}) {
    if (package == null) {
      return functions.values.firstWhereOrNull((e) => e.name == name);
    }
    return functions["$package:$name"];
  }

  VNode? getNode(NodeId id) {
    return nodes.firstWhereOrNull((node) => node.id == id);
  }

  void load(VLibrary library) {
    for (var function in library.functions) {
      functions[function.qualifiedName] = function;
    }
  }

  Future<Val?> execute({
    Val input = const NullVal(),
    Val argument = const NullVal(),
  }) async {
    var vmState = VMachineState(this, input, argument);
    var val = await vmState.execute();
    print("---/END");
    vmState.debugPrint();
    print("---/");
    return val;
  }
}

class VAnnotation  {
  final String name;
  final Val? value;

  const VAnnotation(this.name, this.value);
}

class VMachineState {
  static final inNodeDef = VNode(const InputNodeId())
    ..schedulable = false;
  static final argNodeDef = VNode(const ArgumentNodeId())
    ..schedulable = false;

  final VMachine vm;

  late final VNodeState input;
  late final VNodeState argument;
  final List<VNodeState> nodes = [];
  String runId = "vm-${DateTime.now().millisecondsSinceEpoch}";

  VMachineState(this.vm, Val input, Val argument) {
    this.input = VNodeState(inNodeDef, this)
      ..result = input
      ..status = VNodeStatus.completed;
    this.argument = VNodeState(argNodeDef, this)
      ..result = argument
      ..status = VNodeStatus.completed;
    nodes.add(this.input);
    nodes.add(this.argument);

    // First pass: create states for all nodes
    for (var node in vm.nodes) {
      assert(node.id != const InputNodeId(), "Input node ID is reserved");
      assert(node.id != const ArgumentNodeId(), "Argument node ID is reserved");

      var state = node.createState(this);
      nodes.add(state);
      nodeMap[node.id] = state;
    }

    // Second pass: resolve dependencies and forward links
    for (var state in nodes) {
      for (var depId in state.delegate.dependencies) {
        final depState = get(depId)!;
        state.dependencies.add(depState);
        depState.next.add(state);
      }
    }
    print("VMachineState initialized with ${nodes.length} nodes.");
    debugPrint();
    print("---");
  }

  final List<VNodeState> scheduled = [];

  late Map<NodeId, VNodeState> nodeMap = {
    input.id: input,
    argument.id: argument,
  };

  bool get isFinished => scheduled.isEmpty && isStalled;

  bool get isStalled => nodes.none((e) => e.status == VNodeStatus.running);
  int stallCounter = 0;

  VNodeState? get(NodeId id) {
    return nodeMap[id];
  }

  Val? getValue(NodeId id) {
    var node = get(id);
    if (node == null) return null;
    if (node.status != VNodeStatus.completed) return null;
    return node.result;
  }

  void scheduleRoots() {
    for (var node in nodes) {
      if (node.delegate.schedulable) scheduleNode(node);
    }
  }

  void scheduleNode(VNodeState node) {
    if (node.status != VNodeStatus.initial) {
      print("WARN: Node ${node.id} is already scheduled or processed.");
      return;
    }
    if (!node.delegate.schedulable) {
      print("WARN: Node ${node.id} is not schedulable.");
      return;
    }

    node.status = VNodeStatus.scheduled;
    scheduled.add(node);
    node.delegate.executable?.scheduled(node);
    print("Scheduled node ${node.id}");
  }

  void scheduleNextNodes(VNodeState node) {
    for (var next in node.next) {
      if (next.status == VNodeStatus.initial) scheduleNode(next);
    }
  }

  bool tick() {
    VNodeState? popped;
    for (var value in scheduled) {
      popped = _processScheduled(value);
      if (popped != null) break;
    }
    if (popped != null) {
      scheduled.remove(popped);
      return true;
    }
    return false;
  }

  void debugPrint() {
    final rows = nodes
        .map(
          (e) => [
            e.id,
            e.delegate.executable?.toString() ?? (e.delegate.schedulable ? "<no-op>" : "<bucket>"),
            e.status.name.split(".").last,
            e.dependencies.map((e) => e.id).nonNulls.join(","),
            e.result.asString(),
            e.next.map((e) => e.id).nonNulls.join(","),
          ],
        )
        .toList();
    final str = buildTable([
      ["Node ID", "Name", "Status", "Dependencies", "Result", "Next"],
      ...rows,
    ]);
    print(str);
  }

  Future<Val?> execute() async {
    //scheduleRoots();
    scheduleNextNodes(input);

    while (!isFinished) {
      var hadAction = tick();
      if (hadAction) {
        stallCounter == 0;
        continue;
      }

      if (isStalled) {
        if (stallCounter++ > 255) {
          debugPrint();
          throw Exception("Machine stall detected, interrupted execution.");
        }
      } else {
        stallCounter == 0;
      }

      await Future.delayed(const Duration(milliseconds: 1));
    }

    final outputNode = get(const OutputNodeId());
    if (outputNode == null) return null;
    if (outputNode.status != VNodeStatus.completed) {
      debugPrint();
      throw Exception(
        "Output node is not completed, status: ${outputNode.status}",
      );
    }
    return outputNode.result;
  }

  VNodeState? _processScheduled(VNodeState value) {
    switch (value.status) {
      case VNodeStatus.initial:
        return null;
      case VNodeStatus.scheduled:
        bool isNext = true;
        for (var dep in value.dependencies) {
          if (dep.status.isAwaitable) {
            isNext = false;
            break;
          }
          if (value.delegate.executable?.ignoreDependencyFailures ?? false) {
            continue;
          }
          if (dep.status.isFailed) {
            value.status = VNodeStatus.skipped;
            return value;
          }
        }
        if (isNext) {
          try {
            if (_exec(value)) return value;
          } catch (e, st) {
            value.status = VNodeStatus.failed;
            print("Node ${value.id} execution failed: $e\n$st");
            // TODO: Panic
            return value;
          }
        }
        return null;
      case VNodeStatus.running:
      case VNodeStatus.completed:
      case VNodeStatus.failed:
      case VNodeStatus.interrupted:
      case VNodeStatus.skipped:
        return value;
    }
  }

  bool _exec(VNodeState node) {
    if (node.status == VNodeStatus.completed) return true;
    if (node.delegate.executable == null) {
      node.status = VNodeStatus.skipped;
      print("Node ${node.id} has no executable, skipping.");
      return true;
    }

    // Collect startup inputs and prepare input value
    var results = node.dependencies
        .where((e) => e.status == VNodeStatus.completed)
        .map((e) => e.result.resolve())
        .toList();
    Val input;
    if (results.isEmpty) {
      input = const NullVal();
    } else if (results.length == 1) {
      input = results[0];
    } else {
      input = ListVal(results);
    }

    var context = VExecutableContext(input, this, node);
    if (!node.delegate.executable!.before(context)) {
      return false;
    }

    node.status = VNodeStatus.running;
    // TODO: Handle gas / cost
    var returned = node.delegate.executable!.execute(context);
    node.result = returned;
    if (returned is! FutureVal) {
      context.complete(returned);
    }
    return true;
  }
}

class VNode {
  final NodeId id;

  VNode(this.id);

  List<NodeId> dependencies = [];

  bool schedulable = true;
  VExecutable? executable;
  List<VAnnotation> annotations = [];
  SourceLocation? location;

  Val arg = const NullVal();
  
  bool popInput = false;
  bool popArgument = false;
  bool pushResult = false;

  VNodeState createState(VMachineState vmState) {
    return VNodeState(this, vmState)..arg = arg;
  }
}

class VNodeState {
  VNode delegate;
  VMachineState parent;

  VNodeState(this.delegate, this.parent);

  NodeId get id => delegate.id;

  Val arg = const NullVal();
  Val result = const NullVal();
  List<VNodeState> dependencies = [];
  List<VNodeState> next = [];
  VNodeStatus status = VNodeStatus.initial;
}

enum VNodeStatus {
  initial(isAwaitable: true),
  scheduled(isAwaitable: true),
  running(isAwaitable: true),
  completed(isCompleted: true),
  failed(isFailed: true),
  interrupted(isFailed: true),
  skipped(isFailed: true);

  final bool isAwaitable;
  final bool isFailed;
  final bool isCompleted;

  const VNodeStatus({
    this.isAwaitable = false,
    this.isFailed = false,
    this.isCompleted = false,
  });
}

class VExecutableContext {
  final VMachineState vm;
  final VNodeState node;
  final Val input;
  final Val state = const NullVal();

  VExecutableContext(this.input, this.vm, this.node);

  Val get arg => node.arg;

  void populateException(VException ex) {
    ex.nodeId ??= node.id;
    ex.runId ??= vm.runId;
    if (ex.location == null && node.delegate.location != null) {
      ex.location = node.delegate.location;
    }
    if (ex.executable == null && node.delegate.executable != null) {
      ex.executable = node.delegate.executable.toString();
    }
  }

  void complete(Val value) {
    var currentResult = node.result;
    if (currentResult is FutureVal) {
      currentResult.complete(value);
    }
    node.result = value;
    node.status = VNodeStatus.completed;
    vm.scheduleNextNodes(node);
  }

  void fail([Object? error]) {
    var currentResult = node.result;
    if (currentResult is FutureVal) {
      currentResult.cancel();
    }
    node.result = const NullVal();
    node.status = VNodeStatus.failed;
    print("Node ${node.id} completed exceptionally: $error");
  }

  void interrupt({bool scheduleNext = false}) {
    var currentResult = node.result;
    if (currentResult is FutureVal) {
      currentResult.cancel();
    }
    node.result = const NullVal();
    node.status = VNodeStatus.interrupted;
    print("Node ${node.id} was interrupted.");
    if (scheduleNext) vm.scheduleNextNodes(node);
  }
}

abstract class VExecutable {
  int get cost => 1;

  bool get ignoreDependencyFailures => false;

  void scheduled(VNodeState nodeState) {
    for (var value in nodeState.dependencies) {
      if (value.status != VNodeStatus.initial) continue;
      nodeState.parent.scheduleNode(value);
    }
  }

  bool before(VExecutableContext context) => true;

  Val execute(VExecutableContext context);
}

class VFunction extends VExecutable {
  final String package;
  final String name;
  final VExecutable delegate;

  VFunction(this.delegate, {this.package = "root", required this.name});

  late String qualifiedName = "$package:$name";

  @override
  Val execute(VExecutableContext context) {
    return delegate.execute(context);
  }

  @override
  String toString() {
    return 'func $package:$name';
  }
}

class VLibrary {
  List<VFunction> functions;

  VLibrary({this.functions = const []});

  static VLibrary merge(List<VLibrary> libraries) {
    var allFunctions = <VFunction>[];
    for (var library in libraries) {
      allFunctions.addAll(library.functions);
    }
    return VLibrary(functions: allFunctions);
  }
}

final stdCoreLib = VLibrary.merge([stdLangLib, stdMathLib]);
