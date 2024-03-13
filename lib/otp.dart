import 'package:flutter/material.dart';
import 'package:flutter_farmsage/main_page.dart'; // Import the MainPage

class OTPVerificationPage extends StatefulWidget {
  const OTPVerificationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    // Initialize text editing controllers for each OTP digit
    controllers = List.generate(
      6,
      (index) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    // Dispose text editing controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Function to validate the entered OTP
  bool validateOTP(String otp) {
    // Logic to validate OTP (e.g., compare with the actual OTP sent to the user)
    return otp == '123456'; // Change '123456' to the actual OTP
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the verification code we just sent on your phone number.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 40,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Concatenate OTP digits from controllers
                  final otp =
                      controllers.map((controller) => controller.text).join();
                  // Validate OTP
                  if (validateOTP(otp)) {
                    // If OTP is correct, navigate to the MainPage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  } else {
                    // If OTP is incorrect, show error message
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Incorrect OTP. Please try again.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
