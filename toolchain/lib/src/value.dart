import 'dart:collection';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:vils_toolchain/src/ids.dart';

sealed class Val {
  const Val();

  Val resolve() => this;

  Object? toNative();

  @override
  String toString() {
    return jsonEncode(toNative());
  }

  bool isTruthy() {
    return switch (this) {
      BoolVal v => v.value,
      NullVal _ => false,
      NumVal v => v.value != 0,
      StringVal v => v.value.isNotEmpty,
      ListVal v => v.values.isNotEmpty,
      ObjVal v => v.values.isNotEmpty,
      FutureVal v => v.isCompleted,
      NodeIdVal() => true,
      ExecutableIdVal() => true,
    };
  }

  bool isFalsy() => !isTruthy();

  String asString() => switch (this) {
    StringVal v => v.value,
    NumVal v => v.toNative().toString(),
    BoolVal v => v.value.toString(),
    NullVal _ => 'null',
    ListVal v => '[${v.values.map((e) => e.asString()).join(', ')}]',
    ObjVal v =>
      '{${v.values.entries.map((e) => '${e.key}: ${e.value.asString()}').join(', ')}}',
    FutureVal v =>
      v.isCompleted ? 'Future(${v.result.asString()})' : 'Future(pending)',
    NodeIdVal v => 'NodeId(${v.nodeId})',
    ExecutableIdVal v => 'ExecutableId(${v.id})',
  };

  double? asNumber() => switch (this) {
    NumVal v => v.value,
    StringVal v => double.tryParse(v.value),
    BoolVal v => v.value ? 1.0 : 0.0,
    NullVal _ => null,
    ListVal v => v.values.length.toDouble(),
    ObjVal v => v.values.length.toDouble(),
    FutureVal v => v.isCompleted ? v.result.asNumber() : null,
    NodeIdVal() => null,
    ExecutableIdVal() => null,
  };

  List<Val> asList() => switch (this) {
    ListVal v => v.values,
    NullVal _ => [],
    _ => [this],
  };

  Val ifNull(Val other) {
    return this is NullVal ? other : this;
  }

  static Val fromNative(Object? value) {
    return switch (value) {
      String v => StringVal(v),
      double v => NumVal(v),
      int v => NumVal(v.toDouble()),
      bool v => BoolVal(v),
      null => const NullVal(),
      List l => ListVal(l.map((e) => fromNative(e)).toList()),
      Map m => fromNativeMap(m),
      // Interop for convenience conversion
      NodeId v => NodeIdVal(v),
      _ => throw ArgumentError('Unsupported type: ${value.runtimeType}'),
    };
  }

  static Val fromNativeMap(Map map) {
    if (map.length == 1) {
      var firstKey = map.keys.first;
      switch (firstKey) {
        case r"$nodeId":
          final nodeIdValue = map[r"$nodeId"];
          if (nodeIdValue is String) {
            return NodeIdVal(NodeId.deserialize(nodeIdValue));
          }
        case r"$executableId":
          final execIdValue = map[r"$executableId"];
          if (execIdValue is String) {
            return ExecutableIdVal(execIdValue);
          }
        default:
          break;
      }
    }
    return ObjVal(
      LinkedHashMap<String, Val>.fromEntries(
        map.entries.map((e) => MapEntry(e.key.toString(), fromNative(e.value))),
      ),
    );
  }
}

class StringVal extends Val {
  final String value;

  const StringVal(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringVal &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  Object? toNative() => value;
}

class NumVal extends Val {
  final double value;

  const NumVal(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NumVal && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  Object? toNative() {
    return value % 1 == 0 ? value.toInt() : value;
  }
}

class BoolVal extends Val {
  final bool value;

  const BoolVal(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BoolVal && value == other.value;

  @override
  int get hashCode => value.hashCode;


  @override
  Object? toNative() => value;
}

class NullVal extends Val {
  const NullVal();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NullVal && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  Object? toNative() => null;
}

class ListVal extends Val {
  final List<Val> values;

  const ListVal(this.values);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListVal &&
          const DeepCollectionEquality().equals(values, other.values);

  @override
  int get hashCode => const DeepCollectionEquality().hash(values);

  @override
  String toString() {
    return '[${values.join(', ')}]';
  }

  @override
  Object? toNative() => values.map((e) => e.toNative()).toList();
}

class ObjVal extends Val {
  final LinkedHashMap<String, Val> values;

  const ObjVal(this.values);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjVal &&
          const DeepCollectionEquality().equals(values, other.values);

  @override
  int get hashCode => const DeepCollectionEquality().hash(values);

  @override
  String toString() {
    return '{${values.entries.map((e) => '"${e.key}": ${e.value}').join(', ')}}';
  }

  @override
  Object? toNative() =>
      values.map((key, value) => MapEntry(key, value.toNative()));
}

class FutureVal extends Val {
  bool isCancelled = false;
  bool isCompleted = false;
  Val result = const NullVal();
  dynamic ext;

  FutureVal([this.ext]);

  void complete(Val value) {
    if (isCancelled || isCompleted) {
      return;
    }
    result = value;
    isCompleted = true;
  }

  void cancel() {
    isCancelled = true;
  }

  @override
  Object? toNative() {
    return null;
  }

  @override
  Val resolve() {
    return isCompleted ? result : const NullVal();
  }

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  int get hashCode => identityHashCode(this);

  @override
  String toString() {
    return isCompleted ? 'FutureVal($result, $ext)' : 'Future(pending, $ext)';
  }
}

class NodeIdVal extends Val {
  final NodeId nodeId;

  const NodeIdVal(this.nodeId);

  @override
  Object? toNative() {
    return NodeId.serialize(nodeId);
  }

  @override
  String toString() {
    return NodeId.serialize(nodeId);
  }
}

class ExecutableIdVal extends Val {
  final String id;

  const ExecutableIdVal(this.id);

  @override
  Object? toNative() {
    return {r"$executableId": id.toString()};
  }

  @override
  String toString() {
    return '.$id';
  }
}

extension ValDynamicExtension on dynamic {
  Val toVal() => Val.fromNative(this);
}

extension ValExtension on Val {}
