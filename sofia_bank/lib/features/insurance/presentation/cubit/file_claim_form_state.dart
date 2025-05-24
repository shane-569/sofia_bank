import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class FileClaimFormState extends Equatable {
  final String claimType;
  final String amount;
  final String description;
  final XFile? photo;
  final bool agreed;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final Map<String, String?> errors;

  const FileClaimFormState({
    this.claimType = '',
    this.amount = '',
    this.description = '',
    this.photo,
    this.agreed = false,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.errors = const {},
  });

  FileClaimFormState copyWith({
    String? claimType,
    String? amount,
    String? description,
    XFile? photo,
    bool? agreed,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    Map<String, String?>? errors,
  }) {
    return FileClaimFormState(
      claimType: claimType ?? this.claimType,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      agreed: agreed ?? this.agreed,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errors: errors ?? this.errors,
    );
  }

  bool get isFormValid =>
      claimType.isNotEmpty &&
      amount.isNotEmpty &&
      description.isNotEmpty &&
      photo != null &&
      agreed;

  @override
  List<Object?> get props => [
        claimType,
        amount,
        description,
        photo,
        agreed,
        isSubmitting,
        isSuccess,
        isFailure,
        errors,
      ];
}
