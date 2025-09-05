import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toFormattedSting({
    bool showDate = true,
    bool showTime = false,
    String? dateFormat,
    String? timeFormat,
  }) {
    final parts = <String>[];

    if (showDate) {
      final formatter = DateFormat(dateFormat ?? 'dd MMM yyyy');
      parts.add(formatter.format(this));
    }

    if (showTime) {
      final formatter = DateFormat(timeFormat ?? 'hh:mm a');
      parts.add(formatter.format(this));
    }

    return parts.join(' • ');
  }
}
