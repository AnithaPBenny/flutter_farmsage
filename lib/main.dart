// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_farmsage/loginpage.dart';
// import 'package:flutter_farmsage/main_page.dart';
// import 'package:flutter_farmsage/otp.dart';
// import 'package:flutter_farmsage/registerpage.dart';
// import 'package:flutter_farmsage/settingspage.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     initialRoute: '/',
//     home: const LoginPage(),
//     debugShowCheckedModeBanner: false,
//     routes: {
//       '/loginPage': (context) => const LoginPage(),
//       '/registerPage': (context) => const RegisterPage(),
//       '/otpVerificationPage': (context) =>
//           const OTPVerificationPage(), // Ensure the route is correctly defined
//       '/MainPage': (context) => const MainPage(),
//       '/settingsPage': (context) => const SettingsPage(),
//     },
//   ));
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_farmsage/loginpage.dart';
import 'package:flutter_farmsage/main_page.dart';
import 'package:flutter_farmsage/registerpage.dart';
import 'package:flutter_farmsage/settingspage.dart';
import 'package:flutter_farmsage/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/loginPage': (context) => LoginPage(),
        '/registerPage': (context) => const RegisterPage(),
        '/MainPage': (context) => const MainPage(),
        '/settingsPage': (context) => const SettingsPage(),
      },
    );
  }
}
