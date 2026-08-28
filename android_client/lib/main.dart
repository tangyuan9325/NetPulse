import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'services/settings_service.dart';
import 'services/auth_manager.dart';
import 'services/system_monitor.dart';
import 'services/stress_tester.dart';
import 'services/collaboration_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsService = SettingsService();
  await settingsService.load();

  final authManager = AuthManager();
  await authManager.load();

  final systemMonitor = SystemMonitor();
  final stressTester = StressTester();
  final collaborationService = CollaborationService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsService),
        ChangeNotifierProvider(create: (_) => authManager),
        ChangeNotifierProvider(create: (_) => systemMonitor),
        ChangeNotifierProvider(create: (_) => stressTester),
        ChangeNotifierProvider(create: (_) => collaborationService),
      ],
      child: const NetPulseApp(),
    ),
  );
}
