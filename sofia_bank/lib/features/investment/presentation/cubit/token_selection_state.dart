import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';

abstract class TokenSelectionState {}

class TokenSelectionInitial extends TokenSelectionState {}

class TokenSelectionLoading extends TokenSelectionState {}

class TokenSelectionLoaded extends TokenSelectionState {
  final List<CryptoAsset> allTokens;
  final List<CryptoAsset> filteredTokens;
  final String searchQuery;

  TokenSelectionLoaded({
    required this.allTokens,
    required this.filteredTokens,
    this.searchQuery = '',
  });
}

class TokenSelectionError extends TokenSelectionState {
  final String message;

  TokenSelectionError(this.message);
}
