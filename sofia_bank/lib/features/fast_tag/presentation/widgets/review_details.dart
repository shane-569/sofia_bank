import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_cubit.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_state.dart';

class ReviewDetails extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const ReviewDetails({
    Key? key,
    required this.onBack,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FastTagCubit, FastTagState>(
      builder: (context, state) {
        final vehicleDetails = state.vehicleDetails;
        final personalDetails = state.personalDetails;
        final rechargeDetails = state.rechargeDetails;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSection(
                'Vehicle Details',
                [
                  _buildDetailRow(
                      'Vehicle Number', vehicleDetails?['vehicleNumber'] ?? ''),
                  _buildDetailRow(
                      'Vehicle Type', vehicleDetails?['vehicleType'] ?? ''),
                  _buildDetailRow(
                      'Vehicle Class', vehicleDetails?['vehicleClass'] ?? ''),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                'Personal Details',
                [
                  _buildDetailRow('Name', personalDetails?['name'] ?? ''),
                  _buildDetailRow('Email', personalDetails?['email'] ?? ''),
                  _buildDetailRow('Phone', personalDetails?['phone'] ?? ''),
                  _buildDetailRow('Address', personalDetails?['address'] ?? ''),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                'Recharge Details',
                [
                  _buildDetailRow(
                      'Amount', '₹${rechargeDetails?['amount'] ?? ''}'),
                  _buildDetailRow('Payment Method',
                      rechargeDetails?['paymentMethod'] ?? ''),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onBack,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state.isReviewLoading ? null : onSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state.isReviewLoading
                          ? const CircularProgressIndicator()
                          : const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
