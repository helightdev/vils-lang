// Generated from grammar/VilsParser.g4 by ANTLR 4.13.2
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'VilsParserVisitor.dart';
import 'VilsParserBaseVisitor.dart';
const int RULE_compilationUnit = 0, RULE_topLevelStatement = 1, RULE_block = 2, 
          RULE_edgeDeclaration = 3, RULE_transformation = 4, RULE_transformInvocation = 5, 
          RULE_transformExecute = 6, RULE_edgeMacroInvocation = 7, RULE_nodeRef = 8, 
          RULE_executableRef = 9, RULE_nodeRefList = 10, RULE_annotation = 11, 
          RULE_value = 12, RULE_valueObj = 13, RULE_valueList = 14, RULE_valuePair = 15;
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
    'compilationUnit', 'topLevelStatement', 'block', 'edgeDeclaration', 
    'transformation', 'transformInvocation', 'transformExecute', 'edgeMacroInvocation', 
    'nodeRef', 'executableRef', 'nodeRefList', 'annotation', 'value', 'valueObj', 
    'valueList', 'valuePair'
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
      state = 35;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 100663546) != 0)) {
        state = 32;
        topLevelStatement();
        state = 37;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 38;
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
      state = 43;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BLOCK_BEGIN:
        enterOuterAlt(_localctx, 1);
        state = 40;
        block();
        break;
      case TOKEN_PSEUDO_INPUT:
      case TOKEN_PSEUDO_ARG:
      case TOKEN_PSEUDO_OUTPUT:
      case TOKEN_PSEUDO_VOID:
      case TOKEN_IDENTIFIER:
      case TOKEN_NODE_IDENTIFIER:
        enterOuterAlt(_localctx, 2);
        state = 41;
        edgeDeclaration();
        break;
      case TOKEN_BANG:
        enterOuterAlt(_localctx, 3);
        state = 42;
        edgeMacroInvocation();
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

  BlockContext block() {
    dynamic _localctx = BlockContext(context, state);
    enterRule(_localctx, 4, RULE_block);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 45;
      match(TOKEN_BLOCK_BEGIN);
      state = 47; 
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      do {
        state = 46;
        match(TOKEN_BLOCK_HEADER_ID);
        state = 49; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      } while (_la == TOKEN_BLOCK_HEADER_ID);
      state = 51;
      match(TOKEN_BLOCK_HEADER_END);
      state = 55;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_BLOCK_LINE) {
        state = 52;
        match(TOKEN_BLOCK_LINE);
        state = 57;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 58;
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
    enterRule(_localctx, 6, RULE_edgeDeclaration);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 60;
      nodeRefList();
      state = 61;
      match(TOKEN_DARR);
      state = 62;
      nodeRef(0);
      state = 66;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 286720) != 0)) {
        state = 63;
        transformation();
        state = 68;
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

  TransformationContext transformation() {
    dynamic _localctx = TransformationContext(context, state);
    enterRule(_localctx, 8, RULE_transformation);
    int _la;
    try {
      state = 83;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 7, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 72;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_AT) {
          state = 69;
          annotation();
          state = 74;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 75;
        transformInvocation();
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
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
    enterRule(_localctx, 10, RULE_transformInvocation);
    try {
      enterOuterAlt(_localctx, 1);
      state = 85;
      match(TOKEN_CHAIN);
      state = 86;
      match(TOKEN_IDENTIFIER);
      state = 88;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 8, context)) {
      case 1:
        state = 87;
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
    enterRule(_localctx, 12, RULE_transformExecute);
    try {
      enterOuterAlt(_localctx, 1);
      state = 90;
      match(TOKEN_PER);
      state = 91;
      match(TOKEN_IDENTIFIER);
      state = 93;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 9, context)) {
      case 1:
        state = 92;
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
    enterRule(_localctx, 14, RULE_edgeMacroInvocation);
    try {
      state = 103;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 11, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 95;
        match(TOKEN_BANG);
        state = 96;
        match(TOKEN_IDENTIFIER);
        state = 98;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 10, context)) {
        case 1:
          state = 97;
          value();
          break;
        }
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 100;
        match(TOKEN_BANG);
        state = 101;
        match(TOKEN_IDENTIFIER);
        state = 102;
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
    var _startState = 16;
    enterRecursionRule(_localctx, 16, RULE_nodeRef, _p);
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 114;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_NODE_IDENTIFIER:
        state = 106;
        match(TOKEN_NODE_IDENTIFIER);
        break;
      case TOKEN_PSEUDO_INPUT:
        state = 107;
        match(TOKEN_PSEUDO_INPUT);
        break;
      case TOKEN_PSEUDO_ARG:
        state = 108;
        match(TOKEN_PSEUDO_ARG);
        break;
      case TOKEN_PSEUDO_OUTPUT:
        state = 109;
        match(TOKEN_PSEUDO_OUTPUT);
        break;
      case TOKEN_PSEUDO_VOID:
        state = 110;
        match(TOKEN_PSEUDO_VOID);
        break;
      case TOKEN_IDENTIFIER:
        state = 111;
        match(TOKEN_IDENTIFIER);
        state = 112;
        match(TOKEN_COLON);
        state = 113;
        nodeRef(1);
        break;
      default:
        throw NoViableAltException(this);
      }
      context!.stop = tokenStream.LT(-1);
      state = 121;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 13, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          _localctx = NodeRefContext(_parentctx, _parentState);
          pushNewRecursionContext(_localctx, _startState, RULE_nodeRef);
          state = 116;
          if (!(precpred(context, 2))) {
            throw FailedPredicateException(this, "precpred(context, 2)");
          }
          state = 117;
          match(TOKEN_AT);
          state = 118;
          match(TOKEN_NUMBER); 
        }
        state = 123;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 13, context);
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
    enterRule(_localctx, 18, RULE_executableRef);
    try {
      enterOuterAlt(_localctx, 1);
      state = 124;
      match(TOKEN_DOT);
      state = 125;
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
    enterRule(_localctx, 20, RULE_nodeRefList);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 127;
      nodeRef(0);
      state = 132;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_COMMA) {
        state = 128;
        match(TOKEN_COMMA);
        state = 129;
        nodeRef(0);
        state = 134;
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
    enterRule(_localctx, 22, RULE_annotation);
    int _la;
    try {
      state = 152;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 16, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 135;
        match(TOKEN_AT);
        state = 136;
        match(TOKEN_IDENTIFIER);
        state = 137;
        match(TOKEN_LP);
        state = 139;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 2124447864) != 0)) {
          state = 138;
          value();
        }

        state = 141;
        match(TOKEN_RP);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 142;
        match(TOKEN_AT);
        state = 143;
        match(TOKEN_IDENTIFIER);
        break;
      case 3:
        enterOuterAlt(_localctx, 3);
        state = 144;
        match(TOKEN_AT);
        state = 145;
        match(TOKEN_IDENTIFIER);
        state = 146;
        match(TOKEN_COLON);
        state = 147;
        value();
        break;
      case 4:
        enterOuterAlt(_localctx, 4);
        state = 148;
        match(TOKEN_AT);
        state = 149;
        match(TOKEN_IDENTIFIER);
        state = 150;
        match(TOKEN_COLON);
        state = 151;
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
    enterRule(_localctx, 24, RULE_value);
    try {
      state = 162;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 1);
        state = 154;
        match(TOKEN_STRING);
        break;
      case TOKEN_NUMBER:
        enterOuterAlt(_localctx, 2);
        state = 155;
        match(TOKEN_NUMBER);
        break;
      case TOKEN_BOOLEAN:
        enterOuterAlt(_localctx, 3);
        state = 156;
        match(TOKEN_BOOLEAN);
        break;
      case TOKEN_NULL:
        enterOuterAlt(_localctx, 4);
        state = 157;
        match(TOKEN_NULL);
        break;
      case TOKEN_PSEUDO_INPUT:
      case TOKEN_PSEUDO_ARG:
      case TOKEN_PSEUDO_OUTPUT:
      case TOKEN_PSEUDO_VOID:
      case TOKEN_IDENTIFIER:
      case TOKEN_NODE_IDENTIFIER:
        enterOuterAlt(_localctx, 5);
        state = 158;
        nodeRef(0);
        break;
      case TOKEN_DOT:
        enterOuterAlt(_localctx, 6);
        state = 159;
        executableRef();
        break;
      case TOKEN_LB:
        enterOuterAlt(_localctx, 7);
        state = 160;
        valueList();
        break;
      case TOKEN_LC:
        enterOuterAlt(_localctx, 8);
        state = 161;
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
    enterRule(_localctx, 26, RULE_valueObj);
    int _la;
    try {
      state = 185;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 21, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 164;
        match(TOKEN_LC);
        state = 165;
        match(TOKEN_RC);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 166;
        match(TOKEN_LC);
        state = 167;
        valuePair();
        state = 169;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_COMMA) {
          state = 168;
          match(TOKEN_COMMA);
        }

        state = 171;
        match(TOKEN_RC);
        break;
      case 3:
        enterOuterAlt(_localctx, 3);
        state = 173;
        match(TOKEN_LC);
        state = 174;
        valuePair();
        state = 179; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        do {
          state = 176;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_COMMA) {
            state = 175;
            match(TOKEN_COMMA);
          }

          state = 178;
          valuePair();
          state = 181; 
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        } while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 570490880) != 0));
        state = 183;
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
    enterRule(_localctx, 28, RULE_valueList);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 187;
      match(TOKEN_LB);
      state = 196;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 2124447864) != 0)) {
        state = 188;
        value();
        state = 193;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_COMMA) {
          state = 189;
          match(TOKEN_COMMA);
          state = 190;
          value();
          state = 195;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
      }

      state = 198;
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
    enterRule(_localctx, 30, RULE_valuePair);
    try {
      state = 206;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_IDENTIFIER:
        enterOuterAlt(_localctx, 1);
        state = 200;
        match(TOKEN_IDENTIFIER);
        state = 201;
        match(TOKEN_COLON);
        state = 202;
        value();
        break;
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 2);
        state = 203;
        match(TOKEN_STRING);
        state = 204;
        match(TOKEN_COLON);
        state = 205;
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
    case 8:
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
      4,1,36,209,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,
      2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,
      14,7,14,2,15,7,15,1,0,5,0,34,8,0,10,0,12,0,37,9,0,1,0,1,0,1,1,1,1,
      1,1,3,1,44,8,1,1,2,1,2,4,2,48,8,2,11,2,12,2,49,1,2,1,2,5,2,54,8,2,
      10,2,12,2,57,9,2,1,2,1,2,1,3,1,3,1,3,1,3,5,3,65,8,3,10,3,12,3,68,9,
      3,1,4,5,4,71,8,4,10,4,12,4,74,9,4,1,4,1,4,5,4,78,8,4,10,4,12,4,81,
      9,4,1,4,3,4,84,8,4,1,5,1,5,1,5,3,5,89,8,5,1,6,1,6,1,6,3,6,94,8,6,1,
      7,1,7,1,7,3,7,99,8,7,1,7,1,7,1,7,3,7,104,8,7,1,8,1,8,1,8,1,8,1,8,1,
      8,1,8,1,8,1,8,3,8,115,8,8,1,8,1,8,1,8,5,8,120,8,8,10,8,12,8,123,9,
      8,1,9,1,9,1,9,1,10,1,10,1,10,5,10,131,8,10,10,10,12,10,134,9,10,1,
      11,1,11,1,11,1,11,3,11,140,8,11,1,11,1,11,1,11,1,11,1,11,1,11,1,11,
      1,11,1,11,1,11,1,11,3,11,153,8,11,1,12,1,12,1,12,1,12,1,12,1,12,1,
      12,1,12,3,12,163,8,12,1,13,1,13,1,13,1,13,1,13,3,13,170,8,13,1,13,
      1,13,1,13,1,13,1,13,3,13,177,8,13,1,13,4,13,180,8,13,11,13,12,13,181,
      1,13,1,13,3,13,186,8,13,1,14,1,14,1,14,1,14,5,14,192,8,14,10,14,12,
      14,195,9,14,3,14,197,8,14,1,14,1,14,1,15,1,15,1,15,1,15,1,15,1,15,
      3,15,207,8,15,1,15,0,1,16,16,0,2,4,6,8,10,12,14,16,18,20,22,24,26,
      28,30,0,0,231,0,35,1,0,0,0,2,43,1,0,0,0,4,45,1,0,0,0,6,60,1,0,0,0,
      8,83,1,0,0,0,10,85,1,0,0,0,12,90,1,0,0,0,14,103,1,0,0,0,16,114,1,0,
      0,0,18,124,1,0,0,0,20,127,1,0,0,0,22,152,1,0,0,0,24,162,1,0,0,0,26,
      185,1,0,0,0,28,187,1,0,0,0,30,206,1,0,0,0,32,34,3,2,1,0,33,32,1,0,
      0,0,34,37,1,0,0,0,35,33,1,0,0,0,35,36,1,0,0,0,36,38,1,0,0,0,37,35,
      1,0,0,0,38,39,5,0,0,1,39,1,1,0,0,0,40,44,3,4,2,0,41,44,3,6,3,0,42,
      44,3,14,7,0,43,40,1,0,0,0,43,41,1,0,0,0,43,42,1,0,0,0,44,3,1,0,0,0,
      45,47,5,1,0,0,46,48,5,32,0,0,47,46,1,0,0,0,48,49,1,0,0,0,49,47,1,0,
      0,0,49,50,1,0,0,0,50,51,1,0,0,0,51,55,5,33,0,0,52,54,5,35,0,0,53,52,
      1,0,0,0,54,57,1,0,0,0,55,53,1,0,0,0,55,56,1,0,0,0,56,58,1,0,0,0,57,
      55,1,0,0,0,58,59,5,36,0,0,59,5,1,0,0,0,60,61,3,20,10,0,61,62,5,10,
      0,0,62,66,3,16,8,0,63,65,3,8,4,0,64,63,1,0,0,0,65,68,1,0,0,0,66,64,
      1,0,0,0,66,67,1,0,0,0,67,7,1,0,0,0,68,66,1,0,0,0,69,71,3,22,11,0,70,
      69,1,0,0,0,71,74,1,0,0,0,72,70,1,0,0,0,72,73,1,0,0,0,73,75,1,0,0,0,
      74,72,1,0,0,0,75,84,3,10,5,0,76,78,3,22,11,0,77,76,1,0,0,0,78,81,1,
      0,0,0,79,77,1,0,0,0,79,80,1,0,0,0,80,82,1,0,0,0,81,79,1,0,0,0,82,84,
      3,12,6,0,83,72,1,0,0,0,83,79,1,0,0,0,84,9,1,0,0,0,85,86,5,13,0,0,86,
      88,5,25,0,0,87,89,3,24,12,0,88,87,1,0,0,0,88,89,1,0,0,0,89,11,1,0,
      0,0,90,91,5,14,0,0,91,93,5,25,0,0,92,94,3,24,12,0,93,92,1,0,0,0,93,
      94,1,0,0,0,94,13,1,0,0,0,95,96,5,7,0,0,96,98,5,25,0,0,97,99,3,24,12,
      0,98,97,1,0,0,0,98,99,1,0,0,0,99,104,1,0,0,0,100,101,5,7,0,0,101,102,
      5,25,0,0,102,104,5,25,0,0,103,95,1,0,0,0,103,100,1,0,0,0,104,15,1,
      0,0,0,105,106,6,8,-1,0,106,115,5,26,0,0,107,115,5,3,0,0,108,115,5,
      4,0,0,109,115,5,5,0,0,110,115,5,6,0,0,111,112,5,25,0,0,112,113,5,17,
      0,0,113,115,3,16,8,1,114,105,1,0,0,0,114,107,1,0,0,0,114,108,1,0,0,
      0,114,109,1,0,0,0,114,110,1,0,0,0,114,111,1,0,0,0,115,121,1,0,0,0,
      116,117,10,2,0,0,117,118,5,18,0,0,118,120,5,30,0,0,119,116,1,0,0,0,
      120,123,1,0,0,0,121,119,1,0,0,0,121,122,1,0,0,0,122,17,1,0,0,0,123,
      121,1,0,0,0,124,125,5,15,0,0,125,126,5,25,0,0,126,19,1,0,0,0,127,132,
      3,16,8,0,128,129,5,16,0,0,129,131,3,16,8,0,130,128,1,0,0,0,131,134,
      1,0,0,0,132,130,1,0,0,0,132,133,1,0,0,0,133,21,1,0,0,0,134,132,1,0,
      0,0,135,136,5,18,0,0,136,137,5,25,0,0,137,139,5,19,0,0,138,140,3,24,
      12,0,139,138,1,0,0,0,139,140,1,0,0,0,140,141,1,0,0,0,141,153,5,20,
      0,0,142,143,5,18,0,0,143,153,5,25,0,0,144,145,5,18,0,0,145,146,5,25,
      0,0,146,147,5,17,0,0,147,153,3,24,12,0,148,149,5,18,0,0,149,150,5,
      25,0,0,150,151,5,17,0,0,151,153,5,25,0,0,152,135,1,0,0,0,152,142,1,
      0,0,0,152,144,1,0,0,0,152,148,1,0,0,0,153,23,1,0,0,0,154,163,5,29,
      0,0,155,163,5,30,0,0,156,163,5,28,0,0,157,163,5,27,0,0,158,163,3,16,
      8,0,159,163,3,18,9,0,160,163,3,28,14,0,161,163,3,26,13,0,162,154,1,
      0,0,0,162,155,1,0,0,0,162,156,1,0,0,0,162,157,1,0,0,0,162,158,1,0,
      0,0,162,159,1,0,0,0,162,160,1,0,0,0,162,161,1,0,0,0,163,25,1,0,0,0,
      164,165,5,23,0,0,165,186,5,24,0,0,166,167,5,23,0,0,167,169,3,30,15,
      0,168,170,5,16,0,0,169,168,1,0,0,0,169,170,1,0,0,0,170,171,1,0,0,0,
      171,172,5,24,0,0,172,186,1,0,0,0,173,174,5,23,0,0,174,179,3,30,15,
      0,175,177,5,16,0,0,176,175,1,0,0,0,176,177,1,0,0,0,177,178,1,0,0,0,
      178,180,3,30,15,0,179,176,1,0,0,0,180,181,1,0,0,0,181,179,1,0,0,0,
      181,182,1,0,0,0,182,183,1,0,0,0,183,184,5,24,0,0,184,186,1,0,0,0,185,
      164,1,0,0,0,185,166,1,0,0,0,185,173,1,0,0,0,186,27,1,0,0,0,187,196,
      5,21,0,0,188,193,3,24,12,0,189,190,5,16,0,0,190,192,3,24,12,0,191,
      189,1,0,0,0,192,195,1,0,0,0,193,191,1,0,0,0,193,194,1,0,0,0,194,197,
      1,0,0,0,195,193,1,0,0,0,196,188,1,0,0,0,196,197,1,0,0,0,197,198,1,
      0,0,0,198,199,5,22,0,0,199,29,1,0,0,0,200,201,5,25,0,0,201,202,5,17,
      0,0,202,207,3,24,12,0,203,204,5,29,0,0,204,205,5,17,0,0,205,207,3,
      24,12,0,206,200,1,0,0,0,206,203,1,0,0,0,207,31,1,0,0,0,25,35,43,49,
      55,66,72,79,83,88,93,98,103,114,121,132,139,152,162,169,176,181,185,
      193,196,206
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
  EdgeDeclarationContext? edgeDeclaration() => getRuleContext<EdgeDeclarationContext>(0);
  EdgeMacroInvocationContext? edgeMacroInvocation() => getRuleContext<EdgeMacroInvocationContext>(0);
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

