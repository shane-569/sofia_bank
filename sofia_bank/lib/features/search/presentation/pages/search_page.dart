import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/common/widgets/service_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Search'),
            backgroundColor: Colors.transparent,
            border: const Border(),
            middle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search for services...',
                onChanged: (value) {
                  // TODO: Implement search functionality
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Our Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                ServiceCard(
                  title: 'Cards',
                  date: 'Credit & Debit Cards',
                  imagePath: 'assets/images/cards.jpg',
                  onTap: () {},
                ),
                ServiceCard(
                  title: 'Loans',
                  date: 'Personal & Business Loans',
                  imagePath: 'assets/images/loans.jpg',
                  onTap: () {},
                ),
                ServiceCard(
                  title: 'Deposits',
                  date: 'Fixed & Recurring Deposits',
                  imagePath: 'assets/images/deposits.jpg',
                  onTap: () {},
                ),
                ServiceCard(
                  title: 'Insurance',
                  date: 'Life & Health Insurance',
                  imagePath: 'assets/images/insurance.jpg',
                  onTap: () {},
                ),
                ServiceCard(
                  title: 'NRI Services',
                  date: 'Banking for Non-Residents',
                  imagePath: 'assets/images/nri.jpg',
                  onTap: () {},
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
