import 'package:flutter/material.dart';
import 'package:flutter_farmsage/loginpage.dart';
import 'package:flutter_farmsage/main_page.dart';
import 'package:flutter_farmsage/registerpage.dart';
import 'package:flutter_farmsage/settingspage.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    home: const LoginPage(),
    routes: {
      '/loginPage': (context) => const LoginPage(),
      '/registerPage': (context) => const RegisterPage(),
      '/otpVerificationPage': (context) =>
          const OTPVerificationPage(), // Ensure the route is correctly defined
      '/MainPage': (context) => const MainPage(),
      '/settingsPage': (context) => const SettingsPage(),
    },
  ));
}
