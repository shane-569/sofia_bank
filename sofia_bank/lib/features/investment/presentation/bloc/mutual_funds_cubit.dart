import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events

// State
class MutualFundsState extends Equatable {
  final List<Map<String, dynamic>> mutualFunds;
  final String selectedCategory;
  final bool isLoading;
  final String? error;

  const MutualFundsState({
    this.mutualFunds = const [],
    this.selectedCategory = 'All',
    this.isLoading = false,
    this.error,
  });

  MutualFundsState copyWith({
    List<Map<String, dynamic>>? mutualFunds,
    String? selectedCategory,
    bool? isLoading,
    String? error,
  }) {
    return MutualFundsState(
      mutualFunds: mutualFunds ?? this.mutualFunds,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [mutualFunds, selectedCategory, isLoading, error];
}

// Cubit
class MutualFundsCubit extends Cubit<MutualFundsState> {
  MutualFundsCubit() : super(const MutualFundsState());

  void loadMutualFunds() async {
    emit(state.copyWith(isLoading: true));
    try {
      // TODO: Implement API call to fetch mutual funds
      // For now, using dummy data
      final dummyData = [
        {
          'name': 'ICICI Prudential Technology Fund',
          'category': 'Equity',
          'nav': 45.67,
          'return': 12.5,
          'minInvestment': 5000,
        },
        {
          'name': 'HDFC Top 100 Fund',
          'category': 'Equity',
          'nav': 78.90,
          'return': 15.2,
          'minInvestment': 5000,
        },
        // Add more dummy data as needed
      ];

      emit(state.copyWith(
        mutualFunds: dummyData,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void filterMutualFunds(String category) {
    emit(state.copyWith(selectedCategory: category));
  }
}
