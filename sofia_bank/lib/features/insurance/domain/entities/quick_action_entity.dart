import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QuickActionEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String? amount;

  const QuickActionEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.amount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        icon,
        backgroundColor,
        iconColor,
        amount,
      ];
}
