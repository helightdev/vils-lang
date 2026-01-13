import 'package:vils_toolchain/src/loader.dart';
import 'package:vils_toolchain/src/parser/parser.dart';
import 'package:vils_toolchain/src/value.dart';
import 'package:vils_toolchain/src/vm/library.dart';
import 'package:vils_toolchain/src/vm/machine.dart';

void main() async {
  var machine = VMachine();
  machine.load(stdCoreLib);
  var scope = machine.createCompilationScope();

  var ast = parseUnitAst(r"""
$in, #1 => $out
  | sum
  | concat " Apples!"
  
$void => #1
  | value 10
  | sum 20

$in => #switchIndex
  | value 1

!branch {
  on: #switchIndex,
  values: [0, 1, 2],
  branches: [#s0, #s1, #s2]
  else: #sElse
}
""");
  scope.visitCompilationUnit(ast);

  loadGraphIntoMachine(machine, scope.mainGraph);
  //machine.debugPrint();
  final result = await machine.execute(input: 10.toVal());
  final result2 = await machine.execute(input: 20.toVal());
  //machine.debugPrint();

  print("Result: ${result?.resolve().toNative()}");
  print("Result2: ${result2?.resolve().toNative()}");
}
