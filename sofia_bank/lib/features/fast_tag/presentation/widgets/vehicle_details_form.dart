import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_cubit.dart';

class VehicleDetailsForm extends StatefulWidget {
  final VoidCallback onNext;

  const VehicleDetailsForm({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  @override
  State<VehicleDetailsForm> createState() => _VehicleDetailsFormState();
}

class _VehicleDetailsFormState extends State<VehicleDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _vehicleNumberController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _vehicleClassController = TextEditingController();

  @override
  void dispose() {
    _vehicleNumberController.dispose();
    _vehicleTypeController.dispose();
    _vehicleClassController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final details = {
        'vehicleNumber': _vehicleNumberController.text,
        'vehicleType': _vehicleTypeController.text,
        'vehicleClass': _vehicleClassController.text,
      };

      context.read<FastTagCubit>().submitVehicleDetails(details);
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _vehicleNumberController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Number',
                hintText: 'Enter vehicle registration number',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _vehicleTypeController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Type',
                hintText: 'Enter vehicle type',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle type';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _vehicleClassController,
              decoration: const InputDecoration(
                labelText: 'Vehicle Class',
                hintText: 'Enter vehicle class',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle class';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
