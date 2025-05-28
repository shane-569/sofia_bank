import 'package:flutter/material.dart';
import 'package:sofia_bank/core/widgets/settings_menu_item.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/fast_tag/presentation/widgets/faq_section.dart';

class ContactAndSupportPage extends StatefulWidget {
  const ContactAndSupportPage({Key? key}) : super(key: key);

  @override
  _ContactAndSupportPageState createState() => _ContactAndSupportPageState();
}

class _ContactAndSupportPageState extends State<ContactAndSupportPage> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact and Support'),
      ),
      body: ListView(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                SettingsMenuItem(
                  title: 'FAQs',
                  icon: Icons.info_outline,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  showDivider: true,
                ),
                SettingsMenuItem(
                  title: 'Support',
                  icon: Icons.chat_bubble_outline,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  showDivider: true,
                ),
                SettingsMenuItem(
                  title: 'Bank Toll Free Helpline',
                  icon: Icons.call_outlined,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  showDivider: true,
                ),
                SettingsMenuItem(
                  title: 'Operational Toll Plaza',
                  icon: Icons.location_on_outlined,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  showDivider: true,
                ),
                SettingsMenuItem(
                  title: 'Feedback',
                  icon: Icons.mail_outline,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                  showDivider: true,
                ),
                SettingsMenuItem(
                  title: 'Language',
                  icon: Icons.add,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  },
                  showDivider: false,
                ),
              ],
            ),
          ),
          if (_selectedIndex != null) _buildContentSection(_selectedIndex!),
        ],
      ),
    );
  }

  Widget _buildContentSection(int index) {
    switch (index) {
      case 0:
        return FAQSection();
      case 1:
        return PlaceholderContent(title: 'Support Content');
      case 2:
        return PlaceholderContent(title: 'Bank Toll Free Helpline Content');
      case 3:
        return PlaceholderContent(title: 'Operational Toll Plaza Content');
      case 4:
        return PlaceholderContent(title: 'Feedback Content');
      case 5:
        return PlaceholderContent(title: 'Language Content');
      default:
        return Container();
    }
  }

  Widget PlaceholderContent({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
