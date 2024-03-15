import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({Key? key}) : super(key: key);

  @override
  _CreateProfilePageState createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  XFile? _selectedImage;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();

  bool _editingMode = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    // Fetch current user details when the page initializes
    _fetchCurrentUserDetails();
  }

  void _fetchCurrentUserDetails() {
    // Fetch current user details from Firebase and populate the text fields
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _mailController.text = user.email ?? '';
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  void _toggleEditingMode() {
    setState(() {
      _editingMode = true;
    });
  }

  void _togglePasswordVisibility() async {
    if (!_showPassword) {
      // Re-authenticate user to get password
      try {
        User user = FirebaseAuth.instance.currentUser!;
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: _passController.text);
        await user.reauthenticateWithCredential(credential);

        // If re-authentication is successful, show the password
        setState(() {
          _showPassword = true;
        });

        // Optional: Log re-authentication success
        print("Re-authentication successful");
      } catch (e) {
        // Handle re-authentication error
        print("Re-authentication failed: $e");
      }
    } else {
      // Hide the password
      setState(() {
        _showPassword = false;
      });
    }
  }

  void _updateProfile() {
    // Update profile logic
    try {
      User user = FirebaseAuth.instance.currentUser!;
      String name = _nameController.text;
      String email = _mailController.text;

      // Update user information in Firebase Authentication
      user.updateDisplayName(name);
      user.updateEmail(email);

      // Optional: Log successful update
      print("User profile updated successfully");

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('User profile updated successfully.'),
            actions: <Widget>[
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

      // Update user information in Realtime Database
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users').child(user.uid);
      userRef.update({
        'name': name,
        'email': email,
      });

      // Exit editing mode
      setState(() {
        _editingMode = false;
      });
    } catch (e) {
      // Handle update error
      print("Failed to update profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_editingMode)
            IconButton(
              icon: const Icon(Icons.done, color: Colors.white),
              onPressed: _updateProfile,
            ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: _toggleEditingMode,
          ),
        ],
        centerTitle: false, // Center the title
        backgroundColor: const Color.fromARGB(255, 1, 71, 27),
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
              enabled: _editingMode,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _mailController,
              enabled: _editingMode,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passController,
              enabled: _editingMode,
              style: const TextStyle(color: Colors.black),
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black),
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
