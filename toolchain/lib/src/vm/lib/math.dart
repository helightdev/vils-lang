import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

final stdMathLib = VLibrary(
  functions: [
    VFunction(SumExecutable(), name: "sum", package: "math"),
    VFunction(DifferenceExecutable(), name: "difference", package: "math"),
    VFunction(ProductExecutable(), name: "product", package: "math"),
    VFunction(QuotientExecutable(), name: "quotient", package: "math"),
  ]
);

class SumExecutable extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    var list = _numList(context);
    var sum = 0.0;
    for (var item in list) {
      sum += item;
    }
    return NumVal(sum);
  }
}

class DifferenceExecutable extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    var list = _numList(context);
    if (list.isEmpty) return NumVal(0.0);
    if (list.length == 1) return NumVal(list.first);
    var result = list.first;
    for (var item in list.skip(1)) {
      result -= item;
    }
    return NumVal(result);
  }
}

class ProductExecutable extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    var list = _numList(context);
    var product = 1.0;
    for (var item in list) {
      product *= item;
    }
    return NumVal(product);
  }
}

class QuotientExecutable extends VExecutable {
  @override
  Val execute(VExecutableContext context) {
    var list = _numList(context);
    if (list.isEmpty) return const NullVal();
    if (list.length == 1) return NumVal(list.first);
    var result = list.first;
    for (var item in list.skip(1)) {
      if (item == 0.0) return const NullVal();
      result /= item;
    }
    return NumVal(result);
  }
}

List<double> _numList(VExecutableContext context, {bool useArg = true}) => [
  ...context.input.asList(),
  if (useArg) ...context.arg.asList(),
].map((e) => e.asNumber()).nonNulls.toList();
