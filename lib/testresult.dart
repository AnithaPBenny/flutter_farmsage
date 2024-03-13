import 'package:flutter/material.dart';

class TextResultPage extends StatelessWidget {
  const TextResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Result'),
      ),
      body: const Center(
        child: Text(
          'Test Result will be displayed here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
