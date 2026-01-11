import 'package:graphs/graphs.dart';
import 'package:vils/src/location.dart';
import 'package:vils/src/parser/ast.dart';
import 'package:vils/src/ids.dart';
import 'package:vils/src/value.dart';
import 'package:vils/src/vm/machine.dart';

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
    return 'Node{id: $id, dependencies: $dependencies, transformation: $transformation}';
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

class CompilationNodeGraph {
  final Map<NodeId, IRNode> _nodes = {};
  static int _voidNodeCounter = 0;

  CompilationNodeGraph() {
    _addPseudoNode(const InputNodeId());
    _addPseudoNode(const ArgumentNodeId());
  }

  void _addPseudoNode(NodeId id) {
    _nodes[id] = IRNode(id);
  }

  IRNode addNode(NodeId id, {IRTransformation? transformation}) {
    var node = IRNode(id, transformation: transformation);
    if (id is VoidNodeId) {
      var uniqueId = SyntheticNodeId(id, _voidNodeCounter++);
      node.id = uniqueId;
      _nodes[uniqueId] = node;
      return node;
    }
    if (_nodes.containsKey(id)) {
      throw Exception('Node with id $id already exists');
    }
    _nodes[id] = node;
    return node;
  }

  IRNode? getNode(NodeId id) {
    return _nodes[id];
  }

  Iterable<NodeId> getNodeDependencies(NodeId id) {
    final node = _nodes[id];
    if (node == null) {
      return const [];
    }
    return node.dependencies.where((e) => e is! VoidNodeId);
  }

  void verifyAcyclic() {
    var components = stronglyConnectedComponents(
      _nodes.keys.toList(),
      getNodeDependencies,
    );
    var circular = components
        .where((component) => component.length > 1)
        .toList();
    if (circular.isNotEmpty)
      throw Exception('Circular dependencies detected: $circular');
  }

  List<IRNode> sortedNodes() {
    var list = topologicalSort(_nodes.keys, getNodeDependencies).reversed.map((
      e,
    ) {
      final node = getNode(e);
      if (node == null) {
        throw Exception('Node with id $e not found during sorting');
      }
      return node;
    }).toList();

    print(list);
    return list;
  }

  IRTransformation compileTransformation(TransformAst ast) {
    if (ast is TransformInvokeAst) {
      return IRTransformation.invoke(ast.name, ast.argument);
    } else if (ast is TransformExecuteAst) {
      return IRTransformation.execute(ast.id, ast.argument);
    } else {
      throw Exception('Unknown transformation type: ${ast.runtimeType}');
    }
  }

  void loadEdge(EdgeDeclarationAst ast) {
    final output = ast.output;
    final inputs = ast.inputs.toList();
    inputs.remove(const VoidNodeId());

    if (ast.transformations.isEmpty) {
      final node = addNode(output);
      node.dependencies.addAll(inputs);
      return;
    }

    if (ast.transformations.length == 1) {
      final compiled = compileTransformation(ast.transformations.first);
      final node = addNode(output, transformation: compiled);
      node.dependencies.addAll(inputs);
      return;
    }

    // Multiple transformations: unroll
    for (var i = 0; i < ast.transformations.length; i++) {
      final isLast = i == ast.transformations.length - 1;
      final nodeId = isLast ? output : SyntheticNodeId(output, i);
      final compiled = compileTransformation(ast.transformations[i]);
      final node = addNode(nodeId, transformation: compiled);

      if (i == 0) {
        node.dependencies.addAll(inputs);
      } else {
        node.dependencies.add(SyntheticNodeId(output, i - 1));
      }
    }
  }

  // void namespace(String namespace) {
  //   var buffer = <NodeId, Node>{};
  //
  //   NodeId namespacedId(NodeId id) {
  //     if (id is MachineNodeId) {
  //       return id;
  //     }
  //     return NamespacedNodeId(namespace, id);
  //   }
  //
  //   for (var entry in _nodes.entries) {
  //     final key = namespacedId(entry.key);
  //     final node = entry.value;
  //     node.id = key;
  //     node.dependencies = node.dependencies.map(namespacedId).toList();
  //     buffer[key] = node;
  //   }
  //
  //   _nodes
  //     ..clear()
  //     ..addAll(buffer);
  //
  //   print('Namespaced graph to $namespace: $_nodes');
  // }

  static CompilationNodeGraph fromAst(CompilationUnitAst ast) {
    var graph = CompilationNodeGraph();
    for (var edge in ast.edges) {
      graph.loadEdge(edge);
    }
    return graph;
  }
}
