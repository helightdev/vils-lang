import 'package:graphs/graphs.dart';
import 'package:vils_toolchain/src/vm/compiler/ir.dart';
import 'package:vils_toolchain/src/parser/ast.dart';
import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

class IRNodeGraph {
  final Map<NodeId, IRNode> _nodes = {};
  static int _voidNodeCounter = 0;

  IRNodeGraph() {
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
    if (circular.isNotEmpty) {
      throw Exception('Circular dependencies detected: $circular');
    }
  }

  List<IRNode> sortedNodes() {
    var keys = _nodes.keys.toList();
    var list = topologicalSort(keys, getNodeDependencies).reversed.map((
      e,
    ) {
      final node = getNode(e);
      if (node == null) {
        throw Exception('Node with id $e not found during sorting');
      }
      return node;
    }).toList();

    list.removeWhere((element) => element.id is MachineNodeId);

    print("Nodes: $list");
    return list;
  }

  List<IRNode> loadEdges(
    List<NodeId> inputs,
    NodeId output,
    List<IRTransformation> transformations,
  ) {
    List<IRNode> results = [];
    inputs.remove(const VoidNodeId());

    if (transformations.isEmpty) {
      final node = addNode(output);
      node.dependencies.addAll(inputs);
      results.add(node);
      return results;
    }

    if (transformations.length == 1) {
      final node = addNode(output, transformation: transformations[0]);
      node.dependencies.addAll(inputs);
      results.add(node);
      return results;
    }

    // Multiple transformations: unroll
    for (var i = 0; i < transformations.length; i++) {
      final isLast = i == transformations.length - 1;
      final nodeId = isLast ? output : SyntheticNodeId(output, i);
      final node = addNode(nodeId, transformation: transformations[i]);
      results.add(node);

      if (i == 0) {
        node.dependencies.addAll(inputs);
      } else {
        node.dependencies.add(SyntheticNodeId(output, i - 1));
      }
    }
    return results;
  }
}
