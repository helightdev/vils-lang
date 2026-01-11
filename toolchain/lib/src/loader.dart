import 'package:vils_toolchain/src/parser/ast.dart';
import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/machine.dart';
import 'package:vils_toolchain/vils.dart';

void loadGraphIntoMachine(VMachine machine, CompilationNodeGraph graph) {
  for (var node in graph.sortedNodes()) {
    final id = node.id;
    var transformation = node.transformation;
    if (transformation == null) continue;

    final vmNode = VNode(id);
    final dependencies = <NodeId>[];
    for (var value in node.dependencies) {
      if (value is! VoidNodeId) dependencies.add(value);
    }
    vmNode.dependencies = dependencies;

    switch (transformation.type) {
      case TransformationType.invoke:
        vmNode.executable = machine.getFunction(transformation.arg0!.asString());
        vmNode.arg = transformation.arg1 ?? const NullVal();
        break;
      case TransformationType.execute:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    for (var annotation in node.annotations) {
      if (annotation.name == "stack") {
        var str = annotation.value?.asString() ?? "";
        vmNode.popInput = str.contains("i");
        vmNode.popArgument = str.contains("a");
        vmNode.pushResult = str.contains("r");
        continue;
      }

      vmNode.annotations.add(VAnnotation(annotation.name, annotation.value));
    }

    machine.addNode(vmNode);
  }
}
