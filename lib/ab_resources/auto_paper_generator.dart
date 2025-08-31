import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../screens/webview_page.dart';

class ABAutoPaperGenerator extends StatelessWidget {
  const ABAutoPaperGenerator({super.key});

  final List<Map<String, String>> papers = const [
    {
      "title": "Auto Paper Simulation",
      "image": "assets/images/ab-resources/auto_paper_sim.png",
      "offline":
          "assets/html/ab/auto_paper_generator/auto_paper_Simulation/index.html",
      "folder": "assets/html/ab/auto_paper_generator/auto_paper_Simulation/",
    },
    {
      "title": "Auto Paper App",
      "image": "assets/images/ab-resources/auto_paper_app.png",
      "offline":
          "assets/html/ab/auto_paper_generator/auto_paper_app/index.html",
      "folder": "assets/html/ab/auto_paper_generator/auto_paper_app/",
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
      appBar: AppBar(title: const Text("AB Auto Paper Generator")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: papers.length,
        itemBuilder: (context, index) {
          final paper = papers[index];
          return GestureDetector(
            onTap: () async {
              final fileUrl = await _copyAssetFolder(
                paper['folder']!,
                paper['offline']!.split('/').last,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      WebViewPage(title: paper['title']!, url: fileUrl),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(paper['image']!, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    paper['title']!,
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
