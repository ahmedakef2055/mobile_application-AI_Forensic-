enum Severity {
  critical,
  high,
  medium,
  low,
  info;

  String toDisplayString() {
    switch (this) {
      case Severity.critical:
        return 'Critical';
      case Severity.high:
        return 'High';
      case Severity.medium:
        return 'Medium';
      case Severity.low:
        return 'Low';
      case Severity.info:
        return 'Info';
    }
  }

  String toHexColor() {
    switch (this) {
      case Severity.critical:
        return '#FF3B30'; // Red
      case Severity.high:
        return '#FF9500'; // Orange
      case Severity.medium:
        return '#FFCC00'; // Yellow
      case Severity.low:
        return '#34C759'; // Green
      case Severity.info:
        return '#00C7FF'; // Cyan
    }
  }
}
