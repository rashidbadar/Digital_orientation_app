import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../screens/webview_page.dart';

class RFHomeInteractiveApp extends StatelessWidget {
  const RFHomeInteractiveApp({super.key});

  final List<Map<String, String>> apps = const [
    {
      "title": "Home Simulation",
      "image": "assets/images/rf-resources/textbooks/home_sim.png",
      "offline":
          "assets/html/rf/home_interactive_app/home_Simulation/index.html",
      "folder": "assets/html/rf/home_interactive_app/home_Simulation/",
    },
    {
      "title": "Home App",
      "image": "assets/images/rf-resources/textbooks/home_app.png",
      "offline": "assets/html/rf/home_interactive_app/home_app/index.html",
      "folder": "assets/html/rf/home_interactive_app/home_app/",
    },
  ];

  Future<String> _copyAssetFolder(String assetFolder, String entryFile) async {
    final tempDir = await getTemporaryDirectory();
    final targetDir = Directory(
      "${tempDir.path}/${assetFolder.split('/').last}",
    );
    if (!await targetDir.exists()) await targetDir.create(recursive: true);

    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = jsonDecode(manifestJson);
    final assetPaths = manifestMap.keys
        .where((k) => k.startsWith(assetFolder))
        .toList();

    for (final path in assetPaths) {
      final byteData = await rootBundle.load(path);
      final file = File("${targetDir.path}/${path.split('/').last}");
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    return "file://${targetDir.path}/$entryFile";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RF Home Interactive App")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return GestureDetector(
            onTap: () async {
              final fileUrl = await _copyAssetFolder(
                app['folder']!,
                app['offline']!.split('/').last,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      WebViewPage(title: app['title']!, url: fileUrl),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(app['image']!, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    app['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
