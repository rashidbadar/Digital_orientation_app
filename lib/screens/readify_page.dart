// lib/screens/readify_page.dart
import 'package:flutter/material.dart';

// Import all RF Resources pages
import '../rf_resources/paperback_textbooks.dart';
import '../rf_resources/soft_form_worksheets.dart';
import '../rf_resources/home_interactive_app.dart';
import '../rf_resources/auto_paper_generator.dart';

class ReadifyPage extends StatelessWidget {
  ReadifyPage({super.key});

  // List of RF resources with correct class names
  final List<Map<String, dynamic>> _resources = [
    {"title": "Paperback Textbooks", "page": const RFPaperbackTextbooks()},
    {"title": "Soft Form Worksheets", "page": const RFSoftFormWorksheets()},
    {"title": "Home Interactive App", "page": const RFHomeInteractiveApp()},
    {"title": "Auto Paper Generator", "page": const RFAutoPaperGenerator()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Readify Series")),
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
