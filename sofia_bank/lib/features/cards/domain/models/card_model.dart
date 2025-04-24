import 'package:flutter/material.dart';

class CardModel {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final CardType cardType;
  final double balance;
  final Color cardColor;

  CardModel({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
    required this.balance,
    required this.cardColor,
  });
}

enum CardType { visa, mastercard, amex, discover }
