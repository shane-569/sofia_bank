import 'package:flutter_bloc/flutter_bloc.dart';
import 'health_insurance_form_state.dart';

class HealthInsuranceFormCubit extends Cubit<HealthInsuranceFormState> {
  HealthInsuranceFormCubit() : super(const HealthInsuranceFormState());

  void updateFullName(String value) => emit(state.copyWith(fullName: value));
  void updateDob(DateTime value) => emit(state.copyWith(dob: value));
  void updateGender(String value) => emit(state.copyWith(gender: value));
  void updateEmail(String value) => emit(state.copyWith(email: value));
  void updatePhone(String value) => emit(state.copyWith(phone: value));
  void updateAddress(String value) => emit(state.copyWith(address: value));
  void updateSumInsured(String value) =>
      emit(state.copyWith(sumInsured: value));
  void updatePolicyTerm(String value) =>
      emit(state.copyWith(policyTerm: value));
  void updateNomineeName(String value) =>
      emit(state.copyWith(nomineeName: value));
  void updateNomineeRelation(String value) =>
      emit(state.copyWith(nomineeRelation: value));
  void updatePreExisting(String value) =>
      emit(state.copyWith(preExisting: value));
  void updateAgreed(bool value) => emit(state.copyWith(agreed: value));

  void submit() async {
    final errors = <String, String?>{};
    if (state.fullName.isEmpty) errors['fullName'] = 'Full name required';
    if (state.dob == null) errors['dob'] = 'Date of birth required';
    if (state.gender.isEmpty) errors['gender'] = 'Gender required';
    if (state.email.isEmpty || !state.email.contains('@'))
      errors['email'] = 'Valid email required';
    if (state.phone.isEmpty || state.phone.length < 10)
      errors['phone'] = 'Valid phone required';
    if (state.address.isEmpty) errors['address'] = 'Address required';
    if (state.sumInsured.isEmpty) errors['sumInsured'] = 'Sum insured required';
    if (state.policyTerm.isEmpty) errors['policyTerm'] = 'Policy term required';
    if (state.nomineeName.isEmpty)
      errors['nomineeName'] = 'Nominee name required';
    if (state.nomineeRelation.isEmpty)
      errors['nomineeRelation'] = 'Nominee relation required';
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
