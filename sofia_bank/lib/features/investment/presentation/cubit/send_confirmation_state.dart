abstract class SendConfirmationState {}

class SendConfirmationInitial extends SendConfirmationState {}

class SendConfirmationLoading extends SendConfirmationState {}

class SendConfirmationLoaded extends SendConfirmationState {
  final String amountInput;
  final double availableBalance;
  final String selectedAssetSymbol;

  SendConfirmationLoaded({
    required this.amountInput,
    required this.availableBalance,
    required this.selectedAssetSymbol,
  });
}

class SendConfirmationError extends SendConfirmationState {
  final String message;

  SendConfirmationError(this.message);
}
