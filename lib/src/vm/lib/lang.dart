import 'package:vils/src/value.dart';
import 'package:vils/src/vm/machine.dart';

final stdLangLib = VLibrary(
  functions: [
    VFunction(ValueExecutable(), name: "value", package: "lang"),
    VFunction(ConcatExecutable(), name: "concat", package: "lang"),
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
      ...context.arg.asList()
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