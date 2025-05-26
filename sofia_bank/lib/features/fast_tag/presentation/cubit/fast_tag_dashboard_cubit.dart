import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_dashboard_state.dart';

class FastTagDashboardCubit extends Cubit<FastTagDashboardState> {
  FastTagDashboardCubit()
      : super(const FastTagDashboardState(
          vehicles: ['KA01AB1234', 'MH12AB1234'],
          selectedVehicle: 'KA01AB1234',
          walletBalance: 235.0,
          transactions: [
            {'date': '2024-06-01', 'amount': -50.0, 'desc': 'Toll Plaza'},
            {'date': '2024-05-30', 'amount': 500.0, 'desc': 'Recharge'},
          ],
          origin: '',
          destination: '',
          vehicleType: '',
          fare: null,
        ));

  Future<void> fetchFastTags() async {
    try {
      emit(state.copyWith(
        status: FastTagDashboardStatus.loading,
      ));

      // TODO: Implement API call to fetch Fast Tags
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      // Simulated data
      final fastTags = [
        {
          'id': '1',
          'vehicleNumber': 'KA01AB1234',
          'vehicleType': 'Car',
          'balance': '₹500',
          'status': 'Active',
          'lastRecharge': '2024-03-15',
        },
        {
          'id': '2',
          'vehicleNumber': 'MH12AB1234',
          'vehicleType': 'Car',
          'balance': '₹750',
          'status': 'Active',
          'lastRecharge': '2024-03-20',
        },
      ];

      // Find the initial selected Fast Tag
      Map<String, dynamic>? initialSelectedFastTag;
      for (var tag in fastTags) {
        if (tag['vehicleNumber'] == state.selectedVehicle) {
          initialSelectedFastTag = tag;
          break;
        }
      }

      emit(state.copyWith(
        status: FastTagDashboardStatus.loaded,
        fastTags: fastTags,
        selectedFastTag: initialSelectedFastTag,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FastTagDashboardStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> rechargeFastTag(String id, String amount) async {
    try {
      emit(state.copyWith(
        status: FastTagDashboardStatus.loading,
      ));

      // TODO: Implement API call to recharge Fast Tag
      await Future.delayed(const Duration(seconds: 1)); // Simulated API call

      // Update the Fast Tag balance in the list
      final updatedFastTags = state.fastTags.map((tag) {
        if (tag['id'] == id) {
          final currentBalance = int.parse(tag['balance'].replaceAll('₹', ''));
          final rechargeAmount = int.parse(amount);
          return {
            ...tag,
            'balance': '₹${currentBalance + rechargeAmount}',
            'lastRecharge': DateTime.now().toString().split(' ')[0],
          };
        }
        return tag;
      }).toList();

      emit(state.copyWith(
        status: FastTagDashboardStatus.loaded,
        fastTags: updatedFastTags,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FastTagDashboardStatus.error,
        error: e.toString(),
      ));
    }
  }

  void resetState() {
    emit(const FastTagDashboardState());
  }

  void selectVehicle(String vehicle) {
    Map<String, dynamic>? selectedFastTag;
    for (var tag in state.fastTags) {
      if (tag['vehicleNumber'] == vehicle) {
        selectedFastTag = tag;
        break;
      }
    }
    print('Cubit - Selected Fast Tag before emit: $selectedFastTag');
    emit(state.copyWith(
      selectedVehicle: vehicle,
      selectedFastTag: selectedFastTag,
    ));
  }

  void recharge(double amount) {
    emit(state.copyWith(walletBalance: state.walletBalance + amount));
  }

  void setOrigin(String origin) {
    emit(state.copyWith(origin: origin));
  }

  void setDestination(String destination) {
    emit(state.copyWith(destination: destination));
  }

  void setVehicleType(String type) {
    emit(state.copyWith(vehicleType: type));
  }

  void calculateFare() {
    // Dummy calculation
    if (state.origin.isNotEmpty &&
        state.destination.isNotEmpty &&
        state.vehicleType.isNotEmpty) {
      emit(state.copyWith(fare: 120.0));
    }
  }
}
