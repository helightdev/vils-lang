import 'package:antlr4/antlr4.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:vils_toolchain/src/location.dart';
import 'package:vils_toolchain/src/value.dart';

import '../ids.dart';

sealed class VilsAst {
  Location location = Location.invalid;
}

extension ParserRuleContextLocationExtension on ParserRuleContext {
  Location toLocation() {
    var startPos = start?.let((it) => it.toLocation().start) ?? LocationPosition(-1, -1, -1);
    var length = 0;
    if (start != null) {
      if (stop == null) {
        length = start!.stopIndex - start!.startIndex + 1;
      } else {
        length = stop!.stopIndex - start!.startIndex + 1;
      }
    }
    return Location(startPos, length);
  }
}

extension TokenLocationExtension on Token {
  Location toLocation() {
    var line = this.line;
    var start = LocationPosition(line ?? -1, charPositionInLine, startIndex);
    return Location(start, stopIndex - startIndex + 1);
  }
}


class BlockAst extends VilsAst {
  final String id;
  final String content;
  final String? language;
  final List<String> additionalArgs;

  BlockAst(this.id, this.content, this.language, this.additionalArgs);
}

class AnnotationAst extends VilsAst {
  final String name;
  final Val? value;

  AnnotationAst(this.name, this.value);
}

class EdgeDeclarationAst extends VilsAst {
  final NodeId output;
  final List<NodeId> inputs;
  final List<TransformAst> transformations;

  EdgeDeclarationAst(this.output, this.inputs, this.transformations);
}

class EdgeMacroInvocationAst extends VilsAst {
  final String name;
  final Val? value;
  EdgeMacroInvocationAst(this.name, this.value);
}

sealed class TransformAst extends VilsAst {
  List<AnnotationAst> annotations = [];
}

class TransformInvokeAst extends TransformAst {
  final String name;
  final Val? argument;

  TransformInvokeAst(this.name, this.argument);
}

class TransformExecuteAst extends TransformAst {
  final String id;
  final Val? argument;
  TransformExecuteAst(this.id, this.argument);
}

class CompilationUnitAst extends VilsAst {
  final List<BlockAst> blocks;
  final List<EdgeDeclarationAst> edges;
  final List<EdgeMacroInvocationAst> edgeMacroInvocations;
  CompilationUnitAst(this.blocks, this.edges, this.edgeMacroInvocations);
}