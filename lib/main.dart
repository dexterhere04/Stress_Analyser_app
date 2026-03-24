import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'presentation/views/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: DeStresserApp()));
}

class DeStresserApp extends StatelessWidget {
  const DeStresserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeStresser',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
