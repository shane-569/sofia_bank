import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/wellness_category_entity.dart';
import '../../domain/entities/quick_action_entity.dart';
import 'insurance_state.dart';

class InsuranceCubit extends Cubit<InsuranceState> {
  InsuranceCubit() : super(const InsuranceState());

  Future<void> loadInsurances() async {
    emit(state.copyWith(status: InsuranceStatus.loading));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final insurances = [
        InsuranceEntity(
          id: '1',
          type: 'Car Insurance',
          policyNumber: 'MP04CY9999',
          policyHolder: 'Rahul Sharma',
          validityDate: DateTime(2025, 2, 10),
          vehicleModel: 'Tata Altroz',
          isActive: true,
        ),
        InsuranceEntity(
          id: '2',
          type: 'Health Insurance',
          policyNumber: 'HI789456',
          policyHolder: 'Rahul Sharma',
          validityDate: DateTime(2025, 3, 15),
          vehicleModel: '',
          isActive: true,
        ),
        InsuranceEntity(
          id: '3',
          type: 'Bike Insurance',
          policyNumber: 'BI123456',
          policyHolder: 'Rahul Sharma',
          validityDate: DateTime(2024, 12, 31),
          vehicleModel: 'Honda CB350',
          isActive: true,
        ),
      ];

      final wellnessCategories = [
        const WellnessCategoryEntity(
          id: '1',
          title: 'Health',
          icon: Icons.favorite,
          backgroundColor: const Color(0xFFFEE8EA),
          iconColor: const Color(0xFFFF4B6C),
        ),
        const WellnessCategoryEntity(
          id: '2',
          title: 'Bike',
          icon: Icons.motorcycle,
          backgroundColor: const Color(0xFFFFF3E5),
          iconColor: const Color(0xFFFF9D55),
        ),
        const WellnessCategoryEntity(
          id: '3',
          title: 'Home',
          icon: Icons.home,
          backgroundColor: const Color(0xFFEEE9FF),
          iconColor: const Color(0xFF7B61FF),
        ),
        const WellnessCategoryEntity(
          id: '4',
          title: 'Travel',
          icon: Icons.luggage,
          backgroundColor: const Color(0xFFE5F6FF),
          iconColor: const Color(0xFF55B6FF),
        ),
        const WellnessCategoryEntity(
          id: '5',
          title: 'Life',
          icon: Icons.shield,
          backgroundColor: const Color(0xFFE8F5E9),
          iconColor: const Color(0xFF4CAF50),
        ),
        const WellnessCategoryEntity(
          id: '6',
          title: 'Car',
          icon: Icons.directions_car,
          backgroundColor: const Color(0xFFF3E5F5),
          iconColor: const Color(0xFF9C27B0),
        ),
        const WellnessCategoryEntity(
          id: '7',
          title: 'Business',
          icon: Icons.business,
          backgroundColor: const Color(0xFFE1F5FE),
          iconColor: const Color(0xFF03A9F4),
        ),
        const WellnessCategoryEntity(
          id: '8',
          title: 'Family',
          icon: Icons.family_restroom,
          backgroundColor: const Color(0xFFFFF3E0),
          iconColor: const Color(0xFFFF9800),
        ),
      ];

      final quickActions = [
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
      ];

      emit(state.copyWith(
        status: InsuranceStatus.success,
        insurances: insurances,
        wellnessCategories: wellnessCategories,
        quickActions: quickActions,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: InsuranceStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void updateSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
