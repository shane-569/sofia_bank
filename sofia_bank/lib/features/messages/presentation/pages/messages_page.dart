import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: Text('Messages'),
      ),
    );
  }
}
