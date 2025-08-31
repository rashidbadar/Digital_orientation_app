import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'resource_grid_screen.dart';
import 'web_content_screen.dart'; // ← CHANGED IMPORT

class AbbasiPage extends StatelessWidget {
  const AbbasiPage({super.key});

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
          children: [
            CustomButton(
              title: 'Paperback Textbooks',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'Abbasi Paperback Textbooks',
                      resources: AppData.abPaperBackTextbooks,
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
                      screenTitle: 'Abbasi Soft Form Key Books',
                      resources: AppData.abSoftFormKeyBooks,
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
                      title: 'Abbasi Paper Generator Simulation',
                      contentPath:
                          'assets/html/ab/auto_paper_generator/auto_paper_Simulation/',
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
                      title: 'Abbasi Paper Generator App',
                      contentPath:
                          'assets/html/ab/auto_paper_generator/auto_paper_app/',
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
