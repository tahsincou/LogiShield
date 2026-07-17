import 'package:flutter/material.dart';
import 'package:logishield/core/config/app_config.dart';
import 'package:logishield/core/config/environment.dart';
import 'package:logishield/core/locale/locale_extension.dart';
import 'package:logishield/shared/theme/app_text_styles.dart';

import '../../core/providers/network_providers.dart';
import '../theme/app_spacing.dart';

Future<bool?> showEnvironmentBottomSheet(BuildContext context, ref) async {
  Environment selected = AppConfig.environment;
  final availableEnvironments = [
    Environment.demo,
    Environment.development,
    Environment.staging,
    Environment.production,
  ];
  return await showModalBottomSheet<bool>(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n.address, style: AppTextStyles.heading),

                SizedBox(height: AppSpacing.lg),

                ...availableEnvironments.map(
                  (environment) => RadioListTile<Environment>(
                    value: environment,
                    groupValue: selected,
                    title: Text(environment.title),
                    subtitle: Text(environment.description),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selected = value);
                      }
                    },
                  ),
                ),

                SizedBox(height: AppSpacing.lg),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      if (selected != AppConfig.environment) {
                        await AppConfig.changeEnvironment(selected);

                        ref.invalidate(dioProvider);

                        if (context.mounted) {
                          Navigator.pop(context, true);
                        }
                      } else {
                        Navigator.pop(context, false);
                      }
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
