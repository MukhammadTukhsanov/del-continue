import 'package:intl/intl.dart';

String formatNumber(dynamic number) {
  return NumberFormat("#,##0", "ru_RU").format(number).replaceAll(',', ' ');
}
