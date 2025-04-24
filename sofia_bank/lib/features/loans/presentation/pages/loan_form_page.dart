import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loan_form_cubit.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loan_form_state.dart';

class LoanFormPage extends StatelessWidget {
  final LoanType loanType;
  final double interestRate;
  final double minAmount;
  final double maxAmount;
  final int minTenure;
  final int maxTenure;

  const LoanFormPage({
    Key? key,
    required this.loanType,
    required this.interestRate,
    required this.minAmount,
    required this.maxAmount,
    required this.minTenure,
    required this.maxTenure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoanFormCubit(
        initialLoanType: loanType,
        interestRate: interestRate,
      ),
      child: _LoanFormView(
        minAmount: minAmount,
        maxAmount: maxAmount,
        minTenure: minTenure,
        maxTenure: maxTenure,
      ),
    );
  }
}

class _LoanFormView extends StatelessWidget {
  final double minAmount;
  final double maxAmount;
  final int minTenure;
  final int maxTenure;

  const _LoanFormView({
    required this.minAmount,
    required this.maxAmount,
    required this.minTenure,
    required this.maxTenure,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoanFormCubit, LoanFormState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoanFormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Loan application submitted successfully!'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context);
        } else if (state.status == LoanFormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(state.errorMessage ?? 'Failed to submit application'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            '${context.read<LoanFormCubit>().state.loanType.displayName} Application',
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLoanDetailsSection(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildPersonalDetailsSection(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildEmploymentDetailsSection(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildEMICalculationSection(),
              const SizedBox(height: AppSizes.spacingXL),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoanDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Loan Details',
          style: TextStyle(
            fontSize: AppSizes.textLG,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingLG),
        _buildAmountField(),
        const SizedBox(height: AppSizes.spacingMD),
        _buildTenureField(),
      ],
    );
  }

  Widget _buildPersonalDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Details',
          style: TextStyle(
            fontSize: AppSizes.textLG,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingLG),
        BlocBuilder<LoanFormCubit, LoanFormState>(
          buildWhen: (previous, current) =>
              previous.fullName != current.fullName,
          builder: (context, state) {
            return _buildTextField(
              label: 'Full Name',
              onChanged: (value) =>
                  context.read<LoanFormCubit>().updateFullName(value),
            );
          },
        ),
        const SizedBox(height: AppSizes.spacingMD),
        BlocBuilder<LoanFormCubit, LoanFormState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return _buildTextField(
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) =>
                  context.read<LoanFormCubit>().updateEmail(value),
            );
          },
        ),
        const SizedBox(height: AppSizes.spacingMD),
        BlocBuilder<LoanFormCubit, LoanFormState>(
          buildWhen: (previous, current) => previous.phone != current.phone,
          builder: (context, state) {
            return _buildTextField(
              label: 'Phone',
              keyboardType: TextInputType.phone,
              onChanged: (value) =>
                  context.read<LoanFormCubit>().updatePhone(value),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmploymentDetailsSection() {
    return BlocBuilder<LoanFormCubit, LoanFormState>(
      buildWhen: (previous, current) =>
          previous.isEmployed != current.isEmployed,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Employment Details',
              style: TextStyle(
                fontSize: AppSizes.textLG,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.spacingLG),
            SwitchListTile(
              title: const Text('Currently Employed'),
              value: state.isEmployed,
              onChanged: (value) =>
                  context.read<LoanFormCubit>().updateEmploymentStatus(value),
            ),
            if (state.isEmployed) ...[
              const SizedBox(height: AppSizes.spacingMD),
              _buildTextField(
                label: 'Occupation',
                onChanged: (value) =>
                    context.read<LoanFormCubit>().updateOccupation(value),
              ),
              const SizedBox(height: AppSizes.spacingMD),
              _buildTextField(
                label: 'Company Name',
                onChanged: (value) =>
                    context.read<LoanFormCubit>().updateCompanyName(value),
              ),
            ],
            const SizedBox(height: AppSizes.spacingMD),
            _buildTextField(
              label: 'Monthly Income',
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              onChanged: (value) => context
                  .read<LoanFormCubit>()
                  .updateMonthlyIncome(double.tryParse(value) ?? 0),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEMICalculationSection() {
    final currencyFormat = NumberFormat.currency(symbol: '\$');

    return BlocBuilder<LoanFormCubit, LoanFormState>(
      buildWhen: (previous, current) =>
          previous.amount != current.amount ||
          previous.tenure != current.tenure ||
          previous.emi != current.emi,
      builder: (context, state) {
        if (state.amount <= 0 || state.tenure <= 0) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(AppSizes.spacingLG),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Loan Summary',
                style: TextStyle(
                  fontSize: AppSizes.textLG,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: AppSizes.spacingLG),
              _buildSummaryRow(
                  'Principal Amount', currencyFormat.format(state.amount)),
              _buildSummaryRow('Tenure', '${state.tenure} months'),
              _buildSummaryRow('Interest Rate', '${state.interestRate}%'),
              const Divider(height: AppSizes.spacingXL),
              _buildSummaryRow(
                'Monthly EMI',
                currencyFormat.format(state.emi),
                isHighlighted: true,
              ),
              _buildSummaryRow(
                'Total Payment',
                currencyFormat.format(state.emi * state.tenure),
                isHighlighted: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoanFormCubit, LoanFormState>(
      buildWhen: (previous, current) =>
          previous.isFormValid != current.isFormValid ||
          previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                state.isFormValid && state.status != LoanFormStatus.loading
                    ? () => context.read<LoanFormCubit>().submitForm()
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: AppSizes.spacingLG),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.buttonBorderRadius),
              ),
            ),
            child: state.status == LoanFormStatus.loading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Text(
                    'Submit Application',
                    style: TextStyle(
                      fontSize: AppSizes.textLG,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildAmountField() {
    return BlocBuilder<LoanFormCubit, LoanFormState>(
      buildWhen: (previous, current) => previous.amount != current.amount,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loan Amount (\$${NumberFormat('#,###').format(minAmount)} - \$${NumberFormat('#,###').format(maxAmount)})',
              style: const TextStyle(
                fontSize: AppSizes.textMD,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            Slider(
              value: state.amount.clamp(minAmount, maxAmount),
              min: minAmount,
              max: maxAmount,
              divisions: ((maxAmount - minAmount) / 1000).round(),
              label: '\$${NumberFormat('#,###').format(state.amount)}',
              onChanged: (value) =>
                  context.read<LoanFormCubit>().updateAmount(value),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTenureField() {
    return BlocBuilder<LoanFormCubit, LoanFormState>(
      buildWhen: (previous, current) => previous.tenure != current.tenure,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loan Tenure ($minTenure - $maxTenure months)',
              style: const TextStyle(
                fontSize: AppSizes.textMD,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.spacingSM),
            Slider(
              value: state.tenure
                  .toDouble()
                  .clamp(minTenure.toDouble(), maxTenure.toDouble()),
              min: minTenure.toDouble(),
              max: maxTenure.toDouble(),
              divisions: maxTenure - minTenure,
              label: '${state.tenure} months',
              onChanged: (value) =>
                  context.read<LoanFormCubit>().updateTenure(value.round()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    required Function(String) onChanged,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.inputBorderRadius),
        ),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingSM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isHighlighted ? AppSizes.textMD : AppSizes.textSM,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlighted ? AppSizes.textMD : AppSizes.textSM,
              fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.normal,
              color: isHighlighted ? AppColors.primary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
