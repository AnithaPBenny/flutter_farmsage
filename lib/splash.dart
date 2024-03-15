import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay the navigation by 2 seconds using Future.delayed
    Future.delayed(const Duration(seconds: 2), () {
      // Use pushReplacementNamed once the context is available
      Navigator.pushReplacementNamed(context, '/loginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 4, 30, 51), // Change background color to blue
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(100), // Adjust the value as needed
              child: Image.asset(
                'img/splash.png', // Replace this with your image path
                width: 200, // Adjust as needed
                height: 200, // Adjust as needed
              ),
            ),
            SizedBox(height: 20),
            Text(
              'FarmSage',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Change font color to blue
              ),
            ),
          ],
        ),
      ),
    );
  }
}
