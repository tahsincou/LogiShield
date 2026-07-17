import 'package:flutter/material.dart';
import 'package:logishield/shared/theme/app_text_styles.dart';
import '../../core/config/app_config.dart';

class EnvironmentBadge extends StatelessWidget {
  final VoidCallback onPress;

  const EnvironmentBadge({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Text(
        AppConfig.isDemo ? '🟠 Demo Mode' : '🟢 Live Mode',
        style: AppTextStyles.body,
      ),
    );
  }
}
