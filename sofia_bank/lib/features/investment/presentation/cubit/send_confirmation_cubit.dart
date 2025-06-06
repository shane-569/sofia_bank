import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/send_confirmation_state.dart';

class SendConfirmationCubit extends Cubit<SendConfirmationState> {
  SendConfirmationCubit() : super(SendConfirmationInitial());

  // Mock data (replace with actual data fetching/passing later)
  double _availableBalance = 3.00912; // Example balance
  String _selectedAssetSymbol = 'BTC'; // Example asset
  String _amountInput = '';

  void initialize() {
    emit(SendConfirmationLoaded(
      amountInput: _amountInput,
      availableBalance: _availableBalance,
      selectedAssetSymbol: _selectedAssetSymbol,
    ));
  }

  void updateAmountInput(String input) {
    // Basic validation/handling for number pad input
    if (state is SendConfirmationLoaded) {
      _amountInput += input;
      emit(SendConfirmationLoaded(
        amountInput: _amountInput,
        availableBalance: _availableBalance,
        selectedAssetSymbol: _selectedAssetSymbol,
      ));
    }
  }

  void deleteAmountInput() {
    if (state is SendConfirmationLoaded) {
      if (_amountInput.isNotEmpty) {
        _amountInput = _amountInput.substring(0, _amountInput.length - 1);
        emit(SendConfirmationLoaded(
          amountInput: _amountInput,
          availableBalance: _availableBalance,
          selectedAssetSymbol: _selectedAssetSymbol,
        ));
      }
    }
  }

  void confirmSend() async {
    // TODO: Implement actual send logic
    emit(SendConfirmationLoading());
    try {
      // Simulate sending process
      await Future.delayed(const Duration(seconds: 2));
      // On success, transition to a success state or trigger a modal
      // For now, we'll just go back to loaded state
      emit(SendConfirmationLoaded(
        amountInput: '', // Clear input on success
        availableBalance: _availableBalance, // Update balance if necessary
        selectedAssetSymbol: _selectedAssetSymbol,
      ));
      // In a real app, you'd emit a success state or trigger navigation/modal here
    } catch (e) {
      emit(SendConfirmationError('Send failed: $e'));
    }
  }
}
