import 'package:collection/collection.dart';
import 'package:vils_toolchain/src/vm/compiler/macro.dart';
import 'package:vils_toolchain/src/vm/compiler/scope.dart';
import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/location.dart';
import 'package:vils_toolchain/src/utils/tables.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/function.dart';
import 'package:vils_toolchain/src/vm/library.dart';

class VMachine {
  late List<VNode> nodes = [];

  late Map<NodeId, VNode> nodeMap = {};

  final Map<String, VFunction> functions = {};
  final Map<String, VMacro> macros = {};

  CompilationScope createCompilationScope() {
    return CompilationScope(this);
  }

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

  VMacro? getMacro(String name, {String? package}) {
    if (package == null) {
      return macros.values.firstWhereOrNull((e) => e.name == name);
    }
    return macros["$package:$name"];
  }

  VNode? getNode(NodeId id) {
    return nodes.firstWhereOrNull((node) => node.id == id);
  }

  void load(VLibrary library) {
    for (var function in library.functions) {
      functions[function.qualifiedName] = function;
    }
    for (var macro in library.macros) {
      macros[macro.qualifiedName] = macro;
    }
  }

  Future<Val?> execute({
    Val input = const NullVal(),
    Val argument = const NullVal(),
  }) async {
    var vmState = VMachineState(this, input, argument);
    var val = await vmState.execute();
    vmState.debugPrint();
    return val;
  }
}

class VAnnotation {
  final String name;
  final Val? value;

  const VAnnotation(this.name, this.value);

  @override
  String toString() {
    return 'VAnnotation{name: $name, value: $value}';
  }
}

class VMachineState {
  static final inNodeDef = VNode(const InputNodeId())..schedulable = false;
  static final argNodeDef = VNode(const ArgumentNodeId())..schedulable = false;

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
            e.delegate.executable?.toString() ??
                (e.delegate.schedulable ? "<no-op>" : "<bucket>"),
            e.status.name.split(".").last,
            e.result.asString(),
            e.dependencies.map((e) => e.id).nonNulls.join(","),
            e.next.map((e) => e.id).nonNulls.join(","),
          ],
        )
        .toList();
    final str = buildTable([
      ["Node ID", "Name", "Status", "Result", "Dependencies", "Next"],
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

    node.context = context;
    node.status = VNodeStatus.running;
    // TODO: Handle gas / cost
    var returned = node.delegate.executable!.execute(context);
    node.result = returned;
    if (returned is! FutureVal) {
      node.complete(returned);
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
  VExecutableContext? context;

  List<VNodeState> dependencies = [];
  List<VNodeState> next = [];
  VNodeStatus status = VNodeStatus.initial;

  void complete(Val value) {
    var currentResult = result;
    if (currentResult is FutureVal) {
      currentResult.complete(value);
    }
    result = value;
    status = VNodeStatus.completed;
    parent.scheduleNextNodes(this);
  }

  void fail([Object? error]) {
    var currentResult = result;
    if (currentResult is FutureVal) {
      currentResult.cancel();
    }
    result = const NullVal();
    status = VNodeStatus.failed;
    print("Node $id completed exceptionally: $error");
  }

  void interrupt({bool scheduleNext = false}) {
    var currentResult = result;
    if (currentResult is FutureVal) {
      currentResult.cancel();
    }
    result = const NullVal();
    status = VNodeStatus.interrupted;
    if (scheduleNext) parent.scheduleNextNodes(this);
  }

  void skip() {
    var currentResult = result;
    if (currentResult is FutureVal) {
      currentResult.cancel();
    }
    result = const NullVal();
    status = VNodeStatus.skipped;
  }
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
