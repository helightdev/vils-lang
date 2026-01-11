import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/location.dart';

class VException {
  String type;
  String? message;
  String? executable;
  Map<String, String> extra = {};
  String? cause;
  NodeId? nodeId;
  String? runId;
  SourceLocation? location;

  VException({
    required this.type,
    this.message,
    this.cause,
    this.executable,
    this.nodeId,
    this.runId,
    this.location,
    Map<String, String>? extra,
  }) {
    if (extra != null) {
      this.extra.addAll(extra);
    }
  }

  String printToString() {
    var buffer = StringBuffer();
    buffer.write("Exception");
    if (nodeId != null) {
      buffer.write(" in node ");
      buffer.write(nodeId.toString());
    }
    buffer.write(" ");
    buffer.write(type);
    if (message != null) {
      buffer.write(": ");
      buffer.write(message);
    }
    buffer.writeln();
    if (location != null || executable != null) {
      buffer.write("\t\tat");
      if (executable != null) {
        buffer.write(" ");
        buffer.write(executable);
      }
      if (location != null) {
        buffer.write(" ");
        if (executable != null) buffer.write("(");
        buffer.write(location!.toStartPosition());
        if (executable != null) buffer.write(")");
      }
      buffer.writeln();
    }
    if (runId != null) {
      buffer.write("\t\tin run ");
      buffer.writeln(runId);
    }
    if (extra != null) {
      extra!.forEach((key, value) {
        buffer.writeln("\t\twith $key: $value");
      });
    }

    if (cause != null) {
      buffer.write("Caused by: ");
      buffer.writeln(cause);
    }
    return buffer.toString();
  }
}
