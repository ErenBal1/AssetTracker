import 'package:flutter/material.dart';

mixin CurrencyIconMixin {
  Widget buildCurrencyIcon(bool isGold) {
    return Icon(
      isGold ? Icons.monetization_on : Icons.currency_exchange,
      color: isGold ? Colors.amber : Colors.blue,
    );
  }
}
