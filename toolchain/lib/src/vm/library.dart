import 'package:vils_toolchain/src/vm/compiler/macro.dart';
import 'package:vils_toolchain/src/vm/function.dart';
import 'package:vils_toolchain/src/vm/lib/lang.dart';
import 'package:vils_toolchain/src/vm/lib/math.dart';

class VLibrary {
  List<VFunction> functions;
  List<VMacro> macros;

  VLibrary({this.functions = const [], this.macros = const []});

  static VLibrary merge(List<VLibrary> libraries) {
    var allFunctions = <VFunction>[];
    var allMacros = <VMacro>[];
    for (var library in libraries) {
      allFunctions.addAll(library.functions);
    }
    for (var library in libraries) {
      allMacros.addAll(library.macros);
    }
    return VLibrary(functions: allFunctions, macros: allMacros);
  }
}

final stdCoreLib = VLibrary.merge([stdLangLib, stdMathLib]);