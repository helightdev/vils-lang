import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/location.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

class IRNode {
  NodeId id;
  SourceLocation? location;

  IRTransformation? transformation;
  List<NodeId> dependencies = [];
  List<VAnnotation> annotations = [];

  IRNode(this.id, {this.transformation, List<NodeId>? dependencies}) {
    if (dependencies != null) {
      this.dependencies = dependencies;
    }
  }

  @override
  String toString() {
    return 'Node{id: $id, dependencies: $dependencies, transformation: $transformation, annotations: $annotations}';
  }
}

class IRTransformation {
  final TransformationType type;
  final Val? arg0;
  final Val? arg1;

  IRTransformation(this.type, this.arg0, this.arg1);

  factory IRTransformation.invoke(String name, Val? argument) =>
      IRTransformation(TransformationType.invoke, name.toVal(), argument);

  factory IRTransformation.execute(String id, Val? argument) =>
      IRTransformation(TransformationType.execute, id.toVal(), argument);

  @override
  String toString() {
    return 'IRTransformation{type: $type, arg0: $arg0, arg1: $arg1}';
  }
}

enum TransformationType { invoke, execute }

class IRBlock {
  final String id;
  final String? language;
  final List<String> additional;
  final String resource;

  IRBlock(this.id, this.language, this.additional, this.resource);
}