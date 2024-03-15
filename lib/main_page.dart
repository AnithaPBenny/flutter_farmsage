import 'package:flutter/material.dart';
import 'package:flutter_farmsage/settingspage.dart'; // Import the SettingsPage
import 'soiltesting.dart'; // Import the SoilTestingPage

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        automaticallyImplyLeading: false,
        centerTitle: false, // Center the title
        backgroundColor: const Color.fromARGB(
            255, 1, 71, 27), // Change app bar color to green
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBox(
                  icon: Icons.water_damage,
                  label: 'Moisture',
                  onPressed: () {
                    // Add your logic for moisture button here
                  },
                ),
                const SizedBox(width: 20),
                ButtonBox(
                  icon: Icons.thermostat,
                  label: 'Temperature',
                  onPressed: () {
                    // Add your logic for temperature button here
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBox(
                  icon: Icons.wb_sunny,
                  label: 'Light Level',
                  onPressed: () {
                    // Add your logic for light level button here
                  },
                ),
                const SizedBox(width: 20),
                ButtonBox(
                  icon: Icons.cloud,
                  label: 'Humidity',
                  onPressed: () {
                    // Add your logic for humidity button here
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ButtonBox(
              icon: Icons.terrain,
              label: 'Find your crop',
              onPressed: () {
                // Navigate to soil testing page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SoilTestingPage()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          }
        },
      ),
    );
  }
}

class ButtonBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ButtonBox({
    required this.icon,
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate the width of the button based on the length of the label
    double buttonWidth =
        label.length * 12.0 + 40.0; // Adjust the multiplier as needed

    return SizedBox(
      width: buttonWidth,
      height: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 1, 71, 27),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            // Adjust the textAlign to center the text
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
