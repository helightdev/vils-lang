import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

import 'trace.dart';

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