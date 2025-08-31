import 'package:flutter/material.dart';
import '../sk_resources/paperback_textbooks.dart';
import '../sk_resources/paperback_workbooks.dart';
import '../sk_resources/soft_form_worksheets.dart';
import '../sk_resources/classroom_interactive_app.dart';
import '../sk_resources/home_interactive_app.dart';
import '../sk_resources/auto_paper_generator.dart';

class SmartKidsPage extends StatelessWidget {
  // Remove 'const' from the constructor
  SmartKidsPage({super.key});

  final List<Map<String, dynamic>> _resources = [
    {"title": "Paperback Textbooks", "page": SKPaperbackTextbooks()},
    {"title": "Paperback Workbooks", "page": SKPaperbackWorkbooks()},
    {"title": "Soft Form Worksheets", "page": SKSoftFormWorksheets()},
    {"title": "Classroom Interactive App", "page": SKClassroomInteractiveApp()},
    {"title": "Home Interactive App", "page": SKHomeInteractiveApp()},
    {"title": "Auto Paper Generator", "page": SKAutoPaperGenerator()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SmartKids Series")),
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
