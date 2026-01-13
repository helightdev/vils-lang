import 'dart:collection';
import 'dart:convert';

import 'package:antlr4/antlr4.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:vils_toolchain/src/parser/ast.dart';
import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/parser/gen/VilsLexer.dart';
import 'package:vils_toolchain/src/parser/gen/VilsParser.dart';
import 'package:vils_toolchain/src/parser/gen/VilsParserBaseVisitor.dart';
import 'package:vils_toolchain/src/value.dart';

CompilationUnitAst parseUnitAst(String input) {
  var inputStream = InputStream.fromString(input.trim());
  var lexer = VilsLexer(inputStream);
  var tokenStream = CommonTokenStream(lexer);
  var parser = VilsParser(tokenStream);
  var tree = parser.compilationUnit();
  var visitor = _Parser();
  return visitor.visitCompilationUnit(tree);
}

class _Parser extends VilsParserBaseVisitor<VilsAst> {
  @override
  CompilationUnitAst visitCompilationUnit(CompilationUnitContext ctx) {
    final blocks = <BlockAst>[];
    final mainStatementList = GraphStatementListAst([], []);
    final subroutines = <String, GraphStatementListAst>{};
    for (var statement in ctx.topLevelStatements()) {
      if (statement.block() != null) {
        var blockAst = visitBlock(statement.block()!);
        if (blockAst != null) {
          blocks.add(blockAst);
        }
      } else if (statement.graphStatement() != null) {
        mainStatementList.merge(
          _parseGraphStatements([statement.graphStatement()!]),
        );
      } else if (statement.subroutine() != null) {
        final subroutine = statement.subroutine()!;
        final block = _parseGraphStatements(subroutine.graphStatements())
          ..location = subroutine.toLocation();
        final id = subroutine.IDENTIFIER()!.text!;
        subroutines[id] = block;
      }
    }
    return CompilationUnitAst(blocks, mainStatementList, subroutines)
      ..location = ctx.toLocation();
  }

  GraphStatementListAst _parseGraphStatements(
    List<GraphStatementContext> statements,
  ) {
    final parsed = statements.map(visitGraphStatement).toList();
    return GraphStatementListAst(
      parsed.whereType<EdgeDeclarationAst>().toList(),
      parsed.whereType<EdgeMacroInvocationAst>().toList(),
    );
  }

  @override
  BlockAst? visitBlock(BlockContext ctx) {
    var content = ctx.BLOCK_LINEs().join();
    var ids = ctx.BLOCK_HEADER_IDs().map((e) => e.text!).toList();
    if (ids.isEmpty) {
      throw Exception("Block is missing an ID");
    }
    return BlockAst(
      ids[0],
      content,
      ids.skip(1).firstOrNull,
      ids.skip(2).toList(),
    )..location = ctx.toLocation();
  }

  @override
  VilsAst? visitEdgeDeclaration(EdgeDeclarationContext ctx) {
    final inputs = _parseNodeRefList(ctx.nodeRefList()!);
    final output = _parseNodeRef(ctx.nodeRef()!);
    final annotations = ctx.annotations().map(visitAnnotation).toList();
    final transformations = ctx
        .transformations()
        .map(visitTransformation)
        .toList();

    return EdgeDeclarationAst(output, inputs, transformations, annotations)
      ..location = ctx.toLocation();
  }

  @override
  VilsAst? visitEdgeMacroInvocation(EdgeMacroInvocationContext ctx) {
    final id = ctx.IDENTIFIER(0)!.text!;
    Val? value = ctx.value()?.let(_parseVal);
    if (ctx.IDENTIFIERs().length > 1) {
      value = StringVal(ctx.IDENTIFIER(1)!.text!);
    }
    final annotations = ctx.annotations().map(visitAnnotation).toList();
    return EdgeMacroInvocationAst(id, value, annotations)..location = ctx.toLocation();
  }

  @override
  TransformAst visitTransformation(TransformationContext ctx) {
    var annotations = ctx.annotations().map(visitAnnotation).toList();
    if (ctx.transformInvocation() != null) {
      return visitTransformInvocation(ctx.transformInvocation()!)
        ..annotations.addAll(annotations);
    } else if (ctx.transformExecute() != null) {
      return visitTransformExecute(ctx.transformExecute()!)
        ..annotations.addAll(annotations);
    }
    throw Exception("Invalid transformation");
  }

  @override
  TransformInvokeAst visitTransformInvocation(TransformInvocationContext ctx) {
    final value = ctx.value()?.let(_parseVal);
    final function = ctx.IDENTIFIER()!.text!;
    return TransformInvokeAst(function, value)..location = ctx.toLocation();
  }

  @override
  TransformExecuteAst visitTransformExecute(TransformExecuteContext ctx) {
    final id = ctx.IDENTIFIER()!.text!;
    final value = ctx.value()?.let(_parseVal);
    return TransformExecuteAst(id, value)..location = ctx.toLocation();
  }

  @override
  AnnotationAst visitAnnotation(AnnotationContext ctx) {
    final name = ctx.IDENTIFIERs().first.text!;
    Val? value = ctx.value()?.let(_parseVal);
    if (value == null && ctx.IDENTIFIERs().length > 1) {
      value = StringVal(ctx.IDENTIFIERs()[1].text!);
    }
    return AnnotationAst(name, value)..location = ctx.toLocation();
  }

  NodeId _parseNodeRef(NodeRefContext ctx) {
    return NodeId.deserialize(ctx.text);
  }

  List<NodeId> _parseNodeRefList(NodeRefListContext ctx) {
    return ctx.nodeRefs().map(_parseNodeRef).toList();
  }

  Val _parseVal(ValueContext ctx) {
    if (ctx.STRING() != null) {
      var text = ctx.STRING()!.text!;
      return StringVal(text.substring(1, text.length - 1));
    } else if (ctx.NUMBER() != null) {
      var text = ctx.NUMBER()!.text!;
      return NumVal(double.parse(text));
    } else if (ctx.BOOLEAN() != null) {
      var text = ctx.BOOLEAN()!.text!;
      return BoolVal(text == 'true');
    } else if (ctx.NULL() != null) {
      return const NullVal();
    } else if (ctx.valueObj() != null) {
      var map = LinkedHashMap.fromEntries(
        ctx.valueObj()!.valuePairs().map((e) {
          String key;
          if (e.STRING() != null) {
            key = jsonDecode(e.STRING()!.text!);
          } else if (e.IDENTIFIER() != null) {
            key = e.IDENTIFIER()!.text!;
          } else {
            throw Exception("Invalid object key");
          }

          return MapEntry(key, _parseVal(e.value()!));
        }),
      );
      return ObjVal(map);
    } else if (ctx.valueList() != null) {
      var list = ctx.valueList()!.values().map((e) => _parseVal(e)).toList();
      return ListVal(list);
    } else if (ctx.nodeRef() != null) {
      var nodeId = _parseNodeRef(ctx.nodeRef()!);
      return NodeIdVal(nodeId);
    } else if (ctx.executableRef() != null) {
      var execId = ctx.executableRef()!.IDENTIFIER()!.text!;
      return ExecutableIdVal(execId);
    }

    throw Exception("Invalid value");
  }
}
