import 'package:equatable/equatable.dart';
import '../../domain/entities/quick_action_entity.dart';

enum AllQuickActionsStatus { initial, loading, success, error }

class AllQuickActionsState extends Equatable {
  final AllQuickActionsStatus status;
  final List<QuickActionEntity> actions;
  final String? errorMessage;
  final String selectedCategory;

  const AllQuickActionsState({
    this.status = AllQuickActionsStatus.initial,
    this.actions = const [],
    this.errorMessage,
    this.selectedCategory = 'All',
  });

  AllQuickActionsState copyWith({
    AllQuickActionsStatus? status,
    List<QuickActionEntity>? actions,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return AllQuickActionsState(
      status: status ?? this.status,
      actions: actions ?? this.actions,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
        status,
        actions,
        errorMessage,
        selectedCategory,
      ];
}
