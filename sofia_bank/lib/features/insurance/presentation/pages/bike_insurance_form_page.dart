import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/custom_dropdown.dart';
import '../../../common/widgets/form_text_field.dart';
import '../../../common/widgets/primary_button.dart';
import '../../../common/widgets/file_upload_field.dart';
import '../cubit/bike_insurance_form_cubit.dart';
import '../cubit/bike_insurance_form_state.dart';

class BikeInsuranceFormPage extends StatelessWidget {
  static const routeName = '/bike-insurance-form';

  const BikeInsuranceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BikeInsuranceFormCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Buy Bike Insurance')),
        body: BlocConsumer<BikeInsuranceFormCubit, BikeInsuranceFormState>(
          listener: (context, state) {
            if (state.isSuccess) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Success'),
                  content:
                      const Text('Your bike insurance has been purchased!'),
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
            final cubit = context.read<BikeInsuranceFormCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FormTextField(
                    label: 'Owner Name',
                    value: state.ownerName,
                    errorText: state.errors['ownerName'],
                    onChanged: cubit.updateOwnerName,
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Email',
                    value: state.email,
                    errorText: state.errors['email'],
                    onChanged: cubit.updateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Phone Number',
                    value: state.phone,
                    errorText: state.errors['phone'],
                    onChanged: cubit.updatePhone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Bike Model',
                    value: state.bikeModel,
                    errorText: state.errors['bikeModel'],
                    onChanged: cubit.updateBikeModel,
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Registration Number',
                    value: state.regNumber,
                    errorText: state.errors['regNumber'],
                    onChanged: cubit.updateRegNumber,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Policy Term',
                    value: state.policyTerm,
                    items: const ['1 Year', '2 Years', '3 Years'],
                    errorText: state.errors['policyTerm'],
                    onChanged: (v) => cubit.updatePolicyTerm(v ?? ''),
                  ),
                  const SizedBox(height: 16),
                  FileUploadField(
                    label: 'RC',
                    fileName: state.rcFile?.name,
                    errorText: state.errors['rcFile'],
                    onFilePicked: cubit.updateRcFile,
                  ),
                  const SizedBox(height: 16),
                  FileUploadField(
                    label: 'License',
                    fileName: state.licenseFile?.name,
                    errorText: state.errors['licenseFile'],
                    onFilePicked: cubit.updateLicenseFile,
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
