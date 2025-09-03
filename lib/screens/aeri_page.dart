import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'web_content_screen.dart';
import '../models/resource_model.dart';

class AeriPage extends StatelessWidget {
  const AeriPage({super.key});

  // Dynamic map of Aeri series categories and their resources
  static final Map<String, List<Resource>> _aeriSeries = {
    'Paperback Textbooks': AppData.aiPaperBackTextbooks,
    'Soft Form Key Books': AppData.aiSoftFormKeyBooks,
    'Auto Paper Generator': AppData.aiAutoPaperGenerator,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aeri Series'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _aeriSeries.entries.expand((entry) {
            final resources = entry.value;

            // Create a button for each resource
            return resources.map((resource) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: CustomButton(
                  title: resource.title,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => WebContentScreen(
                          title: resource.title,
                          contentPath: resource.htmlPath,
                          isLocal: resource.isLocal,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList();
          }).toList(),
        ),
      ),
    );
  }
}
