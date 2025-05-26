import 'package:equatable/equatable.dart';

enum FastTagStatus { initial, loading, loaded, error }

class FastTagState extends Equatable {
  final FastTagStatus status;
  final String? error;
  final bool isRechargeLoading;
  final bool isVehicleDetailsLoading;
  final bool isPersonalDetailsLoading;
  final bool isReviewLoading;
  final Map<String, dynamic>? vehicleDetails;
  final Map<String, dynamic>? personalDetails;
  final Map<String, dynamic>? rechargeDetails;

  const FastTagState({
    this.status = FastTagStatus.initial,
    this.error,
    this.isRechargeLoading = false,
    this.isVehicleDetailsLoading = false,
    this.isPersonalDetailsLoading = false,
    this.isReviewLoading = false,
    this.vehicleDetails,
    this.personalDetails,
    this.rechargeDetails,
  });

  FastTagState copyWith({
    FastTagStatus? status,
    String? error,
    bool? isRechargeLoading,
    bool? isVehicleDetailsLoading,
    bool? isPersonalDetailsLoading,
    bool? isReviewLoading,
    Map<String, dynamic>? vehicleDetails,
    Map<String, dynamic>? personalDetails,
    Map<String, dynamic>? rechargeDetails,
  }) {
    return FastTagState(
      status: status ?? this.status,
      error: error ?? this.error,
      isRechargeLoading: isRechargeLoading ?? this.isRechargeLoading,
      isVehicleDetailsLoading:
          isVehicleDetailsLoading ?? this.isVehicleDetailsLoading,
      isPersonalDetailsLoading:
          isPersonalDetailsLoading ?? this.isPersonalDetailsLoading,
      isReviewLoading: isReviewLoading ?? this.isReviewLoading,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      personalDetails: personalDetails ?? this.personalDetails,
      rechargeDetails: rechargeDetails ?? this.rechargeDetails,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        isRechargeLoading,
        isVehicleDetailsLoading,
        isPersonalDetailsLoading,
        isReviewLoading,
        vehicleDetails,
        personalDetails,
        rechargeDetails,
      ];
}
