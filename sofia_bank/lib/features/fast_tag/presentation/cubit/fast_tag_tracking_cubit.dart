import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart'; // Import material for IconData

part 'fast_tag_tracking_state.dart';

class FasttagTrackingCubit extends Cubit<FasttagTrackingState> {
  FasttagTrackingCubit() : super(FasttagTrackingInitial());

  Future<void> fetchTrackingStatus() async {
    emit(FasttagTrackingLoading());
    // Mock API call
    await Future.delayed(const Duration(seconds: 2));

    // Mock data based on the image provided with icons
    final steps = [
      const TrackingStep(
        title: 'Order Placed',
        description: 'We have received your order.',
        isCompleted: true,
        isCurrent: false,
        icon: Icons.receipt_long,
      ),
      const TrackingStep(
        title: 'Order Confirmed',
        description: 'Your order has been confirmed.',
        isCompleted: true,
        isCurrent: false,
        icon: Icons.handshake,
      ),
      const TrackingStep(
        title: 'Order Processed',
        description: 'We are preparing your order.',
        isCompleted: false,
        isCurrent: true,
        icon: Icons.card_giftcard,
      ),
      const TrackingStep(
        title: 'Ready to Pickup',
        description: 'Your order is ready for pickup.',
        isCompleted: false,
        isCurrent: false,
        icon: Icons.all_inbox,
      ),
    ];

    emit(FasttagTrackingLoaded(steps));
  }
}
