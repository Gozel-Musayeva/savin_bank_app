extension DateTimeExtensions on DateTime {
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _two(int v) => v.toString().padLeft(2, '0');

  /// "12 Nov 2026"
  String get toDayMonthYear => '$day ${_months[month - 1]} $year';

  /// "14:05"
  String get toHourMinute => '${_two(hour)}:${_two(minute)}';

  /// "12 Nov, 14:05"
  String get toShortDateTime => '$day ${_months[month - 1]}, $toHourMinute';

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
