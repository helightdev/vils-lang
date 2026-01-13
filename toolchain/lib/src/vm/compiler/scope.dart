import 'package:vils_toolchain/src/vm/compiler/ir.dart';
import 'package:vils_toolchain/src/vm/compiler/graph.dart';
import 'package:vils_toolchain/src/parser/ast.dart';
import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/compiler/macro.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

class CompilationScope {
  final VMachine machine;

  CompilationScope(this.machine);

  final IRNodeGraph mainGraph = IRNodeGraph();
  final Map<String, IRNodeGraph> subroutine = {};
  final Map<String, IRBlock> blocks = {};
  final Map<String, String> stringResources = {};

  IRNodeGraph getGraph(String? id) {
    if (id == null) return mainGraph;
    return subroutine.putIfAbsent(id, () => IRNodeGraph());
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

  void visitBlockAst(BlockAst ast) {
    var resource = "block/${ast.id}";
    stringResources[resource] = ast.content;
    blocks[ast.id] = IRBlock(
      ast.id,
      ast.language,
      ast.additionalArgs,
      resource,
    );
  }

  void visitEdgeMacro(IRNodeGraph graph, EdgeMacroInvocationAst ast) {
    final found = machine.getMacro(ast.name);
    if (found == null) throw Exception('Macro not found: ${ast.name}');
    if (found is! EdgeMacro) throw Exception('Macro is not an EdgeMacro: ${ast.name}');
    final context = MacroContext(this, graph);
    found.execute(context, ast);
  }

  void visitEdgeDeclaration(IRNodeGraph graph, EdgeDeclarationAst ast) {
    final transforms = ast.transformations.map(compileTransformation).toList();
    final nodes = graph.loadEdges(ast.inputs, ast.output, transforms);
    final annotations = ast.annotations
        .map((e) => VAnnotation(e.name, e.value))
        .toList();
    for (var node in nodes) {
      node.annotations.addAll(annotations);
    }
  }

  void visitGraphStatementList(IRNodeGraph graph, GraphStatementListAst ast) {
    for (var declaration in ast.edgeDeclarations) {
      visitEdgeDeclaration(graph, declaration);
    }

    for (var macro in ast.edgeMacroInvocations) {
      visitEdgeMacro(mainGraph, macro);
    }
  }

  void visitCompilationUnit(CompilationUnitAst ast) {
    for (var block in ast.blocks) {
      visitBlockAst(block);
    }
    for (var entry in ast.subroutines.entries) {
      final graph = getGraph(entry.key);
      visitGraphStatementList(graph, entry.value);
    }

    visitGraphStatementList(getGraph(null), ast.main);
  }
}