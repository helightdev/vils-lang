import 'package:vils_toolchain/src/compiler/graph.dart';

sealed class NodeId {
  const NodeId();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NodeId && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  static String serialize(NodeId id) {
    return id.toString();
  }

  static NodeId deserialize(String str) {
    if (str == r'$in') return const InputNodeId();
    if (str == r'$out') return const OutputNodeId();
    if (str == r'$arg') return const ArgumentNodeId();
    if (str == r'$void') return const VoidNodeId();
    if (str.contains(':')) {
      final parts = str.split(':');
      final namespace = parts[0];
      final childStr = parts.sublist(1).join(':');
      final child = deserialize(childStr);
      return NamespacedNodeId(namespace, child);
    }
    if (str.contains('@')) {
      final parts = str.split('@');
      final parentStr = parts[0];
      final index = int.parse(parts[1]);
      final parent = deserialize(parentStr);
      return SyntheticNodeId(parent, index);
    }
    if (str.startsWith('#')) {
      final id = str.substring(1);
      return NamedNodeId(id);
    }
    throw Exception('Cannot deserialize NodeId from string: $str');
  }

}

abstract class MachineNodeId implements NodeId {
  const MachineNodeId();
}

class NamedNodeId extends NodeId {
  final String id;

  const NamedNodeId(this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NamedNodeId && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return '#$id';
  }
}

class InputNodeId extends MachineNodeId {
  const InputNodeId();

  @override
  String toString() {
    return r'$in';
  }
}

class OutputNodeId extends MachineNodeId {
  const OutputNodeId();

  @override
  String toString() {
    return r'$out';
  }
}

class ArgumentNodeId extends MachineNodeId {
  const ArgumentNodeId();

  @override
  String toString() {
    return r'$arg';
  }
}

class VoidNodeId extends NodeId {
  const VoidNodeId();

  @override
  String toString() {
    return r'$void';
  }
}

class SyntheticNodeId extends NodeId {
  final NodeId parent;
  final int index;

  const SyntheticNodeId(this.parent, this.index);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SyntheticNodeId &&
          parent == other.parent &&
          index == other.index;

  @override
  int get hashCode => Object.hash(parent, index);

  @override
  String toString() {
    return '$parent@$index';
  }
}

class NamespacedNodeId extends NodeId {
  final String namespace;
  final NodeId child;

  const NamespacedNodeId(this.namespace, this.child);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NamespacedNodeId &&
              namespace == other.namespace &&
              child == other.child;

  @override
  int get hashCode => Object.hash(namespace, child);

  @override
  String toString() {
    return '$namespace:$child';
  }
}
