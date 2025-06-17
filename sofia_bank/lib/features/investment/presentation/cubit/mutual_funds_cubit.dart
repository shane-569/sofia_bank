import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/investment/domain/models/mutual_fund.dart';
import 'package:sofia_bank/features/investment/domain/repositories/mutual_fund_repository.dart';

class MutualFundsState extends Equatable {
  final List<MutualFund> mutualFunds;
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
    List<MutualFund>? mutualFunds,
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

class MutualFundsCubit extends Cubit<MutualFundsState> {
  final MutualFundRepository repository;

  MutualFundsCubit({required this.repository})
      : super(const MutualFundsState());

  Future<void> loadMutualFunds() async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await repository.getMutualFunds();

    result.fold(
      (error) => emit(state.copyWith(
        error: error,
        isLoading: false,
      )),
      (funds) => emit(state.copyWith(
        mutualFunds: funds,
        isLoading: false,
      )),
    );
  }

  Future<void> filterMutualFunds(String category) async {
    emit(state.copyWith(
      selectedCategory: category,
      isLoading: true,
      error: null,
    ));

    final result = await repository.getMutualFundsByCategory(category);

    result.fold(
      (error) => emit(state.copyWith(
        error: error,
        isLoading: false,
      )),
      (funds) => emit(state.copyWith(
        mutualFunds: funds,
        isLoading: false,
      )),
    );
  }
}
