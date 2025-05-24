import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'file_claim_form_state.dart';

class FileClaimFormCubit extends Cubit<FileClaimFormState> {
  FileClaimFormCubit() : super(const FileClaimFormState());

  void updateClaimType(String value) => emit(state.copyWith(claimType: value));
  void updateAmount(String value) => emit(state.copyWith(amount: value));
  void updateDescription(String value) =>
      emit(state.copyWith(description: value));
  void updatePhoto(XFile? file) => emit(state.copyWith(photo: file));
  void updateAgreed(bool value) => emit(state.copyWith(agreed: value));

  void submit() async {
    final errors = <String, String?>{};
    if (state.claimType.isEmpty) errors['claimType'] = 'Claim type required';
    if (state.amount.isEmpty) errors['amount'] = 'Amount required';
    if (state.description.isEmpty)
      errors['description'] = 'Description required';
    if (state.photo == null) errors['photo'] = 'Photo required';
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
