import 'package:flutter_bloc/flutter_bloc.dart';
import 'fast_tag_transaction_state.dart';

class FastTagTransactionCubit extends Cubit<FastTagTransactionState> {
  FastTagTransactionCubit() : super(const FastTagTransactionState());

  Future<void> fetchTransactionData() async {
    emit(state.copyWith(status: FastTagTransactionStatus.loading));

    // Mock fetching data with a delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock data based on the image
    final mockTransactions = [
      TollTransaction(
          name: 'Taj Expressway', amount: 125.0, date: '22nd May 2022'),
      TollTransaction(name: 'Dasana Toll', amount: 40.0, date: '25th Apr 2022'),
      TollTransaction(name: 'Jewar Toll', amount: 95.0, date: '19th Apr 2022'),
    ];

    emit(state.copyWith(
      status: FastTagTransactionStatus.loaded,
      fastTagBalance: 235.00,
      lastTollLocation: 'Taj Expressway',
      transactions: mockTransactions,
    ));
  }
}
