import 'package:equatable/equatable.dart';

enum FastTagDashboardStatus { initial, loading, loaded, error }

class FastTagDashboardState extends Equatable {
  final FastTagDashboardStatus status;
  final String? error;
  final List<Map<String, dynamic>> fastTags;
  final List<String> vehicles;
  final String selectedVehicle;
  final double walletBalance;
  final List<Map<String, dynamic>> transactions;
  final String origin;
  final String destination;
  final String vehicleType;
  final double? fare;
  final Map<String, dynamic>? selectedFastTag;

  const FastTagDashboardState({
    this.status = FastTagDashboardStatus.initial,
    this.error,
    this.fastTags = const [],
    this.vehicles = const [],
    this.selectedVehicle = '',
    this.walletBalance = 0.0,
    this.transactions = const [],
    this.origin = '',
    this.destination = '',
    this.vehicleType = '',
    this.fare,
    this.selectedFastTag,
  });

  FastTagDashboardState copyWith({
    FastTagDashboardStatus? status,
    String? error,
    List<Map<String, dynamic>>? fastTags,
    List<String>? vehicles,
    String? selectedVehicle,
    double? walletBalance,
    List<Map<String, dynamic>>? transactions,
    String? origin,
    String? destination,
    String? vehicleType,
    double? fare,
    Map<String, dynamic>? selectedFastTag,
  }) {
    return FastTagDashboardState(
      status: status ?? this.status,
      error: error ?? this.error,
      fastTags: fastTags ?? this.fastTags,
      vehicles: vehicles ?? this.vehicles,
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      walletBalance: walletBalance ?? this.walletBalance,
      transactions: transactions ?? this.transactions,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      vehicleType: vehicleType ?? this.vehicleType,
      fare: fare ?? this.fare,
      selectedFastTag: selectedFastTag ?? this.selectedFastTag,
    );
  }

  @override
  List<Object?> get props => [
        status,
        error,
        fastTags,
        vehicles,
        selectedVehicle,
        walletBalance,
        transactions,
        origin,
        destination,
        vehicleType,
        fare,
        selectedFastTag
      ];
}
