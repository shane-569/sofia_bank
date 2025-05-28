import 'package:flutter/material.dart';

// Remove freezed annotations and directives
// part 'vehicle_details_state.freezed.dart';

// @freezed
class VehicleDetailsState {
  final bool isLoading;
  final String error;
  final Map<String, String>? vehicleData;

  const VehicleDetailsState({
    this.isLoading = false,
    this.error = '',
    this.vehicleData = null,
  });

  VehicleDetailsState copyWith({
    bool? isLoading,
    String? error,
    Map<String, String>? vehicleData,
  }) {
    return VehicleDetailsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      vehicleData: vehicleData ?? this.vehicleData,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, vehicleData];
}

// Remove the part of directive if present
// part of 'vehicle_details_cubit.dart';
