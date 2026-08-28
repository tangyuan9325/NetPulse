import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/settings_service.dart';
import '../theme/colors.dart';
import 'dashboard_screen.dart';
import 'stress_test_screen.dart';
import 'collaboration_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    StressTestScreen(),
    CollaborationScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isChinese = context.watch<SettingsService>().isChinese;

    final titles = [
      isChinese ? '仪表盘' : 'Dashboard',
      isChinese ? '压力测试' : 'Stress Test',
      isChinese ? '协同测试' : 'Collaboration',
      isChinese ? '设置' : 'Settings',
    ];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.network_check, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Text(titles[_currentIndex]),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? AppColors.darkCard : AppColors.lightCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            activeIcon: const Icon(Icons.dashboard),
            label: isChinese ? '仪表盘' : 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.speed_outlined),
            activeIcon: const Icon(Icons.speed),
            label: isChinese ? '压测' : 'Stress',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group_outlined),
            activeIcon: const Icon(Icons.group),
            label: isChinese ? '协同' : 'Collab',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: isChinese ? '设置' : 'Settings',
          ),
        ],
      ),
    );
  }
}
