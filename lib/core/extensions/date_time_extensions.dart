import '../constants/app_texts.dart';

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

  static const _fullMonths = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String _two(int v) => v.toString().padLeft(2, '0');

  /// "03 July 2026, 16.45" — transaction rows.
  String get toLongDateTime =>
      '${_two(day)} ${_fullMonths[month - 1]} $year, '
      '${_two(hour)}.${_two(minute)}';

  /// "12 Nov 2026"
  String get toDayMonthYear => '$day ${_months[month - 1]} $year';

  /// "14:05"
  String get toHourMinute => '${_two(hour)}:${_two(minute)}';

  /// "12 Nov, 14:05"
  String get toShortDateTime => '$day ${_months[month - 1]}, $toHourMinute';

  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  /// "Sat, 17 Jun 2026 • 3:00 PM" — receipts.
  String get toReceiptDateTime =>
      '${_weekdays[weekday - 1]}, $day ${_months[month - 1]} $year • '
      '$toHourMinute12';

  /// "9:05 PM"
  String get toHourMinute12 {
    final h = hour % 12 == 0 ? 12 : hour % 12;
    return '$h:${_two(minute)} ${hour < 12 ? 'AM' : 'PM'}';
  }

  /// Today → "Just now" / "10 minutes ago" / "2 hours ago";
  /// any earlier day → "9:05 PM" (the day is shown by the section header).
  String toRelativeTime([DateTime? now]) {
    final current = now ?? DateTime.now();
    if (!isSameDay(current)) return toHourMinute12;
    final diff = current.difference(this);
    if (diff.inMinutes < 1) return AppTexts.justNow;
    if (diff.inHours < 1) {
      final m = diff.inMinutes;
      return '$m ${m == 1 ? AppTexts.minuteAgo : AppTexts.minutesAgo}';
    }
    final h = diff.inHours;
    return '$h ${h == 1 ? AppTexts.hourAgo : AppTexts.hoursAgo}';
  }

  /// "Today" / "Yesterday" / "12 Nov 2026" — list section headers.
  String toDayLabel([DateTime? now]) {
    final current = now ?? DateTime.now();
    if (isSameDay(current)) return AppTexts.today;
    if (isSameDay(current.subtract(const Duration(days: 1)))) {
      return AppTexts.yesterday;
    }
    return toDayMonthYear;
  }

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
