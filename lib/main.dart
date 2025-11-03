import 'package:flutter/material.dart';
import 'pages/registerPage.dart';
import 'pages/dashboardPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeQuest Auth',
      theme: ThemeData(
        primaryColor: const Color(0xFF4256A4),
        scaffoldBackgroundColor: const Color(0xFFF0F0FF),
      ),
      home: const RegisterPageWrapper(),
    );
  }
}

/// A wrapper to handle navigation after registration
class RegisterPageWrapper extends StatelessWidget {
  const RegisterPageWrapper({super.key});

  void _navigateToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
  }

  void _switchToLogin() {
    debugPrint("Switch to login clicked");
    // Implement login page navigation if needed
  }

  @override
  Widget build(BuildContext context) {
    return RegisterPage(
      onRegister: (String username, String email) {
        debugPrint("Registered: $username, $email");
        _navigateToDashboard(context);
      },
      onSwitchToLogin: _switchToLogin,
    );
  }
}
