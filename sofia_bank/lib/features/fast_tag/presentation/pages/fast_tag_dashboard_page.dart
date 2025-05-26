// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sofia_bank/core/constants/app_assets.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/fast_tag/presentation/cubit/fast_tag_dashboard_cubit.dart';

class FastTagDashboardPage extends StatefulWidget {
  const FastTagDashboardPage({Key? key}) : super(key: key);

  @override
  State<FastTagDashboardPage> createState() => _FastTagDashboardPageState();
}

class _FastTagDashboardPageState extends State<FastTagDashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<FastTagDashboardCubit>().fetchFastTags();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'Selected Fast Tag: ${context.watch<FastTagDashboardCubit>().state.selectedFastTag}');
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Fast Tag'),
        backgroundColor: AppColors.white70,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle Selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Vehicle No.',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  DropdownButton<String>(
                    value: context
                        .watch<FastTagDashboardCubit>()
                        .state
                        .selectedVehicle,
                    underline: const SizedBox(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: AppColors.text),
                    items: context
                        .watch<FastTagDashboardCubit>()
                        .state
                        .vehicles
                        .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null)
                        context.read<FastTagDashboardCubit>().selectVehicle(v);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Fast Tag Card
            if (context.watch<FastTagDashboardCubit>().state.selectedFastTag !=
                null)
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Fast Tag Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                  context
                                      .watch<FastTagDashboardCubit>()
                                      .state
                                      .selectedFastTag!['status'],
                                  style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Tag ID',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(
                                      context
                                          .watch<FastTagDashboardCubit>()
                                          .state
                                          .selectedFastTag!['id'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Vehicle Type',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(
                                      context
                                          .watch<FastTagDashboardCubit>()
                                          .state
                                          .selectedFastTag!['vehicleType'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Last Recharge',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(
                                      context
                                          .watch<FastTagDashboardCubit>()
                                          .state
                                          .selectedFastTag!['lastRecharge'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Balance',
                                      style: TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text(
                                      context
                                          .watch<FastTagDashboardCubit>()
                                          .state
                                          .selectedFastTag!['balance'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.3,
                      child: SvgPicture.asset(
                        AppAssets.wavey,
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            // Wallet Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.account_balance_wallet_outlined,
                            color: AppColors.primary, size: 32),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Wallet Balance',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(
                                '₹ ${context.read<FastTagDashboardCubit>().state.walletBalance.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.fastTagWallet);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 12),
                          ),
                          child: const Text('Recharge',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('Wallet Transactions',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.info_outline,
                                  size: 16, color: AppColors.textSecondary),
                            ],
                          ),
                          Icon(Icons.chevron_right,
                              color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Toll Fare Calculator
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Toll Fare Calculator',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .origin
                                  .isNotEmpty
                              ? context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .origin
                              : null,
                          decoration:
                              const InputDecoration(labelText: 'Origin'),
                          items: ['Delhi', 'Mumbai', 'Bangalore', 'Chennai']
                              .map((city) => DropdownMenuItem(
                                  value: city, child: Text(city)))
                              .toList(),
                          onChanged: (v) => context
                              .read<FastTagDashboardCubit>()
                              .setOrigin(v ?? ''),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: const BoxDecoration(
                          color: AppColors.orange,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.swap_horiz,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .destination
                                  .isNotEmpty
                              ? context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .destination
                              : null,
                          decoration:
                              const InputDecoration(labelText: 'Destination'),
                          items: ['Delhi', 'Mumbai', 'Bangalore', 'Chennai']
                              .map((city) => DropdownMenuItem(
                                  value: city, child: Text(city)))
                              .toList(),
                          onChanged: (v) => context
                              .read<FastTagDashboardCubit>()
                              .setDestination(v ?? ''),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: context
                            .read<FastTagDashboardCubit>()
                            .state
                            .vehicleType
                            .isNotEmpty
                        ? context
                            .read<FastTagDashboardCubit>()
                            .state
                            .vehicleType
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Select Vehicle Type',
                      filled: true,
                      fillColor: Color(0xFFF5F5F5),
                      border: InputBorder.none,
                    ),
                    items: ['Car', 'Truck', 'Bus', 'Bike']
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (v) => context
                        .read<FastTagDashboardCubit>()
                        .setVehicleType(v ?? ''),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: (context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .origin
                                  .isNotEmpty &&
                              context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .destination
                                  .isNotEmpty &&
                              context
                                  .read<FastTagDashboardCubit>()
                                  .state
                                  .vehicleType
                                  .isNotEmpty)
                          ? () => context
                              .read<FastTagDashboardCubit>()
                              .calculateFare()
                          : null,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: AppColors.textSecondary.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        context.read<FastTagDashboardCubit>().state.fare != null
                            ? '₹ ${context.read<FastTagDashboardCubit>().state.fare!.toStringAsFixed(2)}'
                            : 'Calculate',
                        style: TextStyle(
                          color: context
                                      .read<FastTagDashboardCubit>()
                                      .state
                                      .fare !=
                                  null
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Disclaimer',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  const Text('• Toll Fare is subject to route choosen.',
                      style: TextStyle(fontSize: 13)),
                  const Text('• Toll Fare is for National Highways only.',
                      style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Issue New FASTag
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.fastTag);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.orange.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.local_offer,
                          color: AppColors.orange, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text('Issue New FASTTAG',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                    ),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textSecondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
