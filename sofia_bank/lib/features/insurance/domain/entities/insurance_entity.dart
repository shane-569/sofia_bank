import 'package:equatable/equatable.dart';

class InsuranceEntity extends Equatable {
  final String id;
  final String type;
  final String policyNumber;
  final String policyHolder;
  final DateTime validityDate;
  final String vehicleModel;
  final bool isActive;

  const InsuranceEntity({
    required this.id,
    required this.type,
    required this.policyNumber,
    required this.policyHolder,
    required this.validityDate,
    required this.vehicleModel,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        policyNumber,
        policyHolder,
        validityDate,
        vehicleModel,
        isActive,
      ];
}
