#!/bin/bash
antlr4 -Dlanguage=Dart -Xexact-output-dir -o lib/src/parser/gen grammar/VilsLexer.g4
antlr4 -Dlanguage=Dart -Xexact-output-dir -no-listener -visitor -o lib/src/parser/gen grammar/VilsParser.g4