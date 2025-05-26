import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_state.dart';

class FastTagCubit extends Cubit<FastTagState> {
  FastTagCubit() : super(const FastTagState());

  Future<void> submitVehicleDetails(Map<String, dynamic> details) async {
    try {
      emit(state.copyWith(
        isVehicleDetailsLoading: true,
        status: FastTagStatus.loading,
      ));

      // TODO: Implement API call to submit vehicle details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isVehicleDetailsLoading: false,
        status: FastTagStatus.loaded,
        vehicleDetails: details,
      ));
    } catch (e) {
      emit(state.copyWith(
        isVehicleDetailsLoading: false,
        status: FastTagStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> submitPersonalDetails(Map<String, dynamic> details) async {
    try {
      emit(state.copyWith(
        isPersonalDetailsLoading: true,
        status: FastTagStatus.loading,
      ));

      // TODO: Implement API call to submit personal details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isPersonalDetailsLoading: false,
        status: FastTagStatus.loaded,
        personalDetails: details,
      ));
    } catch (e) {
      emit(state.copyWith(
        isPersonalDetailsLoading: false,
        status: FastTagStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> submitRechargeDetails(Map<String, dynamic> details) async {
    try {
      emit(state.copyWith(
        isRechargeLoading: true,
        status: FastTagStatus.loading,
      ));

      // TODO: Implement API call to submit recharge details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isRechargeLoading: false,
        status: FastTagStatus.loaded,
        rechargeDetails: details,
      ));
    } catch (e) {
      emit(state.copyWith(
        isRechargeLoading: false,
        status: FastTagStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> submitReview() async {
    try {
      emit(state.copyWith(
        isReviewLoading: true,
        status: FastTagStatus.loading,
      ));

      // TODO: Implement API call to submit final review
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isReviewLoading: false,
        status: FastTagStatus.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        isReviewLoading: false,
        status: FastTagStatus.error,
        error: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const FastTagState());
  }
}
