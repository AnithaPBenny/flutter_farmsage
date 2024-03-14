import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to Use the Application:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  'Login or Register:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'When you open the application, you\'ll be presented with a login screen.',
                        ),
                        Text(
                          'If you already have an account, you can simply enter your credentials (username and password) and click on the login button to proceed.',
                        ),
                        Text(
                          'If you\'re a new user, you need to click on the "Register" button to create a new account. Follow the prompts to enter your details and register.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  'Find Recommended Crop:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'After logging in, you\'ll be taken to the main page.',
                        ),
                        Text(
                          'Look for the "Find Crop" button on the main page and click on it.',
                        ),
                        Text(
                          'This will take you to a page where you can input various parameters such as soil type, climate conditions, available resources, etc.',
                        ),
                        Text(
                          'After providing these parameters, click on the "Search" or "Find" button to get a list of recommended crops that are suitable for your conditions.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  'View Greenhouse Parameters:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'On the main page or in the settings/navigation menu, you\'ll find an option to view greenhouse parameters.',
                        ),
                        Text(
                          'Click on this option to access a page where you can view various parameters.',
                        ),
                        Text(
                          'These parameters may help you monitor and adjust the conditions inside the greenhouse for optimal crop growth.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'For further assistance, contact us:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: +1234567890',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Email: farmsage@gmail.com',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: const HelpPage(),
  ));
}
