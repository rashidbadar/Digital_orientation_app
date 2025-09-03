import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'web_content_screen.dart';
import '../models/resource_model.dart';
import 'resource_grid_screen.dart';

class ReadifyPage extends StatelessWidget {
  const ReadifyPage({super.key});

  // Map of Readify series categories to their resources
  static final Map<String, List<Resource>> _rfSeries = {
    'Paperback Textbooks': AppData.rfPaperBackTextbooks,
    'Soft Form Worksheets': AppData.rfSoftFormWorksheets,
    'Home Interactive App': AppData.rfHomeInteractiveApp,
    'Auto Paper Generator': AppData.rfAutoPaperGenerator,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Readify Series'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _rfSeries.entries.expand((entry) {
            final category = entry.key;
            final resources = entry.value;

            // If multiple resources, open ResourceGridScreen
            if (resources.length > 1) {
              return [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CustomButton(
                    title: category,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => ResourceGridScreen(
                            screenTitle: 'Readify $category',
                            resources: resources,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ];
            }

            // If single resource, open directly in WebContentScreen
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
