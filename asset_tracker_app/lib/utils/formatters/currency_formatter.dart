import 'package:intl/intl.dart';

class CurrencyFormatter {
  // Para birimini formatlayan fonksiyon (nokta ve virgül ayarları Türkçe için)
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
      customPattern: '###,###,##0.00 \u00A4',
    );
    return formatter.format(amount);
  }

  // Tam sayı formatı (1.000 şeklinde)
  static String formatInteger(double amount) {
    final formatter = NumberFormat('#,###', 'tr_TR');
    return formatter.format(amount);
  }

  // Kar/Zarar formatı
  static String formatProfitLoss(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'tr_TR',
      symbol: 'TL',
      decimalDigits: 2,
      customPattern: '###,###,##0.00 \u00A4',
    );
    return formatter.format(amount);
  }

  // Kar/Zarar yüzdesini formatlama
  static String formatPercentage(double percentage) {
    final formatter = NumberFormat('###,##0.00', 'tr_TR');
    return '${formatter.format(percentage)}%';
  }
}
