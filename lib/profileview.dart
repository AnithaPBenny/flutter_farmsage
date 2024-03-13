import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  XFile? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  void _validateAndRegister() {
    // Add your registration logic here
    // You can access the entered values using the controllers (_nameController.text, etc.)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back arrow is pressed
          },
        ),
        title: const Text(
          "Create Profile",
          style: TextStyle(
            fontFamily: 'Times New Roman',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle three dots button press
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: const Color.fromARGB(255, 158, 158, 158),
                    child: _selectedImage != null
                        ? ClipOval(
                            child: Image.file(
                              File(_selectedImage!.path),
                              fit: BoxFit.cover,
                              width: 120.0,
                              height: 120.0,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 60.0,
                            color: Colors.white,
                          ),
                  ),
                  InkWell(
                    onTap: _selectImage,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 20.0,
                        color: Color.fromARGB(255, 15, 17, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _farmNameController,
              decoration: const InputDecoration(
                labelText: 'Farm Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _stateController,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _pincodeController,
              decoration: const InputDecoration(
                labelText: 'Pincode',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _validateAndRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[900],
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
