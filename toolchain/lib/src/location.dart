class Location {
  final LocationPosition start;
  final int length;

  Location(this.start, this.length);

  static Location invalid = Location(LocationPosition(-1, -1, -1), 0);
}

class LocationPosition {
  final int line;
  final int column;
  final int offset;
  LocationPosition(this.line, this.column, this.offset);
}

class SourceLocation {
  final Location? location;
  final String path;

  const SourceLocation(this.location, this.path);

  String toStartPosition() {
    if (location == null) return path;
    var start = location!.start;
    if (start.line >= 0 && start.column >= 0) {
      return "$path:${start.line}:${start.column}";
    } else if (start.offset >= 0) {
      return "$path:@${start.offset}";
    } else {
      return path;
    }
  }
}