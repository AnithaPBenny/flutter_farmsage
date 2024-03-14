import 'package:flutter/material.dart';
import 'package:flutter_farmsage/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        // Centering the content vertically
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello! Register to get Started',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(20, 94, 51, 1),
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputBox(
                  labelText: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                ),
                const SizedBox(height: 10.0),
                _buildInputBox(
                  labelText: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 10.0),
                _buildInputBox(
                  labelText: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        // Passwords do not match
                        return;
                      }

                      try {
                        UserCredential userCredential =
                            await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (!userCredential.user!.emailVerified) {
                          // If email is not verified, send verification email
                          await userCredential.user!.sendEmailVerification();
                          // Show alert dialog to inform the user to verify their email
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Verify your email'),
                                content: const Text(
                                    'A verification email has been sent to your email address. Please verify your email before proceeding.'),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }

                        // // If successful, navigate to main page
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MainPage()),
                        // );
                      } catch (e) {
                        // Handle errors
                        print(e);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromRGBO(17, 84, 19, 1)),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBox({
    required String labelText,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType? keyboardType,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RegisterPage(),
  ));
}
