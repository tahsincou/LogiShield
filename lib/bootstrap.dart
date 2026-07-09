import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logishield/core/app.dart';
import 'package:logishield/core/config/app_config.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.initialize();

  runApp(const ProviderScope(child: App()));
}
