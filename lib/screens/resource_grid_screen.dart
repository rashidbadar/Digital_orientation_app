import 'package:flutter/material.dart';
import '../models/resource_model.dart';
import '../widgets/grid_item.dart';
import 'web_content_screen.dart'; // ← CHANGED IMPORT

class ResourceGridScreen extends StatelessWidget {
  final String screenTitle;
  final List<Resource> resources;

  const ResourceGridScreen({
    super.key,
    required this.screenTitle,
    required this.resources,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.8, // Adjust this to control card shape
          ),
          itemCount: resources.length,
          itemBuilder: (context, index) {
            final resource = resources[index];
            return GridItem(
              title: resource.title,
              imagePath: resource.imagePath,
              onTap: () {
                // Navigate to WebContentScreen with the resource's data
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => WebContentScreen(
                      // ← CHANGED
                      title: resource.title,
                      contentPath: resource
                          .htmlPath, // ← Note: using .htmlPath from Resource model
                      isLocal: resource.isLocal,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
