import 'screens/register.dart';
import 'screens/dashboard.dart';
import 'screens/login.dart';
import 'screens/forgot_password.dart';
import 'screens/manajemen.dart';
import 'screens/manajemen_ayam.dart';
import 'screens/manajemen_telur.dart';
import 'screens/manajemen_pakan.dart';
import 'screens/manajemen_kesehatan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TernakIn',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const LoginScreen(),
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/manajemen': (context) => const ManajemenScreen(),
        '/manajemen-ayam': (context) => const ManajemenAyamScreen(),
        '/manajemen-telur': (context) => const ManajemenTelurScreen(),
        '/manajemen-pakan': (context) => const ManajemenPakanScreen(),
        '/manajemen-kesehatan': (context) => const ManajemenKesehatanScreen(),
      },
    );
  }
}
