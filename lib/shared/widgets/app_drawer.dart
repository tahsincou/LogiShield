import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logishield/features/auth/presentaion/providers/auth_notifier.dart';
import 'package:logishield/core/locale/locale_extension.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              accountName: Text(
                "Parcel Pathai",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              accountEmail: Text(
                "user@logistics.com",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(context.l10n.settings),
              onTap: () {
                Navigator.pop(context);
                context.push('/settings');
              },
            ),

            const Spacer(),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(context.l10n.logout),
              onTap: () async {
                await ref.read(authNotifierProvider.notifier).logout();

                if (context.mounted) {
                  context.go('/login');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
