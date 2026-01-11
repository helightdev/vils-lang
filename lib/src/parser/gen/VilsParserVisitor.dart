// Generated from grammar/VilsParser.g4 by ANTLR 4.13.2
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'VilsParser.dart';

/// This abstract class defines a complete generic visitor for a parse tree
/// produced by [VilsParser].
///
/// [T] is the eturn type of the visit operation. Use `void` for
/// operations with no return type.
abstract class VilsParserVisitor<T> extends ParseTreeVisitor<T> {
  /// Visit a parse tree produced by [VilsParser.compilationUnit].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitCompilationUnit(CompilationUnitContext ctx);

  /// Visit a parse tree produced by [VilsParser.topLevelStatement].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitTopLevelStatement(TopLevelStatementContext ctx);

  /// Visit a parse tree produced by [VilsParser.block].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitBlock(BlockContext ctx);

  /// Visit a parse tree produced by [VilsParser.edgeDeclaration].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitEdgeDeclaration(EdgeDeclarationContext ctx);

  /// Visit a parse tree produced by [VilsParser.transformation].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitTransformation(TransformationContext ctx);

  /// Visit a parse tree produced by [VilsParser.transformInvocation].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitTransformInvocation(TransformInvocationContext ctx);

  /// Visit a parse tree produced by [VilsParser.transformExecute].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitTransformExecute(TransformExecuteContext ctx);

  /// Visit a parse tree produced by [VilsParser.edgeMacroInvocation].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitEdgeMacroInvocation(EdgeMacroInvocationContext ctx);

  /// Visit a parse tree produced by [VilsParser.nodeRef].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitNodeRef(NodeRefContext ctx);

  /// Visit a parse tree produced by [VilsParser.executableRef].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitExecutableRef(ExecutableRefContext ctx);

  /// Visit a parse tree produced by [VilsParser.nodeRefList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitNodeRefList(NodeRefListContext ctx);

  /// Visit a parse tree produced by [VilsParser.annotation].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitAnnotation(AnnotationContext ctx);

  /// Visit a parse tree produced by [VilsParser.value].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitValue(ValueContext ctx);

  /// Visit a parse tree produced by [VilsParser.valueObj].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitValueObj(ValueObjContext ctx);

  /// Visit a parse tree produced by [VilsParser.valueList].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitValueList(ValueListContext ctx);

  /// Visit a parse tree produced by [VilsParser.valuePair].
  /// [ctx] the parse tree.
  /// Return the visitor result.
  T? visitValuePair(ValuePairContext ctx);
}