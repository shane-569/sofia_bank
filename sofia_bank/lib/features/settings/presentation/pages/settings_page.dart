import 'package:flutter/material.dart';
import 'package:sofia_bank/core/theme/app_colors.dart';
import 'package:sofia_bank/features/settings/presentation/widgets/settings_list_item.dart';
import 'package:sofia_bank/core/routes/app_routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.dark_mode_outlined, color: AppColors.primary),
            onPressed: () {
              // TODO: Implement theme toggle
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: 'Account',
                icon: Icons.person_outline,
                children: [
                  SettingsListItem(
                    title: 'Edit Profile',
                    onTap: () {},
                    showDivider: false,
                  ),
                  SettingsListItem(
                    title: 'Change Password',
                    onTap: () {},
                    showDivider: false,
                  ),
                  SettingsListItem(
                    title: 'Connect Social',
                    onTap: () {},
                    showDivider: false,
                  ),
                ],
              ),
              _buildSection(
                title: 'Notifications',
                icon: Icons.notifications_none_rounded,
                children: [
                  SettingsListItem(
                    title: 'Notifications',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.primary,
                    ),
                    showDivider: false,
                  ),
                  SettingsListItem(
                    title: 'App Notifications',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.primary,
                    ),
                    showDivider: false,
                  ),
                ],
              ),
              _buildSection(
                title: 'More',
                icon: Icons.map_outlined,
                children: [
                  SettingsListItem(
                    title: 'Language',
                    onTap: () {},
                    showDivider: false,
                  ),
                  SettingsListItem(
                    title: 'State',
                    onTap: () {},
                    showDivider: false,
                  ),
                  SettingsListItem(
                    title: 'Contact and Support',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.contactAndSupport);
                    },
                    showDivider: false,
                  ),
                ],
              ),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
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
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextButton.icon(
        onPressed: () {},
        icon: const Icon(
          Icons.logout,
          color: AppColors.error,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            color: AppColors.error,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
