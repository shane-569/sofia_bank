import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/fast_tag_tracking_cubit.dart';

class FasttagTrackingPage extends StatefulWidget {
  const FasttagTrackingPage({Key? key}) : super(key: key);

  @override
  _FasttagTrackingPageState createState() => _FasttagTrackingPageState();
}

class _FasttagTrackingPageState extends State<FasttagTrackingPage>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = [];
  List<Animation<double>> _animations = [];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Tag Tracking'),
      ),
      body: BlocProvider(
        create: (context) => FasttagTrackingCubit()..fetchTrackingStatus(),
        child: BlocListener<FasttagTrackingCubit, FasttagTrackingState>(
          listener: (context, state) {
            if (state is FasttagTrackingLoaded) {
              // Initialize controllers and animations if not already done and there are steps
              if (_controllers.isEmpty && state.steps.length > 1) {
                _controllers = List.generate(
                  state.steps.length - 1,
                  (index) => AnimationController(
                    duration: const Duration(milliseconds: 500),
                    vsync: this,
                  ),
                );
                _animations = _controllers
                    .map((controller) =>
                        Tween<double>(begin: 0, end: 1).animate(controller))
                    .toList();
              }

              // Start animation for newly completed steps
              // This logic assumes steps are completed in order
              // A more robust solution would involve comparing with the previous state
              if (state.steps.length > 1) {
                for (int i = 0; i < state.steps.length - 1; i++) {
                  if (state.steps[i].isCompleted &&
                      !_controllers[i].isAnimating &&
                      !_controllers[i].isCompleted) {
                    _controllers[i].forward();
                  }
                }
              }
            }
          },
          child: BlocBuilder<FasttagTrackingCubit, FasttagTrackingState>(
            builder: (context, state) {
              if (state is FasttagTrackingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FasttagTrackingLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  itemCount: state.steps.length,
                  itemBuilder: (context, index) {
                    final step = state.steps[index];
                    final isLastStep = index == state.steps.length - 1;
                    final isFirstStep = index == 0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!isFirstStep)
                                  Container(
                                    width: 2.0,
                                    height: 40.0,
                                    color: state.steps[index - 1].isCompleted
                                        ? Colors.green
                                        : Colors.grey[400],
                                  ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: step.isCompleted || step.isCurrent
                                        ? Colors.green
                                        : Colors.grey[400],
                                  ),
                                  child: Icon(
                                    step.icon,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                if (!isLastStep)
                                  Container(
                                    width: 2.0,
                                    height: 40.0,
                                    color: step.isCompleted
                                        ? Colors.green
                                        : Colors.grey[400],
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: step.isCompleted || step.isCurrent
                                          ? Colors.black87
                                          : Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    step.description,
                                    style: TextStyle(
                                      color: step.isCompleted || step.isCurrent
                                          ? Colors.black54
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is FasttagTrackingError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
