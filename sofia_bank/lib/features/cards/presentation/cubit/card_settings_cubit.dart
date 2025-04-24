import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/cards/domain/enums/card_status.dart';
import 'package:sofia_bank/features/cards/domain/models/card_settings.dart';
import 'package:sofia_bank/features/cards/presentation/cubit/card_settings_state.dart';

class CardSettingsCubit extends Cubit<CardSettingsState> {
  CardSettingsCubit() : super(const CardSettingsState());

  Future<void> loadCardSettings(String cardId) async {
    emit(state.copyWith(status: CardSettingsStatus.loading));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final settings = CardSettings(
        cardId: cardId,
        status: CardStatus.active,
        onlineLimit: 5000,
        posLimit: 2000,
        transferLimit: 10000,
        contactlessEnabled: true,
        onlineTransactionsEnabled: true,
      );
      emit(state.copyWith(
        status: CardSettingsStatus.success,
        settings: settings,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CardSettingsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateCardStatus(CardStatus status) async {
    if (state.settings == null) return;
    emit(state.copyWith(isSaving: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      final updatedSettings = state.settings!.copyWith(status: status);
      emit(state.copyWith(
        settings: updatedSettings,
        isSaving: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isSaving: false,
      ));
    }
  }

  Future<void> updateLimit({
    double? onlineLimit,
    double? posLimit,
    double? transferLimit,
  }) async {
    if (state.settings == null) return;
    emit(state.copyWith(isSaving: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      final updatedSettings = state.settings!.copyWith(
        onlineLimit: onlineLimit,
        posLimit: posLimit,
        transferLimit: transferLimit,
      );
      emit(state.copyWith(
        settings: updatedSettings,
        isSaving: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isSaving: false,
      ));
    }
  }

  Future<void> toggleContactless(bool enabled) async {
    if (state.settings == null) return;
    emit(state.copyWith(isSaving: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      final updatedSettings = state.settings!.copyWith(
        contactlessEnabled: enabled,
      );
      emit(state.copyWith(
        settings: updatedSettings,
        isSaving: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isSaving: false,
      ));
    }
  }

  Future<void> toggleOnlineTransactions(bool enabled) async {
    if (state.settings == null) return;
    emit(state.copyWith(isSaving: true));
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(milliseconds: 500));
      final updatedSettings = state.settings!.copyWith(
        onlineTransactionsEnabled: enabled,
      );
      emit(state.copyWith(
        settings: updatedSettings,
        isSaving: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isSaving: false,
      ));
    }
  }
}
