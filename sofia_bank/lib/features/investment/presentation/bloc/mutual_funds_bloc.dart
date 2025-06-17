import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/investment/domain/models/mutual_fund.dart';
import 'package:sofia_bank/features/investment/domain/repositories/mutual_fund_repository.dart';

// Events
abstract class MutualFundsEvent extends Equatable {
  const MutualFundsEvent();

  @override
  List<Object> get props => [];
}

class LoadMutualFunds extends MutualFundsEvent {}

class FilterMutualFunds extends MutualFundsEvent {
  final String category;

  const FilterMutualFunds(this.category);

  @override
  List<Object> get props => [category];
}

// State
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

// Bloc
class MutualFundsBloc extends Bloc<MutualFundsEvent, MutualFundsState> {
  final MutualFundRepository repository;

  MutualFundsBloc({required this.repository})
      : super(const MutualFundsState()) {
    on<LoadMutualFunds>(_onLoadMutualFunds);
    on<FilterMutualFunds>(_onFilterMutualFunds);
  }

  Future<void> _onLoadMutualFunds(
    LoadMutualFunds event,
    Emitter<MutualFundsState> emit,
  ) async {
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

  Future<void> _onFilterMutualFunds(
    FilterMutualFunds event,
    Emitter<MutualFundsState> emit,
  ) async {
    emit(state.copyWith(
      selectedCategory: event.category,
      isLoading: true,
      error: null,
    ));

    final result = await repository.getMutualFundsByCategory(event.category);

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
