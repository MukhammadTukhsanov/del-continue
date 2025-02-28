import 'package:intl/intl.dart';

String formatNumber(int number) {
  return NumberFormat("#,##0", "ru_RU").format(number).replaceAll(',', ' ');
}
