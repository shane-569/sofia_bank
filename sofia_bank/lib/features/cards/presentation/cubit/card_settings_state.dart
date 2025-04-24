import 'package:equatable/equatable.dart';
import 'package:sofia_bank/features/cards/domain/models/card_settings.dart';

enum CardSettingsStatus { initial, loading, success, failure }

class CardSettingsState extends Equatable {
  final CardSettingsStatus status;
  final CardSettings? settings;
  final String? errorMessage;
  final bool isSaving;

  const CardSettingsState({
    this.status = CardSettingsStatus.initial,
    this.settings,
    this.errorMessage,
    this.isSaving = false,
  });

  CardSettingsState copyWith({
    CardSettingsStatus? status,
    CardSettings? settings,
    String? errorMessage,
    bool? isSaving,
  }) {
    return CardSettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
      errorMessage: errorMessage ?? this.errorMessage,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [status, settings, errorMessage, isSaving];
}
