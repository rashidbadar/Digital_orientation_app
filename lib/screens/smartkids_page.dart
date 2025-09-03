import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'web_content_screen.dart';
import '../models/resource_model.dart';
import 'resource_grid_screen.dart';

class SmartKidsPage extends StatelessWidget {
  const SmartKidsPage({super.key});

  // Map of SmartKids series categories to their resources
  static final Map<String, List<Resource>> _skSeries = {
    'Paperback Textbooks': AppData.skPaperBackTextbooks,
    'Paperback Workbooks': AppData.skPaperBackWorkbooks,
    'Soft Form Worksheets': AppData.skSoftFormWorksheets,
    'Classroom Interactive App': AppData.skClassroomInteractiveApp,
    'Home Interactive App': AppData.skHomeInteractiveApp,
    'Auto Paper Generator': AppData.skAutoPaperGenerator,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartKids Series'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _skSeries.entries.expand((entry) {
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
                            screenTitle: 'SmartKids $category',
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
