import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_registration_cubit.dart';

class FastTagPage extends StatelessWidget {
  const FastTagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FastTagRegistrationCubit(),
      child: BlocBuilder<FastTagRegistrationCubit, FastTagRegistrationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              title: const Text('Register'),
              backgroundColor: AppColors.background,
              elevation: 0,
              foregroundColor: AppColors.text,
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                _FastTagStepper(currentStep: state.currentStep),
                const SizedBox(height: 16),
                Expanded(
                  child: IndexedStack(
                    index: state.currentStep,
                    children: const [
                      _RegisterStep(),
                      _OtpStep(),
                      _PinStep(),
                      _UploadDocStep(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FastTagStepper extends StatelessWidget {
  final int currentStep;
  const _FastTagStepper({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Register',
      'Verification',
      'Upload Doc',
    ];
    const double circleSize = 28;
    const double lineHeight = 2;
    const double lineWidth = 60;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(steps.length * 2 - 1, (i) {
            if (i.isEven) {
              // Step circle
              final stepIndex = i ~/ 2;
              final isActive = currentStep == stepIndex;
              final isCompleted = currentStep > stepIndex;
              return Column(
                children: [
                  Container(
                    width: circleSize,
                    height: circleSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (isActive || isCompleted)
                          ? AppColors.primary
                          : Colors.transparent,
                      border: Border.all(
                        color: (isActive || isCompleted)
                            ? AppColors.primary
                            : AppColors.textSecondary.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${stepIndex + 1}',
                        style: TextStyle(
                          color: (isActive || isCompleted)
                              ? Colors.white
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 100,
                    child: Text(
                      steps[stepIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              // Line between circles
              final leftStep = (i - 1) ~/ 2;
              final isActiveLine = currentStep > leftStep;
              return Column(
                children: [
                  Container(
                    width: lineWidth,
                    height: lineHeight,
                    color: isActiveLine
                        ? AppColors.primary
                        : AppColors.textSecondary.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              );
            }
          }),
        ),
      ],
    );
  }
}

class _RegisterStep extends StatefulWidget {
  const _RegisterStep();
  @override
  State<_RegisterStep> createState() => _RegisterStepState();
}

class _RegisterStepState extends State<_RegisterStep> {
  final _formKey = GlobalKey<FormState>();
  String? _category = 'Bike/Scooty';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FastTagRegistrationCubit>();
    final state = context.watch<FastTagRegistrationCubit>().state;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Lets Get Started',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 24),
            const Text('Full Name',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: state.formData['fullName'] ?? '',
              decoration: const InputDecoration(
                hintText: 'name@example.com',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onChanged: (v) => cubit.updateFormData({'fullName': v}),
            ),
            const SizedBox(height: 16),
            const Text('Mobile No.',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: state.formData['mobile'] ?? '',
              decoration: const InputDecoration(
                hintText: '99XXXXXXXX',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null || v.length != 10 ? 'Enter valid number' : null,
              onChanged: (v) => cubit.updateFormData({'mobile': v}),
            ),
            const SizedBox(height: 16),
            const Text('Vehicle Number',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: state.formData['vehicleNumber'] ?? '',
              decoration: const InputDecoration(
                hintText: 'DL3CCXXXX',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onChanged: (v) => cubit.updateFormData({'vehicleNumber': v}),
            ),
            const SizedBox(height: 16),
            const Text('Chassis Number',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            TextFormField(
              initialValue: state.formData['chassisNumber'] ?? '',
              decoration: const InputDecoration(
                hintText: 'XXXXXXXXXXXXXXXXXXXX',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              onChanged: (v) => cubit.updateFormData({'chassisNumber': v}),
            ),
            const SizedBox(height: 16),
            const Text('Category',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Flexible(child: _buildRadio('Bike/Scooty')),
                Flexible(child: _buildRadio('Car/Jeep/Van')),
                Flexible(child: _buildRadio('Truck/Other')),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    cubit.nextStep();
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Next',
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio(String value) {
    final cubit = context.read<FastTagRegistrationCubit>();
    final state = context.watch<FastTagRegistrationCubit>().state;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: state.formData['category'] ?? _category,
          activeColor: AppColors.primary,
          onChanged: (v) {
            cubit.updateFormData({'category': v});
            setState(() => _category = v);
          },
        ),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value, style: const TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }
}

class _OtpStep extends StatefulWidget {
  const _OtpStep();
  @override
  State<_OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<_OtpStep> {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FastTagRegistrationCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('Verification',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('We will send you a one time password on Mobile Number',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => _focusNode.requestFocus(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (i) {
                return Container(
                  width: 48,
                  height: 56,
                  margin: EdgeInsets.only(right: i < 3 ? 12 : 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.textSecondary.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _otpController.text.length > i
                          ? _otpController.text[i]
                          : '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Hidden TextField for OTP input
          SizedBox(
            height: 0,
            width: 0,
            child: TextField(
              controller: _otpController,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              maxLength: 4,
              onChanged: (v) => setState(() {}),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(color: Colors.transparent),
              cursorColor: Colors.transparent,
              autofocus: true,
              enableInteractiveSelection: false,
              showCursor: false,
              obscureText: true,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {},
            child: const Text('Resend it',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                    decoration: TextDecoration.underline)),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                if (_otpController.text.length == 4) {
                  cubit.nextStep();
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Submit OTP',
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _PinStep extends StatefulWidget {
  const _PinStep();
  @override
  State<_PinStep> createState() => _PinStepState();
}

class _PinStepState extends State<_PinStep> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FastTagRegistrationCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('Set Pin',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => _focusNode.requestFocus(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(4, (i) {
                return Container(
                  width: 48,
                  height: 56,
                  margin: EdgeInsets.only(right: i < 3 ? 12 : 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.textSecondary.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      _pinController.text.length > i
                          ? _pinController.text[i]
                          : '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Hidden TextField for PIN input
          SizedBox(
            height: 0,
            width: 0,
            child: TextField(
              controller: _pinController,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              maxLength: 4,
              onChanged: (v) => setState(() {}),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(color: Colors.transparent),
              cursorColor: Colors.transparent,
              autofocus: true,
              enableInteractiveSelection: false,
              showCursor: false,
              obscureText: true,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                if (_pinController.text.length == 4) {
                  cubit.nextStep();
                }
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Enter PIN CODE',
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _UploadDocStep extends StatefulWidget {
  const _UploadDocStep();
  @override
  State<_UploadDocStep> createState() => _UploadDocStepState();
}

class _UploadDocStepState extends State<_UploadDocStep> {
  bool _isVehicleOld = false;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FastTagRegistrationCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text('Upload Document',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: const [
              Icon(Icons.cloud_upload, color: AppColors.primary),
              SizedBox(width: 8),
              Text("Driver's License*",
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.cloud_upload, color: AppColors.primary),
              SizedBox(width: 8),
              Text("Registration Certificate*",
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _uploadBox('Front View'),
              const SizedBox(width: 16),
              _uploadBox('Back View'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _isVehicleOld,
                onChanged: (v) {
                  setState(() => _isVehicleOld = v ?? false);
                  cubit.setCheckbox(v ?? false);
                },
                activeColor: AppColors.primary,
              ),
              const Text('The vehicle is over 3 years old'),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                // Final submission logic here
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Done',
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _uploadBox(String label) {
    return Expanded(
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 13, color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            const Text('Upload',
                style: TextStyle(fontSize: 13, color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
