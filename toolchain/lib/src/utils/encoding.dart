String byteArrayToSourceString(List<int> byteArray) {
  final buffer = StringBuffer();
  for (var byte in byteArray) {
    buffer.write('\\x${byte.toRadixString(16).padLeft(2, '0')}');
  }
  return buffer.toString();
}