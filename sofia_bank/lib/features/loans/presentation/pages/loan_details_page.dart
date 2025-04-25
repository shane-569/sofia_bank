import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/loans/domain/models/loan.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loan_details_cubit.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loan_details_state.dart';

class LoanDetailsPage extends StatelessWidget {
  final Loan loan;

  const LoanDetailsPage({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoanDetailsCubit()..loadLoanDetails(loan),
      child: const _LoanDetailsView(),
    );
  }
}

class _LoanDetailsView extends StatelessWidget {
  const _LoanDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details'),
      ),
      body: BlocBuilder<LoanDetailsCubit, LoanDetailsState>(
        builder: (context, state) {
          if (state.status == LoanDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == LoanDetailsStatus.failure) {
            return Center(
              child: Text(state.errorMessage ?? 'An error occurred'),
            );
          }

          if (state.loan == null) {
            return const Center(child: Text('No loan details available'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLoanSummary(state.loan!),
                const SizedBox(height: 24),
                _buildEmiGrid(state.emiDetails),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoanSummary(Loan loan) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Loan Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Amount', '\$${loan.amount.toStringAsFixed(2)}'),
            _buildInfoRow('EMI', '\$${loan.emi.toStringAsFixed(2)}'),
            _buildInfoRow('Interest Rate', '${loan.interestRate}%'),
            _buildInfoRow('Tenure', '${loan.tenure} months'),
            _buildInfoRow('Start Date', _formatDate(loan.startDate)),
            if (loan.endDate != null)
              _buildInfoRow('End Date', _formatDate(loan.endDate!)),
            _buildInfoRow(
                'Amount Paid', '\$${loan.amountPaid.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmiGrid(List<EmiDetail> emiDetails) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: emiDetails.length,
      itemBuilder: (context, index) {
        final emi = emiDetails[index];
        return _buildEmiCard(emi);
      },
    );
  }

  Widget _buildEmiCard(EmiDetail emi) {
    final isCurrentMonth = emi.dueDate.month == DateTime.now().month &&
        emi.dueDate.year == DateTime.now().year;

    Color bgColor;
    Color textColor;

    if (emi.isPaid) {
      bgColor = AppColors.emiPaidBg;
      textColor = AppColors.emiPaidText;
    } else if (isCurrentMonth) {
      bgColor = AppColors.emiUpcomingBg;
      textColor = AppColors.emiUpcomingText;
    } else {
      bgColor = AppColors.emiDisabledBg;
      textColor = AppColors.emiDisabledText;
    }

    return Card(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EMI ${emi.emiNumber}',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${emi.amount.toStringAsFixed(0)}',
              style: TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(emi.dueDate),
              style: TextStyle(
                color: textColor,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, y').format(date);
  }
}
