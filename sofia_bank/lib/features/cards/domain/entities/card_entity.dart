import 'package:flutter/material.dart';

class CardEntity {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final String type; // visa, mastercard, etc.
  final double balance;
  final String currency;
  final Color cardColor;

  const CardEntity({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.type,
    required this.balance,
    required this.currency,
    required this.cardColor,
  });
}
