import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'resource_grid_screen.dart';
import 'web_content_screen.dart'; // ← CHANGED IMPORT

class ReadifyPage extends StatelessWidget {
  const ReadifyPage({super.key});

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
          children: [
            CustomButton(
              title: 'Paperback Textbooks',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'Readify Paperback Textbooks',
                      resources: AppData.rfPaperBackTextbooks,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Soft Form Worksheets',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'Readify Soft Form Worksheets',
                      resources: AppData.rfSoftFormWorksheets,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Home Interactive App',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'Readify Home Interactive App',
                      resources: AppData.rfHomeInteractiveApp,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Auto Paper Generator (Simulation)',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => WebContentScreen(
                      // ← CHANGED
                      title: 'Readify Paper Generator Simulation',
                      contentPath:
                          'assets/html/rf/auto_paper_generator/auto_paper_Simulation/',
                      isLocal: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Auto Paper Generator (App)',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => WebContentScreen(
                      // ← CHANGED
                      title: 'Readify Paper Generator App',
                      contentPath:
                          'assets/html/rf/auto_paper_generator/auto_paper_app/',
                      isLocal: true,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
