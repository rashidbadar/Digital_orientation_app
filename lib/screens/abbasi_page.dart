// lib/screens/abbasi_page.dart
import 'package:flutter/material.dart';

// Import all AB Resources pages
import '../ab_resources/paperback_textbooks.dart';
import '../ab_resources/soft_form_key_books.dart';
import '../ab_resources/auto_paper_generator.dart';

class AbbasiPage extends StatelessWidget {
  AbbasiPage({super.key});

  // List of AB resources with correct class names
  final List<Map<String, dynamic>> _resources = [
    {"title": "Paperback Textbooks", "page": const ABPaperbackTextbooks()},
    {"title": "Soft Form Key Books", "page": const ABSoftFormKeyBooks()},
    {"title": "Auto Paper Generator", "page": const ABAutoPaperGenerator()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Abbasi Series")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _resources.length,
          itemBuilder: (context, index) {
            final resource = _resources[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => resource['page']),
                  );
                },
                child: Text(resource['title']),
              ),
            );
          },
        ),
      ),
    );
  }
}
