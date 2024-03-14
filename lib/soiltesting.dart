// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'testresult.dart'; // Import the TextResultPage

class SoilTestingPage extends StatefulWidget {
  const SoilTestingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SoilTestingPageState createState() => _SoilTestingPageState();
}

class _SoilTestingPageState extends State<SoilTestingPage> {
  // Variables to store user input
  double? nitrogen;
  double? phosphorus;
  double? potassium;
  double? calcium;
  double? magnesium;
  double? pH;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Testing'),
        automaticallyImplyLeading: false,
        backgroundColor:
            const Color.fromARGB(255, 21, 71, 23), // Set app bar color to green
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter soil nutrient levels:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                  'Nitrogen (N)', (value) => nitrogen = double.tryParse(value)),
              const SizedBox(height: 10),
              _buildInputField('Phosphorus (P)',
                  (value) => phosphorus = double.tryParse(value)),
              const SizedBox(height: 10),
              _buildInputField('Potassium (K)',
                  (value) => potassium = double.tryParse(value)),
              const SizedBox(height: 10),
              _buildInputField(
                  'Calcium (Ca)', (value) => calcium = double.tryParse(value)),
              const SizedBox(height: 10),
              _buildInputField('Magnesium (Mg)',
                  (value) => magnesium = double.tryParse(value)),
              const SizedBox(height: 10),
              _buildInputField('pH', (value) => pH = double.tryParse(value)),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the TextResultPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TextResultPage()),
                    );
                  }, // Change button text to "Test"
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 21, 71, 23), // Change button color to green
                  ),
                  child: const Text('Find'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String labelText, Function(String)? onChanged) {
    return TextField(
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SoilTestingPage(),
  ));
}
