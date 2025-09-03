import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'web_content_screen.dart';

class AbbasiPage extends StatelessWidget {
  const AbbasiPage({super.key});

  // Dynamic map of Abbasi series categories and their resources
  static final Map<String, List> _abbasiSeries = {
    'Paperback Textbooks': AppData.abPaperBackTextbooks,
    'Soft Form Key Books': AppData.abSoftFormKeyBooks,
    'Auto Paper Generator': AppData.abAutoPaperGenerator,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abbasi Series'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _abbasiSeries.entries.expand((entry) {
            final resources = entry.value;

            // For each resource, create a button
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
