import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'bike_insurance_form_state.dart';

class BikeInsuranceFormCubit extends Cubit<BikeInsuranceFormState> {
  BikeInsuranceFormCubit() : super(const BikeInsuranceFormState());

  void updateOwnerName(String value) => emit(state.copyWith(ownerName: value));
  void updateEmail(String value) => emit(state.copyWith(email: value));
  void updatePhone(String value) => emit(state.copyWith(phone: value));
  void updateBikeModel(String value) => emit(state.copyWith(bikeModel: value));
  void updateRegNumber(String value) => emit(state.copyWith(regNumber: value));
  void updatePolicyTerm(String value) =>
      emit(state.copyWith(policyTerm: value));
  void updateRcFile(XFile? file) => emit(state.copyWith(rcFile: file));
  void updateLicenseFile(XFile? file) =>
      emit(state.copyWith(licenseFile: file));
  void updateAgreed(bool value) => emit(state.copyWith(agreed: value));

  void submit() async {
    final errors = <String, String?>{};
    if (state.ownerName.isEmpty) errors['ownerName'] = 'Owner name required';
    if (state.email.isEmpty || !state.email.contains('@'))
      errors['email'] = 'Valid email required';
    if (state.phone.isEmpty || state.phone.length < 10)
      errors['phone'] = 'Valid phone required';
    if (state.bikeModel.isEmpty) errors['bikeModel'] = 'Bike model required';
    if (state.regNumber.isEmpty)
      errors['regNumber'] = 'Registration number required';
    if (state.policyTerm.isEmpty) errors['policyTerm'] = 'Policy term required';
    if (state.rcFile == null) errors['rcFile'] = 'Upload RC required';
    if (state.licenseFile == null)
      errors['licenseFile'] = 'Upload license required';
    if (!state.agreed) errors['agreed'] = 'You must agree to terms';

    if (errors.isNotEmpty) {
      emit(
          state.copyWith(errors: errors, isFailure: true, isSubmitting: false));
      return;
    }

    emit(state.copyWith(isSubmitting: true, isFailure: false, errors: {}));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isSubmitting: false, isSuccess: true));
  }
}
