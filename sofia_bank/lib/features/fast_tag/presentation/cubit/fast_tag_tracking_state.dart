part of 'fast_tag_tracking_cubit.dart';

abstract class FasttagTrackingState extends Equatable {
  const FasttagTrackingState();

  @override
  List<Object> get props => [];
}

class FasttagTrackingInitial extends FasttagTrackingState {}

class FasttagTrackingLoading extends FasttagTrackingState {}

class FasttagTrackingLoaded extends FasttagTrackingState {
  final List<TrackingStep> steps;

  const FasttagTrackingLoaded(this.steps);

  @override
  List<Object> get props => [steps];
}

class FasttagTrackingError extends FasttagTrackingState {
  final String message;

  const FasttagTrackingError(this.message);

  @override
  List<Object> get props => [message];
}

class TrackingStep extends Equatable {
  final String title;
  final String description;
  final bool isCompleted;
  final bool isCurrent;
  final IconData icon;

  const TrackingStep({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.isCurrent,
    required this.icon,
  });

  @override
  List<Object> get props => [title, description, isCompleted, isCurrent, icon];
}
