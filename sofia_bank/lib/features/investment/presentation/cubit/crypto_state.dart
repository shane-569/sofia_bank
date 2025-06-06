import 'package:sofia_bank/features/investment/domain/models/crypto_asset.dart';

abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<CryptoAsset> assets;
  final CryptoAsset? selectedAsset;

  CryptoLoaded({
    required this.assets,
    this.selectedAsset,
  });
}

class CryptoError extends CryptoState {
  final String message;

  CryptoError(this.message);
}
