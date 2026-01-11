import 'package:vils/src/loader.dart';
import 'package:vils/src/parser/parser.dart';
import 'package:vils/src/value.dart';
import 'package:vils/src/vm/machine.dart';
import 'package:vils/vils.dart';

void main() async {
  var machine = VMachine();
  machine.load(stdCoreLib);

  var ast = parseUnitAst(r"""
$in, #1 => $out
  | sum
  | concat " Apples!"
  
$void => #1
  | value 10
  | sum 20
    
#1 => $void @stack:iar | concat "Something"
#1 => $void | concat "Another"

$void => $void | value .test  
$void => $void | value $in@0 
  
%begin test test
Example
%end
""");
  var graph = CompilationNodeGraph.fromAst(ast);
  loadGraphIntoMachine(machine, graph);
  //machine.debugPrint();
  final result = await machine.execute(input: 10.toVal());
  final result2 = await machine.execute(input: 20.toVal());
  print("----------------------------------------------------");
  //machine.debugPrint();

  print("Result: ${result?.resolve().toNative()}");
  print("Result2: ${result2?.resolve().toNative()}");
}

