import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'resource_grid_screen.dart';
import 'web_content_screen.dart'; // ← CHANGED IMPORT

class AeriPage extends StatelessWidget {
  const AeriPage({super.key});

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
          children: [
            CustomButton(
              title: 'Paperback Textbooks',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'Aeri Paperback Textbooks',
                      resources: AppData.aiPaperBackTextbooks,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Soft Form Key Books',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'Aeri Soft Form Key Books',
                      resources: AppData.aiSoftFormKeyBooks,
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
                      title: 'Aeri Paper Generator Simulation',
                      contentPath:
                          'assets/html/ai/auto_paper_generator/auto_paper_Simulation/',
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
                      title: 'Aeri Paper Generator App',
                      contentPath:
                          'assets/html/ai/auto_paper_generator/auto_paper_app/',
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
