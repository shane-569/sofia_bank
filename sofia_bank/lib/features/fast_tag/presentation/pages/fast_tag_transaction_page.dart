import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import '../cubit/fast_tag_transaction_cubit.dart';
import '../cubit/fast_tag_transaction_state.dart';

class FastTagTransactionPage extends StatefulWidget {
  const FastTagTransactionPage({Key? key}) : super(key: key);

  @override
  _FastTagTransactionPageState createState() => _FastTagTransactionPageState();
}

class _FastTagTransactionPageState extends State<FastTagTransactionPage> {
  @override
  void initState() {
    super.initState();
    // Fetch transaction data when the page is created
    context.read<FastTagTransactionCubit>().fetchTransactionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toll History'),
      ),
      body: BlocBuilder<FastTagTransactionCubit, FastTagTransactionState>(
        builder: (context, state) {
          if (state.status == FastTagTransactionStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == FastTagTransactionStatus.loaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Vehicle Number Section (Mock)
                  const Card(
                    color: AppColors.primary,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vehicle No.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: AppColors.background),
                          ),
                          Row(
                            children: [
                              Text(
                                'DL3CC10XX', // Placeholder
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.background,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.background,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Fastag Balance and Last Toll
                  Card(
                    color: AppColors.background,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Fastag Balance',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '₹ ${state.fastTagBalance.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Last Toll',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                state.lastTollLocation,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Toll History Section
                  const Text(
                    'Toll History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        return _buildTollHistoryItem(transaction);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state.status == FastTagTransactionStatus.error) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          }
          return const SizedBox.shrink(); // Initial or other states
        },
      ),
    );
  }

  // Helper widget to build individual toll history items
  Widget _buildTollHistoryItem(TollTransaction transaction) {
    return Card(
      color: AppColors.background,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  transaction.date,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹ ${transaction.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
