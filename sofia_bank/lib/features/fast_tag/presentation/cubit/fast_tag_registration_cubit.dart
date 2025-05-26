import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'fast_tag_registration_state.dart';

class FastTagRegistrationCubit extends Cubit<FastTagRegistrationState> {
  FastTagRegistrationCubit() : super(const FastTagRegistrationState());

  void nextStep() {
    if (state.currentStep < 3) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void updateFormData(Map<String, dynamic> data) {
    emit(state.copyWith(formData: {...state.formData, ...data}));
  }

  void setOtp(String otp) {
    emit(state.copyWith(otp: otp));
  }

  void setPin(String pin) {
    emit(state.copyWith(pin: pin));
  }

  void setDocument(String key, dynamic value) {
    emit(state.copyWith(documents: {...state.documents, key: value}));
  }

  void setCheckbox(bool value) {
    emit(state.copyWith(isVehicleOld: value));
  }

  void reset() {
    emit(const FastTagRegistrationState());
  }
}
