import 'package:intl/intl.dart';

final _peso = NumberFormat.currency(locale: 'en_PH', symbol: '₱', decimalDigits: 2);

String formatPeso(double value) => _peso.format(value);

String formatDate(DateTime d) => DateFormat('MMM d, yyyy').format(d);