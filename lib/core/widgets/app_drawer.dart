import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../localization/app_localizations.dart';
import '../localization/locale_provider.dart';
import '../theme/theme_provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/domain/entities/user.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            // User Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: user?.img != null && user!.img!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              user.img!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.person,
                                size: 30,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 30,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                  ),
                  const SizedBox(height: 12),
                  // User Name
                  Text(
                    user?.name ?? localizations?.welcome ?? 'Guest',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (user?.email != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      user!.email!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                    ),
                  ],
                ],
              ),
            ),

            // Settings Section
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 8),
                  
                  // Language Section
                  ListTile(
                    leading: Icon(
                      Icons.language,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(localizations?.language ?? 'Language'),
                    trailing: DropdownButton<Locale>(
                      value: localeProvider.locale,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(
                          value: Locale('ar'),
                          child: Text('العربية'),
                        ),
                        DropdownMenuItem(
                          value: Locale('en'),
                          child: Text('English'),
                        ),
                      ],
                      onChanged: (Locale? newLocale) {
                        if (newLocale != null) {
                          localeProvider.setLocale(newLocale);
                        }
                      },
                    ),
                  ),

                  // Theme Section
                  ListTile(
                    leading: Icon(
                      themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(localizations?.theme ?? 'Theme'),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (bool value) {
                        themeProvider.toggleTheme();
                      },
                    ),
                  ),

                  const Divider(),

                  // Settings Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      localizations?.settings ?? 'Settings',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // Logout Button at Bottom
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    // Show confirmation dialog
                    final shouldLogout = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(localizations?.logoutConfirmation ?? 'Logout'),
                        content: Text(
                          localizations?.logoutConfirmationMessage ??
                              'Are you sure you want to logout?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(localizations?.cancel ?? 'Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(localizations?.logout ?? 'Logout'),
                          ),
                        ],
                      ),
                    );

                    if (shouldLogout == true && context.mounted) {
                      // Perform logout
                      await authProvider.logout();

                      // Navigate to login screen
                      if (context.mounted) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (route) => false,
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: Text(localizations?.logout ?? 'Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

