import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/vehicle_details/vehicle_details_cubit.dart';
import '../cubit/vehicle_details/vehicle_details_state.dart';

class VehicleDetailsPage extends StatefulWidget {
  const VehicleDetailsPage({Key? key}) : super(key: key);

  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<VehicleDetailsCubit>().fetchVehicleDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
      ),
      body: BlocBuilder<VehicleDetailsCubit, VehicleDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state.vehicleData != null) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: state.vehicleData!.entries.map((entry) {
                return VehicleDetailItem(
                  label: entry.key,
                  value: entry.value,
                );
              }).toList(),
            );
          } else {
            return const Center(child: Text('No vehicle details available.'));
          }
        },
      ),
    );
  }
}

class VehicleDetailItem extends StatelessWidget {
  final String label;
  final String value;

  const VehicleDetailItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
