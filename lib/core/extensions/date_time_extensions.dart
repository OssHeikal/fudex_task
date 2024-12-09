import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime? {
  DateTime get validate {
    if (this == null) {
      return DateTime.now();
    }
    return this!;
  }

  String format({String format = 'dd/MM/yyyy'}) {
    final locale = Intl.getCurrentLocale();
    return DateFormat(format, locale).format(validate);
  }

  String formatTime({String format = 'hh:mm a', String locale = 'en'}) {
    return DateFormat(format, locale).format(validate);
  }

  bool get isNull => this == null;

  DateTime get startOfDay => DateTime(validate.year, validate.month, validate.day, 0, 0, 0, 0);

  DateTime get endOfDay => DateTime(validate.year, validate.month, validate.day, 23, 59, 59, 999);
}

extension DurationExtensions on Duration {
  String get formatDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(inMinutes.remainder(60));
    final seconds = twoDigits(inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
