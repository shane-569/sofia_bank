import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_state.dart';

class FastTagCubit extends Cubit<FastTagState> {
  FastTagCubit() : super(const FastTagState());

  Future<void> submitVehicleDetails(Map<String, dynamic> details) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      // TODO: Implement API call to submit vehicle details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isLoading: false,
        vehicleNumber: details['vehicleNumber'] ?? '',
        chasisNumber: details['chasisNumber'] ?? '',
        engineNumber: details['engineNumber'] ?? '',
        ownerName: details['ownerName'] ?? '',
        vehicleClass: details['vehicleClass'] ?? '',
        fuelType: details['fuelType'] ?? '',
        makerModel: details['makerModel'] ?? '',
        insuranceExpiry: details['insuranceExpiry'] ?? '',
        emissionNorms: details['emissionNorms'] ?? '',
        registrationDate: details['registrationDate'] ?? '',
        fitnessUpto: details['fitnessUpto'] ?? '',
        mvTaxUpto: details['mvTaxUpto'] ?? '',
        puccUpto: details['puccUpto'] ?? '',
        rcStatus: details['rcStatus'] ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> submitPersonalDetails(Map<String, dynamic> details) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      // TODO: Implement API call to submit personal details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isLoading: false,
        panCard: details['panCard'] ?? '',
        dob: details['dob'] ?? '',
        mobileNumber: details['mobileNumber'] ?? '',
        email: details['email'] ?? '',
        address: details['address'] ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> submitRechargeDetails(Map<String, dynamic> details) async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      // TODO: Implement API call to submit recharge details
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isLoading: false,
        // Assuming recharge details update some state fields if needed
        // For now, just setting loading to false
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> submitReview() async {
    try {
      emit(state.copyWith(
        isLoading: true,
      ));

      // TODO: Implement API call to submit final review
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      emit(state.copyWith(
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const FastTagState());
  }
}
