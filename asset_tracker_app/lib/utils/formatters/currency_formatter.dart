import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
      customPattern: '###,###,##0.00 \u00A4',
    );
    return formatter.format(amount);
  }

  static String formatInteger(double amount) {
    final formatter = NumberFormat('#,###', 'tr_TR');
    return formatter.format(amount);
  }

  static String formatProfitLoss(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
      customPattern: '###,###,##0.00 \u00A4',
    );
    return formatter.format(amount);
  }

  static String formatPercentage(double percentage) {
    final formatter = NumberFormat('###,##0.00', 'tr_TR');
    return '${formatter.format(percentage)}%';
  }

  static String formatDouble(double value, {int decimalDigits = 2}) {
    final formatter = NumberFormat('#,###.${'0' * decimalDigits}', 'tr_TR');
    return formatter.format(value);
  }
}
