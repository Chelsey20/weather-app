import 'package:intl/intl.dart';

class Format {
  static String degrees(final double num) {
    String res = '';
    res = (num / 10).toStringAsFixed(2);
    return res;
  }

  static String sunDate(final int timestamp) {
    final sunDateTime =
        DateTime.fromMillisecondsSinceEpoch(
          timestamp * 1000,
          isUtc: true,
        ).toLocal();

    final formatter = DateFormat('h:mm:a');
    return formatter.format(sunDateTime);
  }
}
