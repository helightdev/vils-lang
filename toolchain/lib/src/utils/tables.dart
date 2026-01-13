enum HorizontalRule {
  none,
  headerOnly,
  all,
}

String buildTable(
  List<List> entries, {
  HorizontalRule horizontalRule = HorizontalRule.headerOnly,
  bool drawBorder = true,
}) {
  if (entries.isEmpty) return '';

  final rows = entries
      .map((r) => r.map((c) => c?.toString() ?? '').toList(growable: false))
      .toList(growable: false);

  final colCount = rows.fold<int>(0, (m, r) => r.length > m ? r.length : m);
  if (colCount == 0) return '';

  final paddedRows = rows
      .map((r) => [...r, for (var i = r.length; i < colCount; i++) ''])
      .toList(growable: false);

  final widths = List<int>.filled(colCount, 0);
  for (final r in paddedRows) {
    for (var c = 0; c < colCount; c++) {
      final len = r[c].length;
      if (len > widths[c]) widths[c] = len;
    }
  }

  final out = StringBuffer();

  if (drawBorder) {
    out.writeln(hLine('┌', '┬', '┐', widths));
  }

  for (var i = 0; i < paddedRows.length; i++) {
    out.writeln(rowLine(paddedRows[i], widths, drawBorder));

    final isLast = i == paddedRows.length - 1;
    final drawRule =
        (horizontalRule == HorizontalRule.all && !isLast) ||
        (horizontalRule == HorizontalRule.headerOnly && i == 0);

    if (drawRule) {
      out.writeln(hLine(drawBorder ? '├' : '', '┼', drawBorder ? '┤' : '', widths));
    }
  }

  if (drawBorder) {
    out.write(hLine('└', '┴', '┘', widths));
  }

  return out.toString().trimRight();
}

String hLine(String left, String mid, String right, List<int> widths) {
  final colCount = widths.length;
  final sb = StringBuffer()..write(left);
  for (var c = 0; c < colCount; c++) {
    sb.write('─' * (widths[c] + 2));
    sb.write(c == colCount - 1 ? right : mid);
  }
  return sb.toString();
}

String rowLine(List<String> r, List<int> widths, bool drawBorder) {
  final colCount = widths.length;
  final sb = StringBuffer();
  if (drawBorder) sb.write('│');
  for (var c = 0; c < colCount; c++) {
    final cell = r[c];
    final padRight = widths[c] - cell.length;
    sb
      ..write(' ')
      ..write(cell)
      ..write(' ' * padRight)
      ..write(' ');

    if (c < colCount - 1 || drawBorder) {
      sb.write('│');
    }
  }
  return sb.toString();
}
