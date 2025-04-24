import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofia_bank/core/constants/app_sizes.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/cards/presentation/cubit/cards_cubit.dart';
import 'package:sofia_bank/features/cards/presentation/cubit/cards_state.dart';
import 'package:sofia_bank/features/cards/presentation/widgets/bank_card.dart';
import 'package:sofia_bank/features/cards/presentation/widgets/card_slider_indicator.dart';
import 'package:sofia_bank/features/cards/presentation/widgets/transactions_section.dart';
import 'package:sofia_bank/features/common/widgets/add_button.dart';
import 'package:sofia_bank/features/cards/presentation/widgets/transaction_list_item.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _cardAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Initialize with empty list, will be updated when cards are loaded
    _cardAnimations = [];
  }

  void _setupAnimations(int cardCount) {
    _cardAnimations = List.generate(
      cardCount,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.2, // Stagger the animations
            (index * 0.2) + 0.6,
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardsCubit()..loadCards(),
      child: BlocConsumer<CardsCubit, CardsState>(
        listener: (context, state) {
          if (state is CardsLoaded) {
            _setupAnimations(state.cards.length);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Cards',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.text2XL,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: AppSizes.spacingMD),
                  child: AddButton(
                    label: 'New card',
                    onTap: () {
                      // TODO: Implement add card
                    },
                  ),
                ),
              ],
            ),
            body: state is CardsLoaded
                ? Column(
                    children: [
                      const SizedBox(height: AppSizes.spacingXL),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: AppSizes.ccCardHeight,
                        child: PageView.builder(
                          controller: PageController(viewportFraction: 0.9),
                          itemCount: state.cards.length,
                          onPageChanged: (index) {
                            context.read<CardsCubit>().selectCard(index);
                          },
                          itemBuilder: (context, index) {
                            final card = state.cards[index];
                            return BankCard(
                              card: card,
                              isSelected: index == state.selectedCardIndex,
                              onTap: () {
                                context.read<CardsCubit>().selectCard(index);
                              },
                              animation: _cardAnimations[index],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSizes.spacingMD),
                      CardSliderIndicator(
                        itemCount: state.cards.length,
                        currentIndex: state.selectedCardIndex,
                        width: AppSizes.sliderIndicatorActiveWidth,
                      ),
                      const SizedBox(height: AppSizes.spacingXL),
                      Expanded(
                        child: _buildTransactionsList(state as CardsLoaded),
                      ),
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildTransactionsList(CardsLoaded state) {
    final selectedCard = state.cards[state.selectedCardIndex];
    final filteredTransactions =
        state.transactions.where((t) => t.cardId == selectedCard.id).toList();

    return TransactionsSection(
      transactions: filteredTransactions,
      cardNumber: selectedCard.cardNumber,
    );
  }
}
