import 'package:equatable/equatable.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/wellness_category_entity.dart';
import '../../domain/entities/quick_action_entity.dart';

enum InsuranceStatus { initial, loading, success, error }

class InsuranceState extends Equatable {
  final InsuranceStatus status;
  final List<InsuranceEntity> insurances;
  final List<WellnessCategoryEntity> wellnessCategories;
  final List<QuickActionEntity> quickActions;
  final String? errorMessage;
  final int selectedIndex;

  const InsuranceState({
    this.status = InsuranceStatus.initial,
    this.insurances = const [],
    this.wellnessCategories = const [],
    this.quickActions = const [],
    this.errorMessage,
    this.selectedIndex = 0,
  });

  InsuranceState copyWith({
    InsuranceStatus? status,
    List<InsuranceEntity>? insurances,
    List<WellnessCategoryEntity>? wellnessCategories,
    List<QuickActionEntity>? quickActions,
    String? errorMessage,
    int? selectedIndex,
  }) {
    return InsuranceState(
      status: status ?? this.status,
      insurances: insurances ?? this.insurances,
      wellnessCategories: wellnessCategories ?? this.wellnessCategories,
      quickActions: quickActions ?? this.quickActions,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
        status,
        insurances,
        wellnessCategories,
        quickActions,
        errorMessage,
        selectedIndex,
      ];
}
