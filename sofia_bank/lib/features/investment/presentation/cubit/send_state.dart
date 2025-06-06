import 'package:sofia_bank/features/investment/domain/models/recipient.dart';

abstract class SendState {}

class SendInitial extends SendState {}

class SendLoading extends SendState {}

class SendLoaded extends SendState {
  final List<Recipient> recipients;

  SendLoaded({required this.recipients});
}

class SendError extends SendState {
  final String message;

  SendError(this.message);
}
