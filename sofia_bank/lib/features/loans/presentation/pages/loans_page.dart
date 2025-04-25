import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/loans/domain/enums/loan_type.dart';
import 'package:sofia_bank/features/loans/domain/models/loan.dart';
import 'package:sofia_bank/features/loans/domain/models/loan_info.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loans_cubit.dart';
import 'package:sofia_bank/features/loans/presentation/cubit/loans_state.dart';
import 'package:sofia_bank/features/loans/presentation/widgets/loan_card.dart';
import 'package:sofia_bank/features/loans/presentation/pages/loan_details_page.dart';

class LoansPage extends StatelessWidget {
  const LoansPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoansCubit()..loadLoans(),
      child: const LoansView(),
    );
  }
}

class LoansView extends StatelessWidget {
  const LoansView({Key? key}) : super(key: key);

  List<Loan> _getLoansForType(LoanType type) {
    switch (type) {
      case LoanType.home:
        return [
          Loan(
            id: '1',
            type: type.displayName,
            amount: 250000,
            interestRate: 3.5,
            tenure: 240,
            startDate: DateTime(2023, 1, 15),
            endDate: DateTime(2043, 1, 15),
            status: LoanStatus.ongoing,
            emi: 1450.50,
            amountPaid: 17406,
          ),
        ];
      case LoanType.car:
        return [
          Loan(
            id: '2',
            type: type.displayName,
            amount: 35000,
            interestRate: 4.5,
            tenure: 60,
            startDate: DateTime(2022, 6, 1),
            endDate: DateTime(2027, 6, 1),
            status: LoanStatus.closed,
            emi: 650.75,
            amountPaid: 35000,
          ),
        ];
      case LoanType.personal:
        return [
          Loan(
            id: '3',
            type: type.displayName,
            amount: 15000,
            interestRate: 8.5,
            tenure: 36,
            startDate: DateTime(2024, 2, 1),
            status: LoanStatus.rejected,
            emi: 472.50,
            amountPaid: 0,
          ),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: LoanType.values.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Loans',
            style: TextStyle(
              color: Colors.black87,
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primary,
            tabs: LoanType.values.map((type) {
              return Tab(
                text: type.displayName,
                icon: SvgPicture.asset(
                  type.icon,
                  color: AppColors.textSecondary,
                  width: 24,
                  height: 24,
                ),
              );
            }).toList(),
          ),
        ),
        body: BlocBuilder<LoansCubit, LoansState>(
          builder: (context, state) {
            if (state.status == LoansStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == LoansStatus.failure) {
              return Center(
                  child: Text(state.errorMessage ?? 'An error occurred'));
            }

            return TabBarView(
              children: LoanType.values.map((type) {
                final loanInfo = state.loanInfo[type];
                if (loanInfo == null) {
                  return const Center(
                      child: Text('No loan information available'));
                }
                return _buildLoanTypeContent(loanInfo, type, context);
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoanTypeContent(
      LoanInfo loanInfo, LoanType type, BuildContext context) {
    final loans = _getLoansForType(type);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.spacingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (loans.isNotEmpty) ...[
            const Text(
              'Your Loans',
              style: TextStyle(
                fontSize: AppSizes.textLG,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: AppSizes.spacingLG),
            ...loans.map((loan) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.spacingLG),
                  child: LoanCard(
                    loan: loan,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.loanDetails,
                        arguments: loan,
                      );
                    },
                  ),
                )),
            const SizedBox(height: AppSizes.spacingMD),
          ],
          _buildOverviewCard(loanInfo),
          const SizedBox(height: AppSizes.spacingXL),
          _buildRequirementsCard(loanInfo),
          const SizedBox(height: AppSizes.spacingXL),
          _buildApplyButton(context, loanInfo),
          const SizedBox(
            height: AppSizes.spacingMD,
          )
        ],
      ),
    );
  }

  Widget _buildOverviewCard(LoanInfo loan) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            loan.type.displayName,
            style: const TextStyle(
              fontSize: AppSizes.textXL,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: AppSizes.spacingMD),
          Text(
            loan.type.description,
            style: TextStyle(
              fontSize: AppSizes.textMD,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: AppSizes.spacingXL),
          _buildInfoRow('Loan Amount',
              '\$${loan.minAmount.toStringAsFixed(0)} - \$${loan.maxAmount.toStringAsFixed(0)}'),
          _buildInfoRow('Interest Rate', '${loan.interestRate}% p.a.'),
          _buildInfoRow(
              'Tenure', '${loan.minTenure} - ${loan.maxTenure} months'),
          _buildInfoRow('Processing Fee', loan.processingFee),
        ],
      ),
    );
  }

  Widget _buildRequirementsCard(LoanInfo loan) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.spacingLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Requirements',
            style: TextStyle(
              fontSize: AppSizes.textLG,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: AppSizes.spacingLG),
          _buildRequirementsList('Required Documents', loan.requiredDocuments),
          const SizedBox(height: AppSizes.spacingLG),
          _buildRequirementsList(
              'Eligibility Criteria', loan.eligibilityCriteria),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.spacingMD),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppSizes.textMD,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppSizes.textMD,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsList(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppSizes.textMD,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: AppSizes.spacingMD),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spacingSM),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppSizes.spacingSM),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: AppSizes.textSM,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildApplyButton(BuildContext parentContext, LoanInfo info) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: FilledButton(
        onPressed: () {
          Navigator.pushNamed(
            parentContext,
            '/loans/form',
            arguments: {
              'loanType': info.type,
              'interestRate': info.interestRate,
              'minAmount': info.minAmount,
              'maxAmount': info.maxAmount,
              'minTenure': info.minTenure,
              'maxTenure': info.maxTenure,
            },
          );
        },
        child: const Text('Apply Now'),
      ),
    );
  }
}
