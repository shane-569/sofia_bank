import 'package:flutter_bloc/flutter_bloc.dart';
import './vehicle_details_state.dart';

class VehicleDetailsCubit extends Cubit<VehicleDetailsState> {
  VehicleDetailsCubit() : super(const VehicleDetailsState());

  Future<void> fetchVehicleDetails() async {
    emit(state.copyWith(isLoading: true, error: ''));
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock data from the image
      final Map<String, String> mockData = {
        'Registering Authority': 'BENGALURU SOUTH RTO, Karnataka',
        'Registration No': 'K...',
        'Registration Date': '0...',
        'Chassis No': 'M...',
        'Engine No': 'J...',
        'Owner Name': 'ALBERT A',
        'Vehicle Class': 'M-Cycle/Scooter(2WN)',
        'Fuel': 'PETROL',
        'Maker / Model':
            'HONDA MOTORCYCLE AND SCOOTER INDIA (P) LTD / ACTIVA SCV110E',
        'Fitness/REGN Upto': 'C...',
        'MV Tax upto': 'LTT',
        'Insurance Upto': '19-Apr-2021',
        'PUCC Upto': 'NA',
        'Emission norms': 'Not Available',
        'RC Status': 'ACTIVE',
      };

      emit(state.copyWith(isLoading: false, vehicleData: mockData));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
