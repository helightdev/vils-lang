// Generated from grammar/VilsParser.g4 by ANTLR 4.13.2
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'VilsParserVisitor.dart';
import 'VilsParserBaseVisitor.dart';
const int RULE_compilationUnit = 0, RULE_topLevelStatement = 1, RULE_graphStatement = 2, 
          RULE_subroutine = 3, RULE_block = 4, RULE_edgeDeclaration = 5, 
          RULE_transformation = 6, RULE_transformInvocation = 7, RULE_transformExecute = 8, 
          RULE_edgeMacroInvocation = 9, RULE_nodeRef = 10, RULE_executableRef = 11, 
          RULE_nodeRefList = 12, RULE_annotation = 13, RULE_value = 14, 
          RULE_valueObj = 15, RULE_valueList = 16, RULE_valuePair = 17;
class VilsParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.13.2', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_BLOCK_BEGIN = 1, TOKEN_SUBROUTINE_BEGIN = 2, TOKEN_PSEUDO_INPUT = 3, 
                   TOKEN_PSEUDO_ARG = 4, TOKEN_PSEUDO_OUTPUT = 5, TOKEN_PSEUDO_VOID = 6, 
                   TOKEN_BANG = 7, TOKEN_QUESTION = 8, TOKEN_EQ = 9, TOKEN_DARR = 10, 
                   TOKEN_SARR = 11, TOKEN_TARR = 12, TOKEN_CHAIN = 13, TOKEN_PER = 14, 
                   TOKEN_DOT = 15, TOKEN_COMMA = 16, TOKEN_COLON = 17, TOKEN_AT = 18, 
                   TOKEN_LP = 19, TOKEN_RP = 20, TOKEN_LB = 21, TOKEN_RB = 22, 
                   TOKEN_LC = 23, TOKEN_RC = 24, TOKEN_IDENTIFIER = 25, 
                   TOKEN_NODE_IDENTIFIER = 26, TOKEN_NULL = 27, TOKEN_BOOLEAN = 28, 
                   TOKEN_STRING = 29, TOKEN_NUMBER = 30, TOKEN_WS = 31, 
                   TOKEN_BLOCK_HEADER_ID = 32, TOKEN_BLOCK_HEADER_END = 33, 
                   TOKEN_BLOCK_HEADER_WS = 34, TOKEN_BLOCK_LINE = 35, TOKEN_BLOCK_END = 36;

  @override
  final List<String> ruleNames = [
    'compilationUnit', 'topLevelStatement', 'graphStatement', 'subroutine', 
    'block', 'edgeDeclaration', 'transformation', 'transformInvocation', 
    'transformExecute', 'edgeMacroInvocation', 'nodeRef', 'executableRef', 
    'nodeRefList', 'annotation', 'value', 'valueObj', 'valueList', 'valuePair'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'%begin'", "'%subroutine'", "'\$in'", "'\$arg'", "'\$out'", 
      "'\$void'", "'!'", "'?'", "'='", "'=>'", "'->'", "'=|'", "'|'", "'%'", 
      "'.'", "','", "':'", "'@'", "'('", "')'", "'['", "']'", "'{'", "'}'", 
      null, null, "'null'", null, null, null, null, null, null, null, null, 
      "'%end'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, "BLOCK_BEGIN", "SUBROUTINE_BEGIN", "PSEUDO_INPUT", "PSEUDO_ARG", 
      "PSEUDO_OUTPUT", "PSEUDO_VOID", "BANG", "QUESTION", "EQ", "DARR", 
      "SARR", "TARR", "CHAIN", "PER", "DOT", "COMMA", "COLON", "AT", "LP", 
      "RP", "LB", "RB", "LC", "RC", "IDENTIFIER", "NODE_IDENTIFIER", "NULL", 
      "BOOLEAN", "STRING", "NUMBER", "WS", "BLOCK_HEADER_ID", "BLOCK_HEADER_END", 
      "BLOCK_HEADER_WS", "BLOCK_LINE", "BLOCK_END"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'VilsParser.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  VilsParser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  CompilationUnitContext compilationUnit() {
    dynamic _localctx = CompilationUnitContext(context, state);
    enterRule(_localctx, 0, RULE_compilationUnit);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 39;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 100925694) != 0)) {
        state = 36;
        topLevelStatement();
        state = 41;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 42;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  TopLevelStatementContext topLevelStatement() {
    dynamic _localctx = TopLevelStatementContext(context, state);
    enterRule(_localctx, 2, RULE_topLevelStatement);
    try {
      state = 47;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BLOCK_BEGIN:
        enterOuterAlt(_localctx, 1);
        state = 44;
        block();
        break;
      case TOKEN_SUBROUTINE_BEGIN:
        enterOuterAlt(_localctx, 2);
        state = 45;
        subroutine();
        break;
      case TOKEN_PSEUDO_INPUT:
      case TOKEN_PSEUDO_ARG:
      case TOKEN_PSEUDO_OUTPUT:
      case TOKEN_PSEUDO_VOID:
      case TOKEN_BANG:
      case TOKEN_AT:
      case TOKEN_IDENTIFIER:
      case TOKEN_NODE_IDENTIFIER:
        enterOuterAlt(_localctx, 3);
        state = 46;
        graphStatement();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  GraphStatementContext graphStatement() {
    dynamic _localctx = GraphStatementContext(context, state);
    enterRule(_localctx, 4, RULE_graphStatement);
    try {
      state = 51;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 2, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 49;
        edgeDeclaration();
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 50;
        edgeMacroInvocation();
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  SubroutineContext subroutine() {
    dynamic _localctx = SubroutineContext(context, state);
    enterRule(_localctx, 6, RULE_subroutine);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 53;
      match(TOKEN_SUBROUTINE_BEGIN);
      state = 54;
      match(TOKEN_IDENTIFIER);
      state = 58;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 3, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 55;
          graphStatement(); 
        }
        state = 60;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 3, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  BlockContext block() {
    dynamic _localctx = BlockContext(context, state);
    enterRule(_localctx, 8, RULE_block);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 61;
      match(TOKEN_BLOCK_BEGIN);
      state = 63; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 62;
        match(TOKEN_BLOCK_HEADER_ID);
        state = 65; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_BLOCK_HEADER_ID);
      state = 67;
      match(TOKEN_BLOCK_HEADER_END);
      state = 71;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_BLOCK_LINE) {
        state = 68;
        match(TOKEN_BLOCK_LINE);
        state = 73;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 74;
      match(TOKEN_BLOCK_END);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  EdgeDeclarationContext edgeDeclaration() {
    dynamic _localctx = EdgeDeclarationContext(context, state);
    enterRule(_localctx, 10, RULE_edgeDeclaration);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 79;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_AT) {
        state = 76;
        annotation();
        state = 81;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 82;
      nodeRefList();
      state = 83;
      match(TOKEN_DARR);
      state = 84;
      nodeRef(0);
      state = 88;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 7, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 85;
          transformation(); 
        }
        state = 90;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 7, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  TransformationContext transformation() {
    dynamic _localctx = TransformationContext(context, state);
    enterRule(_localctx, 12, RULE_transformation);
    int _la;
    try {
      state = 105;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 10, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 94;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_AT) {
          state = 91;
          annotation();
          state = 96;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 97;
        transformInvocation();
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 101;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_AT) {
          state = 98;
          annotation();
          state = 103;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 104;
        transformExecute();
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  TransformInvocationContext transformInvocation() {
    dynamic _localctx = TransformInvocationContext(context, state);
    enterRule(_localctx, 14, RULE_transformInvocation);
    try {
      enterOuterAlt(_localctx, 1);
      state = 107;
      match(TOKEN_CHAIN);
      state = 108;
      match(TOKEN_IDENTIFIER);
      state = 110;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 11, context)) {
      case 1:
        state = 109;
        value();
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  TransformExecuteContext transformExecute() {
    dynamic _localctx = TransformExecuteContext(context, state);
    enterRule(_localctx, 16, RULE_transformExecute);
    try {
      enterOuterAlt(_localctx, 1);
      state = 112;
      match(TOKEN_PER);
      state = 113;
      match(TOKEN_IDENTIFIER);
      state = 115;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 12, context)) {
      case 1:
        state = 114;
        value();
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  EdgeMacroInvocationContext edgeMacroInvocation() {
    dynamic _localctx = EdgeMacroInvocationContext(context, state);
    enterRule(_localctx, 18, RULE_edgeMacroInvocation);
    int _la;
    try {
      state = 137;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 16, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 120;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_AT) {
          state = 117;
          annotation();
          state = 122;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 123;
        match(TOKEN_BANG);
        state = 124;
        match(TOKEN_IDENTIFIER);
        state = 126;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 14, context)) {
        case 1:
          state = 125;
          value();
          break;
        }
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 131;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_AT) {
          state = 128;
          annotation();
          state = 133;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 134;
        match(TOKEN_BANG);
        state = 135;
        match(TOKEN_IDENTIFIER);
        state = 136;
        match(TOKEN_IDENTIFIER);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  NodeRefContext nodeRef([int _p = 0]) {
    final _parentctx = context;
    final _parentState = state;
    dynamic _localctx = NodeRefContext(context, _parentState);
    var _prevctx = _localctx;
    var _startState = 20;
    enterRecursionRule(_localctx, 20, RULE_nodeRef, _p);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 148;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_NODE_IDENTIFIER:
        state = 140;
        match(TOKEN_NODE_IDENTIFIER);
        break;
      case TOKEN_PSEUDO_INPUT:
        state = 141;
        match(TOKEN_PSEUDO_INPUT);
        break;
      case TOKEN_PSEUDO_ARG:
        state = 142;
        match(TOKEN_PSEUDO_ARG);
        break;
      case TOKEN_PSEUDO_OUTPUT:
        state = 143;
        match(TOKEN_PSEUDO_OUTPUT);
        break;
      case TOKEN_PSEUDO_VOID:
        state = 144;
        match(TOKEN_PSEUDO_VOID);
        break;
      case TOKEN_IDENTIFIER:
        state = 145;
        match(TOKEN_IDENTIFIER);
        state = 146;
        match(TOKEN_COLON);
        state = 147;
        nodeRef(1);
        break;
      default:
        throw NoViableAltException(this);
      }
      context!.stop = tokenStream.LT(-1);
      state = 155;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 18, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          _localctx = NodeRefContext(_parentctx, _parentState);
          pushNewRecursionContext(_localctx, _startState, RULE_nodeRef);
          state = 150;
          if (!(precpred(context, 2))) {
            throw FailedPredicateException(this, "precpred(context, 2)");
          }
          state = 151;
          match(TOKEN_AT);
          state = 152;
          match(TOKEN_NUMBER); 
        }
        state = 157;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 18, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      unrollRecursionContexts(_parentctx);
    }
    return _localctx;
  }

  ExecutableRefContext executableRef() {
    dynamic _localctx = ExecutableRefContext(context, state);
    enterRule(_localctx, 22, RULE_executableRef);
    try {
      enterOuterAlt(_localctx, 1);
      state = 158;
      match(TOKEN_DOT);
      state = 159;
      match(TOKEN_IDENTIFIER);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  NodeRefListContext nodeRefList() {
    dynamic _localctx = NodeRefListContext(context, state);
    enterRule(_localctx, 24, RULE_nodeRefList);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 161;
      nodeRef(0);
      state = 166;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_COMMA) {
        state = 162;
        match(TOKEN_COMMA);
        state = 163;
        nodeRef(0);
        state = 168;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AnnotationContext annotation() {
    dynamic _localctx = AnnotationContext(context, state);
    enterRule(_localctx, 26, RULE_annotation);
    int _la;
    try {
      state = 186;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 21, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 169;
        match(TOKEN_AT);
        state = 170;
        match(TOKEN_IDENTIFIER);
        state = 171;
        match(TOKEN_LP);
        state = 173;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 2124447864) != 0)) {
          state = 172;
          value();
        }

        state = 175;
        match(TOKEN_RP);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 176;
        match(TOKEN_AT);
        state = 177;
        match(TOKEN_IDENTIFIER);
        break;
      case 3:
        enterOuterAlt(_localctx, 3);
        state = 178;
        match(TOKEN_AT);
        state = 179;
        match(TOKEN_IDENTIFIER);
        state = 180;
        match(TOKEN_COLON);
        state = 181;
        value();
        break;
      case 4:
        enterOuterAlt(_localctx, 4);
        state = 182;
        match(TOKEN_AT);
        state = 183;
        match(TOKEN_IDENTIFIER);
        state = 184;
        match(TOKEN_COLON);
        state = 185;
        match(TOKEN_IDENTIFIER);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ValueContext value() {
    dynamic _localctx = ValueContext(context, state);
    enterRule(_localctx, 28, RULE_value);
    try {
      state = 196;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 1);
        state = 188;
        match(TOKEN_STRING);
        break;
      case TOKEN_NUMBER:
        enterOuterAlt(_localctx, 2);
        state = 189;
        match(TOKEN_NUMBER);
        break;
      case TOKEN_BOOLEAN:
        enterOuterAlt(_localctx, 3);
        state = 190;
        match(TOKEN_BOOLEAN);
        break;
      case TOKEN_NULL:
        enterOuterAlt(_localctx, 4);
        state = 191;
        match(TOKEN_NULL);
        break;
      case TOKEN_PSEUDO_INPUT:
      case TOKEN_PSEUDO_ARG:
      case TOKEN_PSEUDO_OUTPUT:
      case TOKEN_PSEUDO_VOID:
      case TOKEN_IDENTIFIER:
      case TOKEN_NODE_IDENTIFIER:
        enterOuterAlt(_localctx, 5);
        state = 192;
        nodeRef(0);
        break;
      case TOKEN_DOT:
        enterOuterAlt(_localctx, 6);
        state = 193;
        executableRef();
        break;
      case TOKEN_LB:
        enterOuterAlt(_localctx, 7);
        state = 194;
        valueList();
        break;
      case TOKEN_LC:
        enterOuterAlt(_localctx, 8);
        state = 195;
        valueObj();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ValueObjContext valueObj() {
    dynamic _localctx = ValueObjContext(context, state);
    enterRule(_localctx, 30, RULE_valueObj);
    int _la;
    try {
      state = 219;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 26, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 198;
        match(TOKEN_LC);
        state = 199;
        match(TOKEN_RC);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 200;
        match(TOKEN_LC);
        state = 201;
        valuePair();
        state = 203;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_COMMA) {
          state = 202;
          match(TOKEN_COMMA);
        }

        state = 205;
        match(TOKEN_RC);
        break;
      case 3:
        enterOuterAlt(_localctx, 3);
        state = 207;
        match(TOKEN_LC);
        state = 208;
        valuePair();
        state = 213; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        do {
          state = 210;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_COMMA) {
            state = 209;
            match(TOKEN_COMMA);
          }

          state = 212;
          valuePair();
          state = 215; 
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        } while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 570490880) != 0));
        state = 217;
        match(TOKEN_RC);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ValueListContext valueList() {
    dynamic _localctx = ValueListContext(context, state);
    enterRule(_localctx, 32, RULE_valueList);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 221;
      match(TOKEN_LB);
      state = 230;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 2124447864) != 0)) {
        state = 222;
        value();
        state = 227;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_COMMA) {
          state = 223;
          match(TOKEN_COMMA);
          state = 224;
          value();
          state = 229;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
      }

      state = 232;
      match(TOKEN_RB);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ValuePairContext valuePair() {
    dynamic _localctx = ValuePairContext(context, state);
    enterRule(_localctx, 34, RULE_valuePair);
    try {
      state = 240;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_IDENTIFIER:
        enterOuterAlt(_localctx, 1);
        state = 234;
        match(TOKEN_IDENTIFIER);
        state = 235;
        match(TOKEN_COLON);
        state = 236;
        value();
        break;
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 2);
        state = 237;
        match(TOKEN_STRING);
        state = 238;
        match(TOKEN_COLON);
        state = 239;
        value();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  @override
  bool sempred(RuleContext? _localctx, int ruleIndex, int predIndex) {
    switch (ruleIndex) {
    case 10:
      return _nodeRef_sempred(_localctx as NodeRefContext?, predIndex);
    }
    return true;
  }
  bool _nodeRef_sempred(dynamic _localctx, int predIndex) {
    switch (predIndex) {
      case 0: return precpred(context, 2);
    }
    return true;
  }

  static const List<int> _serializedATN = [
      4,1,36,243,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,1,0,5,0,38,8,0,10,0,12,0,41,
      9,0,1,0,1,0,1,1,1,1,1,1,3,1,48,8,1,1,2,1,2,3,2,52,8,2,1,3,1,3,1,3,
      5,3,57,8,3,10,3,12,3,60,9,3,1,4,1,4,4,4,64,8,4,11,4,12,4,65,1,4,1,
      4,5,4,70,8,4,10,4,12,4,73,9,4,1,4,1,4,1,5,5,5,78,8,5,10,5,12,5,81,
      9,5,1,5,1,5,1,5,1,5,5,5,87,8,5,10,5,12,5,90,9,5,1,6,5,6,93,8,6,10,
      6,12,6,96,9,6,1,6,1,6,5,6,100,8,6,10,6,12,6,103,9,6,1,6,3,6,106,8,
      6,1,7,1,7,1,7,3,7,111,8,7,1,8,1,8,1,8,3,8,116,8,8,1,9,5,9,119,8,9,
      10,9,12,9,122,9,9,1,9,1,9,1,9,3,9,127,8,9,1,9,5,9,130,8,9,10,9,12,
      9,133,9,9,1,9,1,9,1,9,3,9,138,8,9,1,10,1,10,1,10,1,10,1,10,1,10,1,
      10,1,10,1,10,3,10,149,8,10,1,10,1,10,1,10,5,10,154,8,10,10,10,12,10,
      157,9,10,1,11,1,11,1,11,1,12,1,12,1,12,5,12,165,8,12,10,12,12,12,168,
      9,12,1,13,1,13,1,13,1,13,3,13,174,8,13,1,13,1,13,1,13,1,13,1,13,1,
      13,1,13,1,13,1,13,1,13,1,13,3,13,187,8,13,1,14,1,14,1,14,1,14,1,14,
      1,14,1,14,1,14,3,14,197,8,14,1,15,1,15,1,15,1,15,1,15,3,15,204,8,15,
      1,15,1,15,1,15,1,15,1,15,3,15,211,8,15,1,15,4,15,214,8,15,11,15,12,
      15,215,1,15,1,15,3,15,220,8,15,1,16,1,16,1,16,1,16,5,16,226,8,16,10,
      16,12,16,229,9,16,3,16,231,8,16,1,16,1,16,1,17,1,17,1,17,1,17,1,17,
      1,17,3,17,241,8,17,1,17,0,1,20,18,0,2,4,6,8,10,12,14,16,18,20,22,24,
      26,28,30,32,34,0,0,268,0,39,1,0,0,0,2,47,1,0,0,0,4,51,1,0,0,0,6,53,
      1,0,0,0,8,61,1,0,0,0,10,79,1,0,0,0,12,105,1,0,0,0,14,107,1,0,0,0,16,
      112,1,0,0,0,18,137,1,0,0,0,20,148,1,0,0,0,22,158,1,0,0,0,24,161,1,
      0,0,0,26,186,1,0,0,0,28,196,1,0,0,0,30,219,1,0,0,0,32,221,1,0,0,0,
      34,240,1,0,0,0,36,38,3,2,1,0,37,36,1,0,0,0,38,41,1,0,0,0,39,37,1,0,
      0,0,39,40,1,0,0,0,40,42,1,0,0,0,41,39,1,0,0,0,42,43,5,0,0,1,43,1,1,
      0,0,0,44,48,3,8,4,0,45,48,3,6,3,0,46,48,3,4,2,0,47,44,1,0,0,0,47,45,
      1,0,0,0,47,46,1,0,0,0,48,3,1,0,0,0,49,52,3,10,5,0,50,52,3,18,9,0,51,
      49,1,0,0,0,51,50,1,0,0,0,52,5,1,0,0,0,53,54,5,2,0,0,54,58,5,25,0,0,
      55,57,3,4,2,0,56,55,1,0,0,0,57,60,1,0,0,0,58,56,1,0,0,0,58,59,1,0,
      0,0,59,7,1,0,0,0,60,58,1,0,0,0,61,63,5,1,0,0,62,64,5,32,0,0,63,62,
      1,0,0,0,64,65,1,0,0,0,65,63,1,0,0,0,65,66,1,0,0,0,66,67,1,0,0,0,67,
      71,5,33,0,0,68,70,5,35,0,0,69,68,1,0,0,0,70,73,1,0,0,0,71,69,1,0,0,
      0,71,72,1,0,0,0,72,74,1,0,0,0,73,71,1,0,0,0,74,75,5,36,0,0,75,9,1,
      0,0,0,76,78,3,26,13,0,77,76,1,0,0,0,78,81,1,0,0,0,79,77,1,0,0,0,79,
      80,1,0,0,0,80,82,1,0,0,0,81,79,1,0,0,0,82,83,3,24,12,0,83,84,5,10,
      0,0,84,88,3,20,10,0,85,87,3,12,6,0,86,85,1,0,0,0,87,90,1,0,0,0,88,
      86,1,0,0,0,88,89,1,0,0,0,89,11,1,0,0,0,90,88,1,0,0,0,91,93,3,26,13,
      0,92,91,1,0,0,0,93,96,1,0,0,0,94,92,1,0,0,0,94,95,1,0,0,0,95,97,1,
      0,0,0,96,94,1,0,0,0,97,106,3,14,7,0,98,100,3,26,13,0,99,98,1,0,0,0,
      100,103,1,0,0,0,101,99,1,0,0,0,101,102,1,0,0,0,102,104,1,0,0,0,103,
      101,1,0,0,0,104,106,3,16,8,0,105,94,1,0,0,0,105,101,1,0,0,0,106,13,
      1,0,0,0,107,108,5,13,0,0,108,110,5,25,0,0,109,111,3,28,14,0,110,109,
      1,0,0,0,110,111,1,0,0,0,111,15,1,0,0,0,112,113,5,14,0,0,113,115,5,
      25,0,0,114,116,3,28,14,0,115,114,1,0,0,0,115,116,1,0,0,0,116,17,1,
      0,0,0,117,119,3,26,13,0,118,117,1,0,0,0,119,122,1,0,0,0,120,118,1,
      0,0,0,120,121,1,0,0,0,121,123,1,0,0,0,122,120,1,0,0,0,123,124,5,7,
      0,0,124,126,5,25,0,0,125,127,3,28,14,0,126,125,1,0,0,0,126,127,1,0,
      0,0,127,138,1,0,0,0,128,130,3,26,13,0,129,128,1,0,0,0,130,133,1,0,
      0,0,131,129,1,0,0,0,131,132,1,0,0,0,132,134,1,0,0,0,133,131,1,0,0,
      0,134,135,5,7,0,0,135,136,5,25,0,0,136,138,5,25,0,0,137,120,1,0,0,
      0,137,131,1,0,0,0,138,19,1,0,0,0,139,140,6,10,-1,0,140,149,5,26,0,
      0,141,149,5,3,0,0,142,149,5,4,0,0,143,149,5,5,0,0,144,149,5,6,0,0,
      145,146,5,25,0,0,146,147,5,17,0,0,147,149,3,20,10,1,148,139,1,0,0,
      0,148,141,1,0,0,0,148,142,1,0,0,0,148,143,1,0,0,0,148,144,1,0,0,0,
      148,145,1,0,0,0,149,155,1,0,0,0,150,151,10,2,0,0,151,152,5,18,0,0,
      152,154,5,30,0,0,153,150,1,0,0,0,154,157,1,0,0,0,155,153,1,0,0,0,155,
      156,1,0,0,0,156,21,1,0,0,0,157,155,1,0,0,0,158,159,5,15,0,0,159,160,
      5,25,0,0,160,23,1,0,0,0,161,166,3,20,10,0,162,163,5,16,0,0,163,165,
      3,20,10,0,164,162,1,0,0,0,165,168,1,0,0,0,166,164,1,0,0,0,166,167,
      1,0,0,0,167,25,1,0,0,0,168,166,1,0,0,0,169,170,5,18,0,0,170,171,5,
      25,0,0,171,173,5,19,0,0,172,174,3,28,14,0,173,172,1,0,0,0,173,174,
      1,0,0,0,174,175,1,0,0,0,175,187,5,20,0,0,176,177,5,18,0,0,177,187,
      5,25,0,0,178,179,5,18,0,0,179,180,5,25,0,0,180,181,5,17,0,0,181,187,
      3,28,14,0,182,183,5,18,0,0,183,184,5,25,0,0,184,185,5,17,0,0,185,187,
      5,25,0,0,186,169,1,0,0,0,186,176,1,0,0,0,186,178,1,0,0,0,186,182,1,
      0,0,0,187,27,1,0,0,0,188,197,5,29,0,0,189,197,5,30,0,0,190,197,5,28,
      0,0,191,197,5,27,0,0,192,197,3,20,10,0,193,197,3,22,11,0,194,197,3,
      32,16,0,195,197,3,30,15,0,196,188,1,0,0,0,196,189,1,0,0,0,196,190,
      1,0,0,0,196,191,1,0,0,0,196,192,1,0,0,0,196,193,1,0,0,0,196,194,1,
      0,0,0,196,195,1,0,0,0,197,29,1,0,0,0,198,199,5,23,0,0,199,220,5,24,
      0,0,200,201,5,23,0,0,201,203,3,34,17,0,202,204,5,16,0,0,203,202,1,
      0,0,0,203,204,1,0,0,0,204,205,1,0,0,0,205,206,5,24,0,0,206,220,1,0,
      0,0,207,208,5,23,0,0,208,213,3,34,17,0,209,211,5,16,0,0,210,209,1,
      0,0,0,210,211,1,0,0,0,211,212,1,0,0,0,212,214,3,34,17,0,213,210,1,
      0,0,0,214,215,1,0,0,0,215,213,1,0,0,0,215,216,1,0,0,0,216,217,1,0,
      0,0,217,218,5,24,0,0,218,220,1,0,0,0,219,198,1,0,0,0,219,200,1,0,0,
      0,219,207,1,0,0,0,220,31,1,0,0,0,221,230,5,21,0,0,222,227,3,28,14,
      0,223,224,5,16,0,0,224,226,3,28,14,0,225,223,1,0,0,0,226,229,1,0,0,
      0,227,225,1,0,0,0,227,228,1,0,0,0,228,231,1,0,0,0,229,227,1,0,0,0,
      230,222,1,0,0,0,230,231,1,0,0,0,231,232,1,0,0,0,232,233,5,22,0,0,233,
      33,1,0,0,0,234,235,5,25,0,0,235,236,5,17,0,0,236,241,3,28,14,0,237,
      238,5,29,0,0,238,239,5,17,0,0,239,241,3,28,14,0,240,234,1,0,0,0,240,
      237,1,0,0,0,241,35,1,0,0,0,30,39,47,51,58,65,71,79,88,94,101,105,110,
      115,120,126,131,137,148,155,166,173,186,196,203,210,215,219,227,230,
      240
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class CompilationUnitContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(VilsParser.TOKEN_EOF, 0);
  List<TopLevelStatementContext> topLevelStatements() => getRuleContexts<TopLevelStatementContext>();
  TopLevelStatementContext? topLevelStatement(int i) => getRuleContext<TopLevelStatementContext>(i);
  CompilationUnitContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_compilationUnit;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitCompilationUnit(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class TopLevelStatementContext extends ParserRuleContext {
  BlockContext? block() => getRuleContext<BlockContext>(0);
  SubroutineContext? subroutine() => getRuleContext<SubroutineContext>(0);
  GraphStatementContext? graphStatement() => getRuleContext<GraphStatementContext>(0);
  TopLevelStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_topLevelStatement;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitTopLevelStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class GraphStatementContext extends ParserRuleContext {
  EdgeDeclarationContext? edgeDeclaration() => getRuleContext<EdgeDeclarationContext>(0);
  EdgeMacroInvocationContext? edgeMacroInvocation() => getRuleContext<EdgeMacroInvocationContext>(0);
  GraphStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_graphStatement;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitGraphStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class SubroutineContext extends ParserRuleContext {
  TerminalNode? SUBROUTINE_BEGIN() => getToken(VilsParser.TOKEN_SUBROUTINE_BEGIN, 0);
  TerminalNode? IDENTIFIER() => getToken(VilsParser.TOKEN_IDENTIFIER, 0);
  List<GraphStatementContext> graphStatements() => getRuleContexts<GraphStatementContext>();
  GraphStatementContext? graphStatement(int i) => getRuleContext<GraphStatementContext>(i);
  SubroutineContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_subroutine;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitSubroutine(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BlockContext extends ParserRuleContext {
  TerminalNode? BLOCK_BEGIN() => getToken(VilsParser.TOKEN_BLOCK_BEGIN, 0);
  TerminalNode? BLOCK_HEADER_END() => getToken(VilsParser.TOKEN_BLOCK_HEADER_END, 0);
  TerminalNode? BLOCK_END() => getToken(VilsParser.TOKEN_BLOCK_END, 0);
  List<TerminalNode> BLOCK_HEADER_IDs() => getTokens(VilsParser.TOKEN_BLOCK_HEADER_ID);
  TerminalNode? BLOCK_HEADER_ID(int i) => getToken(VilsParser.TOKEN_BLOCK_HEADER_ID, i);
  List<TerminalNode> BLOCK_LINEs() => getTokens(VilsParser.TOKEN_BLOCK_LINE);
  TerminalNode? BLOCK_LINE(int i) => getToken(VilsParser.TOKEN_BLOCK_LINE, i);
  BlockContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_block;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitBlock(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class EdgeDeclarationContext extends ParserRuleContext {
  NodeRefListContext? nodeRefList() => getRuleContext<NodeRefListContext>(0);
  TerminalNode? DARR() => getToken(VilsParser.TOKEN_DARR, 0);
  NodeRefContext? nodeRef() => getRuleContext<NodeRefContext>(0);
  List<AnnotationContext> annotations() => getRuleContexts<AnnotationContext>();
  AnnotationContext? annotation(int i) => getRuleContext<AnnotationContext>(i);
  List<TransformationContext> transformations() => getRuleContexts<TransformationContext>();
  TransformationContext? transformation(int i) => getRuleContext<TransformationContext>(i);
  EdgeDeclarationContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_edgeDeclaration;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitEdgeDeclaration(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class TransformationContext extends ParserRuleContext {
  TransformInvocationContext? transformInvocation() => getRuleContext<TransformInvocationContext>(0);
  List<AnnotationContext> annotations() => getRuleContexts<AnnotationContext>();
  AnnotationContext? annotation(int i) => getRuleContext<AnnotationContext>(i);
  TransformExecuteContext? transformExecute() => getRuleContext<TransformExecuteContext>(0);
  TransformationContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_transformation;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitTransformation(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class TransformInvocationContext extends ParserRuleContext {
  TerminalNode? CHAIN() => getToken(VilsParser.TOKEN_CHAIN, 0);
  TerminalNode? IDENTIFIER() => getToken(VilsParser.TOKEN_IDENTIFIER, 0);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  TransformInvocationContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_transformInvocation;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitTransformInvocation(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class TransformExecuteContext extends ParserRuleContext {
  TerminalNode? PER() => getToken(VilsParser.TOKEN_PER, 0);
  TerminalNode? IDENTIFIER() => getToken(VilsParser.TOKEN_IDENTIFIER, 0);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  TransformExecuteContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_transformExecute;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitTransformExecute(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class EdgeMacroInvocationContext extends ParserRuleContext {
  TerminalNode? BANG() => getToken(VilsParser.TOKEN_BANG, 0);
  List<TerminalNode> IDENTIFIERs() => getTokens(VilsParser.TOKEN_IDENTIFIER);
  TerminalNode? IDENTIFIER(int i) => getToken(VilsParser.TOKEN_IDENTIFIER, i);
  List<AnnotationContext> annotations() => getRuleContexts<AnnotationContext>();
  AnnotationContext? annotation(int i) => getRuleContext<AnnotationContext>(i);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  EdgeMacroInvocationContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_edgeMacroInvocation;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitEdgeMacroInvocation(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class NodeRefContext extends ParserRuleContext {
  TerminalNode? NODE_IDENTIFIER() => getToken(VilsParser.TOKEN_NODE_IDENTIFIER, 0);
  TerminalNode? PSEUDO_INPUT() => getToken(VilsParser.TOKEN_PSEUDO_INPUT, 0);
  TerminalNode? PSEUDO_ARG() => getToken(VilsParser.TOKEN_PSEUDO_ARG, 0);
  TerminalNode? PSEUDO_OUTPUT() => getToken(VilsParser.TOKEN_PSEUDO_OUTPUT, 0);
  TerminalNode? PSEUDO_VOID() => getToken(VilsParser.TOKEN_PSEUDO_VOID, 0);
  TerminalNode? IDENTIFIER() => getToken(VilsParser.TOKEN_IDENTIFIER, 0);
  TerminalNode? COLON() => getToken(VilsParser.TOKEN_COLON, 0);
  NodeRefContext? nodeRef() => getRuleContext<NodeRefContext>(0);
  TerminalNode? AT() => getToken(VilsParser.TOKEN_AT, 0);
  TerminalNode? NUMBER() => getToken(VilsParser.TOKEN_NUMBER, 0);
  NodeRefContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_nodeRef;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitNodeRef(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExecutableRefContext extends ParserRuleContext {
  TerminalNode? DOT() => getToken(VilsParser.TOKEN_DOT, 0);
  TerminalNode? IDENTIFIER() => getToken(VilsParser.TOKEN_IDENTIFIER, 0);
  ExecutableRefContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_executableRef;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitExecutableRef(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class NodeRefListContext extends ParserRuleContext {
  List<NodeRefContext> nodeRefs() => getRuleContexts<NodeRefContext>();
  NodeRefContext? nodeRef(int i) => getRuleContext<NodeRefContext>(i);
  List<TerminalNode> COMMAs() => getTokens(VilsParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(VilsParser.TOKEN_COMMA, i);
  NodeRefListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_nodeRefList;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitNodeRefList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class AnnotationContext extends ParserRuleContext {
  TerminalNode? AT() => getToken(VilsParser.TOKEN_AT, 0);
  List<TerminalNode> IDENTIFIERs() => getTokens(VilsParser.TOKEN_IDENTIFIER);
  TerminalNode? IDENTIFIER(int i) => getToken(VilsParser.TOKEN_IDENTIFIER, i);
  TerminalNode? LP() => getToken(VilsParser.TOKEN_LP, 0);
  TerminalNode? RP() => getToken(VilsParser.TOKEN_RP, 0);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  TerminalNode? COLON() => getToken(VilsParser.TOKEN_COLON, 0);
  AnnotationContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_annotation;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitAnnotation(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ValueContext extends ParserRuleContext {
  TerminalNode? STRING() => getToken(VilsParser.TOKEN_STRING, 0);
  TerminalNode? NUMBER() => getToken(VilsParser.TOKEN_NUMBER, 0);
  TerminalNode? BOOLEAN() => getToken(VilsParser.TOKEN_BOOLEAN, 0);
  TerminalNode? NULL() => getToken(VilsParser.TOKEN_NULL, 0);
  NodeRefContext? nodeRef() => getRuleContext<NodeRefContext>(0);
  ExecutableRefContext? executableRef() => getRuleContext<ExecutableRefContext>(0);
  ValueListContext? valueList() => getRuleContext<ValueListContext>(0);
  ValueObjContext? valueObj() => getRuleContext<ValueObjContext>(0);
  ValueContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_value;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitValue(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ValueObjContext extends ParserRuleContext {
  TerminalNode? LC() => getToken(VilsParser.TOKEN_LC, 0);
  TerminalNode? RC() => getToken(VilsParser.TOKEN_RC, 0);
  List<ValuePairContext> valuePairs() => getRuleContexts<ValuePairContext>();
  ValuePairContext? valuePair(int i) => getRuleContext<ValuePairContext>(i);
  List<TerminalNode> COMMAs() => getTokens(VilsParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(VilsParser.TOKEN_COMMA, i);
  ValueObjContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_valueObj;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitValueObj(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ValueListContext extends ParserRuleContext {
  TerminalNode? LB() => getToken(VilsParser.TOKEN_LB, 0);
  TerminalNode? RB() => getToken(VilsParser.TOKEN_RB, 0);
  List<ValueContext> values() => getRuleContexts<ValueContext>();
  ValueContext? value(int i) => getRuleContext<ValueContext>(i);
  List<TerminalNode> COMMAs() => getTokens(VilsParser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(VilsParser.TOKEN_COMMA, i);
  ValueListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_valueList;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitValueList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ValuePairContext extends ParserRuleContext {
  TerminalNode? IDENTIFIER() => getToken(VilsParser.TOKEN_IDENTIFIER, 0);
  TerminalNode? COLON() => getToken(VilsParser.TOKEN_COLON, 0);
  ValueContext? value() => getRuleContext<ValueContext>(0);
  TerminalNode? STRING() => getToken(VilsParser.TOKEN_STRING, 0);
  ValuePairContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_valuePair;
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is VilsParserVisitor<T>) {
     return visitor.visitValuePair(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

