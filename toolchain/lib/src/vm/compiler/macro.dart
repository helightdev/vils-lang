import 'package:vils_toolchain/src/parser/ast.dart';
import 'package:vils_toolchain/src/vm/compiler/graph.dart';
import 'package:vils_toolchain/src/vm/compiler/scope.dart';

class MacroContext {

  final CompilationScope scope;
  final IRNodeGraph graph;

  MacroContext(this.scope, this.graph);
}

abstract class VMacro {
  String get package;
  String get name;

  String get qualifiedName => "$package:$name";
}

abstract class EdgeMacro extends VMacro {
  void execute(MacroContext context, EdgeMacroInvocationAst ast);
}