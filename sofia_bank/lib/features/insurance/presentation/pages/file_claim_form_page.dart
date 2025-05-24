import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/widgets/custom_dropdown.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/form_text_field.dart';
import '../../../common/widgets/primary_button.dart';
import '../../../common/widgets/file_upload_field.dart';
import '../cubit/file_claim_form_cubit.dart';
import '../cubit/file_claim_form_state.dart';

class FileClaimFormPage extends StatelessWidget {
  static const routeName = '/file-claim';

  const FileClaimFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FileClaimFormCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('File a Claim')),
        body: BlocConsumer<FileClaimFormCubit, FileClaimFormState>(
          listener: (context, state) {
            if (state.isSuccess) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Success'),
                  content: const Text('Your claim has been submitted!'),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<FileClaimFormCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CustomDropdown(
                    label: 'Claim Type',
                    value: state.claimType,
                    items: const [
                      'Accident',
                      'Theft',
                      'Damage',
                      'Medical',
                      'Other'
                    ],
                    errorText: state.errors['claimType'],
                    onChanged: (v) => cubit.updateClaimType(v ?? ''),
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Claim Amount',
                    value: state.amount,
                    errorText: state.errors['amount'],
                    onChanged: cubit.updateAmount,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Description',
                    value: state.description,
                    errorText: state.errors['description'],
                    onChanged: cubit.updateDescription,
                  ),
                  const SizedBox(height: 16),
                  FileUploadField(
                    label: 'Photo',
                    fileName: state.photo?.name,
                    errorText: state.errors['photo'],
                    onFilePicked: cubit.updatePhoto,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: state.agreed,
                        onChanged: (v) => cubit.updateAgreed(v ?? false),
                      ),
                      const Expanded(
                        child: Text('I agree to the terms and conditions'),
                      ),
                    ],
                  ),
                  if (state.errors['agreed'] != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        state.errors['agreed']!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'Submit',
                    onPressed: cubit.submit,
                    enabled: state.isFormValid,
                    loading: state.isSubmitting,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
