import 'package:collection/collection.dart';
import 'package:dart_scope_functions/dart_scope_functions.dart';
import 'package:vils_toolchain/src/ids.dart';
import 'package:vils_toolchain/src/parser/ast.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/compiler/macro.dart';
import 'package:vils_toolchain/src/vm/function.dart';
import 'package:vils_toolchain/src/vm/library.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

final stdLangLib = VLibrary(
  functions: [
    VFunction(ValueExecutable(), name: "value", package: "lang"),
    VFunction(ConcatExecutable(), name: "concat", package: "lang"),
    VFunction(CollectCompleted(), name: "collectCompleted", package: "lang"),
    VFunction(BranchExpression(), name: "_branch", package: "lang"),
  ],
  macros: [
    BranchMacro(),
  ]
);

class ValueExecutable extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    return context.arg;
  }
}

class ConcatExecutable extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    var stringValue = [
      ...context.input.asList(),
      ...context.arg.asList(),
    ].map((e) => e.asString()).join();
    return StringVal(stringValue);
  }
}

class CollectCompleted extends VExecutable {
  @override
  bool get ignoreDependencyFailures => true;

  @override
  Val execute(VExecutableContext context) {
    return context.input.asList().toVal();
  }
}

class BranchExpression extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    final input = context.input;
    final argObj = context.arg.requireObj();
    final values = argObj.require("values").requireList();
    final outputIds = argObj.require("branches").requireNodeIdListUnwrap();
    final elseId = argObj["else"]?.requireNodeIdUnwrap();
    final elseNode = elseId?.let((it) => context.vm.get(it));
    final outputs = outputIds
        .map((id) => context.vm.get(id)!)
        .toList();


    int match = -1;
    for (var i = 0; i < values.values.length; i++) {
      if (input == values.values[i]) {
        match = i;
        break;
      }
    }
    
    if (match == -1) {
      if (elseNode == null) {
        throw Exception("SwitchExpression: no match found and no else case provided");
      } else {
        elseNode.complete(const NullVal());
        for (var element in outputs) {
          element.skip();
        }
        return BoolVal(false);
      }
    }
    elseNode?.skip();
    
    if (match >= 0 && match < outputs.length) {
      outputs.forEachIndexed((i, element) {
        if (i == match) {
          element.complete(const NullVal());
        } else {
          element.skip();
        }
      });
      return BoolVal(true);
    } else {
      throw Exception(
        "SwitchExpression: index $match out of range for outputs of length ${outputs.length}",
      );
    }
  }
}

class BranchMacro extends EdgeMacro {
  @override
  final String name = "branch";
  @override
  final String package = "lang";
  @override
  void execute(MacroContext context, EdgeMacroInvocationAst ast) {
    final obj = ast.value.orNull().requireObj();
    final on = obj.require("on").requireNodeIdUnwrap();
    final branches = obj.require("branches").requireNodeIdListUnwrap();
    final elseBranch = obj["else"]?.requireNodeIdUnwrap();

    for (var element in [...branches, if (elseBranch != null) elseBranch]) {
      context.scope.visitEdgeDeclaration(
        context.graph,
        EdgeDeclarationAst(
          element,
          [],
          [],
          [AnnotationAst("noSchedule", null)],
        ),
      );
    }

    context.scope.visitEdgeDeclaration(context.graph, EdgeDeclarationAst(const VoidNodeId(), [on], [
      TransformInvokeAst("_branch", obj.keepKeys(const ["branches", "values", "else"]))
    ], []));
  }
}