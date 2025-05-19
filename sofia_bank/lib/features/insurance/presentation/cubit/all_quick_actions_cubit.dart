import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/quick_action_entity.dart';
import 'all_quick_actions_state.dart';

class AllQuickActionsCubit extends Cubit<AllQuickActionsState> {
  AllQuickActionsCubit() : super(const AllQuickActionsState());

  Future<void> loadQuickActions() async {
    emit(state.copyWith(status: AllQuickActionsStatus.loading));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final actions = [
        QuickActionEntity(
          id: '1',
          title: 'File a Claim',
          subtitle: 'Submit insurance claim',
          icon: Icons.description,
          backgroundColor: Colors.blue.shade50,
          iconColor: Colors.blue,
        ),
        QuickActionEntity(
          id: '2',
          title: 'Pay Premium',
          subtitle: 'Due in 7 days',
          icon: Icons.payment,
          backgroundColor: Colors.green.shade50,
          iconColor: Colors.green,
          amount: '\$249.99',
        ),
        QuickActionEntity(
          id: '3',
          title: 'View Claim Status',
          subtitle: 'Check your coverage',
          icon: Icons.policy,
          backgroundColor: Colors.purple.shade50,
          iconColor: Colors.purple,
        ),
        QuickActionEntity(
          id: '4',
          title: 'Contact Agent',
          subtitle: 'Get expert help',
          icon: Icons.support_agent,
          backgroundColor: Colors.orange.shade50,
          iconColor: Colors.orange,
        ),
        QuickActionEntity(
          id: '5',
          title: 'Policy Details',
          subtitle: 'View your policy information',
          icon: Icons.article,
          backgroundColor: Colors.teal.shade50,
          iconColor: Colors.teal,
        ),
        QuickActionEntity(
          id: '6',
          title: 'Download Documents',
          subtitle: 'Access your insurance documents',
          icon: Icons.file_download,
          backgroundColor: Colors.indigo.shade50,
          iconColor: Colors.indigo,
        ),
        QuickActionEntity(
          id: '7',
          title: 'Emergency Assistance',
          subtitle: '24/7 support available',
          icon: Icons.emergency,
          backgroundColor: Colors.red.shade50,
          iconColor: Colors.red,
        ),
        QuickActionEntity(
          id: '8',
          title: 'Update Profile',
          subtitle: 'Manage your information',
          icon: Icons.person,
          backgroundColor: Colors.amber.shade50,
          iconColor: Colors.amber,
        ),
      ];

      emit(state.copyWith(
        status: AllQuickActionsStatus.success,
        actions: actions,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AllQuickActionsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateSelectedCategory(String category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
