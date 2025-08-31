import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../widgets/custom_button.dart';
import 'resource_grid_screen.dart';
import 'web_content_screen.dart'; // ← CHANGED: Import the new WebContentScreen

class SmartKidsPage extends StatelessWidget {
  const SmartKidsPage({super.key});

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
          children: [
            CustomButton(
              title: 'Paperback Textbooks',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'SmartKids Paperback Textbooks',
                      resources: AppData.skPaperBackTextbooks,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Paperback Workbooks',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'SmartKids Paperback Workbooks',
                      resources: AppData.skPaperBackWorkbooks,
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
                      screenTitle: 'SmartKids Soft Form Worksheets',
                      resources: AppData.skSoftFormWorksheets,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              title: 'Classroom Interactive App',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => ResourceGridScreen(
                      screenTitle: 'SmartKids Classroom Interactive App',
                      resources: AppData.skClassroomInteractiveApp,
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
                      screenTitle: 'SmartKids Home Interactive App',
                      resources: AppData.skHomeInteractiveApp,
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
                      // ← CHANGED: Use WebContentScreen
                      title: 'SmartKids Paper Generator Simulation',
                      contentPath:
                          'assets/html/sk/auto_paper_generator/auto_paper_Simulation/',
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
                      // ← CHANGED: Use WebContentScreen
                      title: 'SmartKids Paper Generator App',
                      contentPath:
                          'assets/html/sk/auto_paper_generator/auto_paper_app/',
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
