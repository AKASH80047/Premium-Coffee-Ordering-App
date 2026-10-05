import 'dart:io';
import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/app_state.dart';
import 'orders_screen.dart';
import 'favorites_screen.dart';
import 'notifications_screen.dart';
import 'generic_profile_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: ListenableBuilder(
        listenable: BreworaState(),
        builder: (context, _) {
          final profile = BreworaState().userProfile;
          final isDark = Theme.of(context).brightness == Brightness.dark;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightBeige,
                      backgroundImage: profile.photoPath != null
                          ? FileImage(File(profile.photoPath!))
                          : null,
                      child: profile.photoPath == null
                          ? const Icon(
                              Icons.person,
                              color: AppColors.coffeeBrown,
                              size: 50,
                            )
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.email,
                      style: const TextStyle(color: AppColors.textLight),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 16),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              _buildMenuSection([
                _buildMenuItem(Icons.receipt_long_rounded, 'My Orders', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.favorite_border_rounded, 'Favorites', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.location_on_outlined, 'Addresses', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GenericProfileScreen(title: 'Addresses'),
                    ),
                  );
                }),
                _buildMenuItem(Icons.payment_rounded, 'Payment Methods', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GenericProfileScreen(title: 'Payment Methods'),
                    ),
                  );
                }),
              ], isDark),

              const SizedBox(height: 24),

              _buildMenuSection([
                _buildMenuItem(
                  Icons.notifications_outlined,
                  'Notifications',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(Icons.settings_outlined, 'Settings', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GenericProfileScreen(title: 'Settings'),
                    ),
                  );
                }),

              ], isDark),
              _buildMenuSection([
                _buildMenuItem(
                  Icons.help_outline_rounded,
                  'Help & Support',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const GenericProfileScreen(title: 'Help & Support'),
                      ),
                    );
                  },
                ),
                _buildMenuItem(Icons.info_outline_rounded, 'About Brewora', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const GenericProfileScreen(title: 'About Brewora'),
                    ),
                  );
                }),
              ], isDark),

              const SizedBox(height: 24),

              // Logout button completely removed to fix the compile error
              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuSection(List<Widget> children, bool isDark) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: isDark ? AppColors.darkCard : AppColors.white,
        child: Column(children: children),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.coffeeBrown),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textLight,
      ),
      onTap: onTap,
    );
  }
}
