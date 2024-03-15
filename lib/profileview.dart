import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _passController = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController _mailController = TextEditingController();

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

    // Get the entered values
    String name = _nameController.text;
    String email = _mailController.text;
    String password = _passController.text;

    // Here, you can insert the data into the user node in the database
    _insertUserData(name, email, password);

    // Show alert for successful update
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Data updated successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _insertUserData(String name, String email, String password) {
    // Get the current user ID
    String userId = FirebaseAuth.instance.currentUser!.uid;

    // Push the user data to the database under the user node
    var _database;
    _database.child('users').child(userId).set({
      'name': name,
      'email': email,
      'password': password,
    });
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
          "Update Profile",
          style: TextStyle(
            // fontFamily: 'Times New Roman',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false, // Center the title
        backgroundColor: const Color.fromARGB(255, 1, 71, 27),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle three dots button press
            },
          ),
        ],
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
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _mailController,
              decoration: const InputDecoration(
                labelText: 'email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passController,
              decoration: const InputDecoration(
                labelText: 'password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _validateAndRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 16, 79, 18),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: const Text(
                'Update',
                style: TextStyle(
                  // fontFamily: 'Times New Roman',
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
