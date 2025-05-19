import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/insurance/presentation/cubit/health_insurance_form_cubit.dart';
import 'package:sofia_bank/features/insurance/presentation/cubit/health_insurance_form_state.dart';

import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/custom_dropdown.dart';
import '../../../common/widgets/custom_date_picker.dart';
import '../../../common/widgets/form_text_field.dart';
import '../../../common/widgets/primary_button.dart';

class HealthInsuranceFormPage extends StatelessWidget {
  static const routeName = '/health-insurance-form';

  const HealthInsuranceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HealthInsuranceFormCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Buy Health Insurance')),
        body: BlocConsumer<HealthInsuranceFormCubit, HealthInsuranceFormState>(
          listener: (context, state) {
            if (state.isSuccess) {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Success'),
                  content:
                      const Text('Your health insurance has been purchased!'),
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
            final cubit = context.read<HealthInsuranceFormCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  FormTextField(
                    label: 'Full Name',
                    value: state.fullName,
                    errorText: state.errors['fullName'],
                    onChanged: cubit.updateFullName,
                  ),
                  const SizedBox(height: 16),
                  CustomDatePicker(
                    label: 'Date of Birth',
                    value: state.dob,
                    errorText: state.errors['dob'],
                    onChanged: cubit.updateDob,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Gender',
                    value: state.gender,
                    items: const ['Male', 'Female', 'Other'],
                    errorText: state.errors['gender'],
                    onChanged: (v) => cubit.updateGender(v ?? ''),
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
                    label: 'Address',
                    value: state.address,
                    errorText: state.errors['address'],
                    onChanged: cubit.updateAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Sum Insured',
                    value: state.sumInsured,
                    items: const [
                      '1,00,000',
                      '2,00,000',
                      '5,00,000',
                      '10,00,000'
                    ],
                    errorText: state.errors['sumInsured'],
                    onChanged: (v) => cubit.updateSumInsured(v ?? ''),
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Policy Term',
                    value: state.policyTerm,
                    items: const ['1 Year', '2 Years', '3 Years', '5 Years'],
                    errorText: state.errors['policyTerm'],
                    onChanged: (v) => cubit.updatePolicyTerm(v ?? ''),
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Nominee Name',
                    value: state.nomineeName,
                    errorText: state.errors['nomineeName'],
                    onChanged: cubit.updateNomineeName,
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown(
                    label: 'Nominee Relation',
                    value: state.nomineeRelation,
                    items: const [
                      'Spouse',
                      'Child',
                      'Parent',
                      'Sibling',
                      'Other'
                    ],
                    errorText: state.errors['nomineeRelation'],
                    onChanged: (v) => cubit.updateNomineeRelation(v ?? ''),
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Pre-existing Conditions',
                    value: state.preExisting,
                    errorText: state.errors['preExisting'],
                    onChanged: cubit.updatePreExisting,
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
