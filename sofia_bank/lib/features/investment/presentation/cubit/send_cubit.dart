import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/investment/domain/models/recipient.dart';
import 'package:sofia_bank/features/investment/presentation/cubit/send_state.dart';

class SendCubit extends Cubit<SendState> {
  SendCubit() : super(SendInitial());

  Future<void> loadRecipients() async {
    emit(SendLoading());

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      final mockRecipients = [
        Recipient(
          name: 'Bessie Cooper',
          address: '0xndhfhdf...kjueu',
          imageUrl:
              'https://randomuser.me/api/portraits/women/1.jpg', // Mock image
        ),
        Recipient(
          name: 'Jerome Bell',
          address: '0xndhfhdf...kjueu',
          imageUrl:
              'https://randomuser.me/api/portraits/men/1.jpg', // Mock image
        ),
        Recipient(
          name: 'Marvin McKinney',
          address: '0xndhfhdf...kjueu',
          imageUrl:
              'https://randomuser.me/api/portraits/men/2.jpg', // Mock image
        ),
        Recipient(
          name: 'Kathryn Murphy',
          address: '0xndhfhdf...kjueu',
          imageUrl:
              'https://randomuser.me/api/portraits/women/2.jpg', // Mock image
        ),
        Recipient(
          name: 'Ralph Edwards',
          address: '0xndhfhdf...kjueu',
          imageUrl:
              'https://randomuser.me/api/portraits/men/3.jpg', // Mock image
        ),
      ];

      emit(SendLoaded(recipients: mockRecipients));
    } catch (e) {
      emit(SendError('Failed to load recipients: $e'));
    }
  }
}
