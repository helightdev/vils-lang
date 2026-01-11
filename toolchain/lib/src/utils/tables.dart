String buildTable(List<List> entries, {String colSep = " | ", String rowSep = "\n"}) {
  if (entries.isEmpty) return "";
  final colWidths = <int>[];
  for (var row in entries) {
    for (var i = 0; i < row.length; i++) {
      final cell = row[i].toString();
      if (colWidths.length <= i) {
        colWidths.add(cell.length);
      } else {
        colWidths[i] = colWidths[i] < cell.length ? cell.length : colWidths[i];
      }
    }
  }
  final buffer = StringBuffer();
  for (var rowIndex = 0; rowIndex < entries.length; rowIndex++) {
    final row = entries[rowIndex];
    for (var i = 0; i < row.length; i++) {
      final cell = row[i].toString();
      buffer.write(cell.padRight(colWidths[i]));
      if (i < row.length - 1) buffer.write(colSep);
    }
    if (rowIndex < entries.length - 1) buffer.write(rowSep);
  }
  return buffer.toString();
}