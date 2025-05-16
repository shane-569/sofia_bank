import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WellnessCategoryEntity extends Equatable {
  final String id;
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const WellnessCategoryEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  List<Object?> get props => [id, title, icon, backgroundColor, iconColor];
}
