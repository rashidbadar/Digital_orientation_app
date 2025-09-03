// lib/screens/resource_grid_screen.dart
import 'package:flutter/material.dart';
import '../models/resource_model.dart';
import 'web_content_screen.dart';

class ResourceGridScreen extends StatelessWidget {
  final String screenTitle;
  final List<Resource>? resources; // ← OPTIONAL for single category
  final Map<String, List<Resource>>? seriesMap; // ← OPTIONAL for full series

  const ResourceGridScreen({
    super.key,
    required this.screenTitle,
    this.resources,
    this.seriesMap,
  });

  @override
  Widget build(BuildContext context) {
    // If resources is provided, use it; else use seriesMap
    if (resources != null) {
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
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 2.5,
            ),
            itemCount: resources!.length,
            itemBuilder: (context, index) {
              final resource = resources![index];
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => WebContentScreen(
                        title: resource.title,
                        contentPath: resource.htmlPath,
                        isLocal: resource.isLocal,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(resource.title),
              );
            },
          ),
        ),
      );
    } else if (seriesMap != null) {
      // For full series display
      return Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: seriesMap!.entries.map((entry) {
            final seriesTitle = entry.key;
            final resources = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seriesTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resources.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    final resource = resources[index];
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => WebContentScreen(
                              title: resource.title,
                              contentPath: resource.htmlPath,
                              isLocal: resource.isLocal,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: Text(resource.title),
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            );
          }).toList(),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(child: Text('No resources available.')),
      );
    }
  }
}
