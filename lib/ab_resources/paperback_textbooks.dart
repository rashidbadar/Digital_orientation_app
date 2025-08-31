import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../screens/webview_page.dart';

class ABPaperbackTextbooks extends StatelessWidget {
  const ABPaperbackTextbooks({super.key});

  final List<Map<String, String>> books = const [
    {
      "title": "GK 1",
      "image": "assets/images/ab-resources/gk_1.png",
      "offline": "assets/html/ab/paperback_textbooks/gk_1/index.html",
      "folder": "assets/html/ab/paperback_textbooks/gk_1/",
    },
    {
      "title": "GK 2",
      "image": "assets/images/ab-resources/gk_2.png",
      "offline": "assets/html/ab/paperback_textbooks/gk_2/index.html",
      "folder": "assets/html/ab/paperback_textbooks/gk_2/",
    },
    {
      "title": "GK 3",
      "image": "assets/images/ab-resources/gk_3.png",
      "offline": "assets/html/ab/paperback_textbooks/gk_3/index.html",
      "folder": "assets/html/ab/paperback_textbooks/gk_3/",
    },
    {
      "title": "SC 4",
      "image": "assets/images/ab-resources/sc_4.png",
      "offline": "assets/html/ab/paperback_textbooks/sc_4/index.html",
      "folder": "assets/html/ab/paperback_textbooks/sc_4/",
    },
    {
      "title": "SC 5",
      "image": "assets/images/ab-resources/sc_5.png",
      "offline": "assets/html/ab/paperback_textbooks/sc_5/index.html",
      "folder": "assets/html/ab/paperback_textbooks/sc_5/",
    },
    {
      "title": "IS 1",
      "image": "assets/images/ab-resources/is_1.png",
      "offline": "assets/html/ab/paperback_textbooks/is_1/index.html",
      "folder": "assets/html/ab/paperback_textbooks/is_1/",
    },
    {
      "title": "IS 2",
      "image": "assets/images/ab-resources/is_2.png",
      "offline": "assets/html/ab/paperback_textbooks/is_2/index.html",
      "folder": "assets/html/ab/paperback_textbooks/is_2/",
    },
    {
      "title": "IS 3",
      "image": "assets/images/ab-resources/is_3.png",
      "offline": "assets/html/ab/paperback_textbooks/is_3/index.html",
      "folder": "assets/html/ab/paperback_textbooks/is_3/",
    },
    {
      "title": "IS 4",
      "image": "assets/images/ab-resources/is_4.png",
      "offline": "assets/html/ab/paperback_textbooks/is_4/index.html",
      "folder": "assets/html/ab/paperback_textbooks/is_4/",
    },
    {
      "title": "IS 5",
      "image": "assets/images/ab-resources/is_5.png",
      "offline": "assets/html/ab/paperback_textbooks/is_5/index.html",
      "folder": "assets/html/ab/paperback_textbooks/is_5/",
    },
    {
      "title": "COM 1",
      "image": "assets/images/ab-resources/com_1.png",
      "offline": "assets/html/ab/paperback_textbooks/com_1/index.html",
      "folder": "assets/html/ab/paperback_textbooks/com_1/",
    },
    {
      "title": "COM 2",
      "image": "assets/images/ab-resources/com_2.png",
      "offline": "assets/html/ab/paperback_textbooks/com_2/index.html",
      "folder": "assets/html/ab/paperback_textbooks/com_2/",
    },
    {
      "title": "COM 3",
      "image": "assets/images/ab-resources/com_3.png",
      "offline": "assets/html/ab/paperback_textbooks/com_3/index.html",
      "folder": "assets/html/ab/paperback_textbooks/com_3/",
    },
    {
      "title": "COM 4",
      "image": "assets/images/ab-resources/com_4.png",
      "offline": "assets/html/ab/paperback_textbooks/com_4/index.html",
      "folder": "assets/html/ab/paperback_textbooks/com_4/",
    },
    {
      "title": "COM 5",
      "image": "assets/images/ab-resources/com_5.png",
      "offline": "assets/html/ab/paperback_textbooks/com_5/index.html",
      "folder": "assets/html/ab/paperback_textbooks/com_5/",
    },
    {
      "title": "UG 1",
      "image": "assets/images/ab-resources/ug_1.png",
      "offline": "assets/html/ab/paperback_textbooks/ug_1/index.html",
      "folder": "assets/html/ab/paperback_textbooks/ug_1/",
    },
    {
      "title": "UG 2",
      "image": "assets/images/ab-resources/ug_2.png",
      "offline": "assets/html/ab/paperback_textbooks/ug_2/index.html",
      "folder": "assets/html/ab/paperback_textbooks/ug_2/",
    },
    {
      "title": "UG 3",
      "image": "assets/images/ab-resources/ug_3.png",
      "offline": "assets/html/ab/paperback_textbooks/ug_3/index.html",
      "folder": "assets/html/ab/paperback_textbooks/ug_3/",
    },
    {
      "title": "UG 4",
      "image": "assets/images/ab-resources/ug_4.png",
      "offline": "assets/html/ab/paperback_textbooks/ug_4/index.html",
      "folder": "assets/html/ab/paperback_textbooks/ug_4/",
    },
    {
      "title": "UG 5",
      "image": "assets/images/ab-resources/ug_5.png",
      "offline": "assets/html/ab/paperback_textbooks/ug_5/index.html",
      "folder": "assets/html/ab/paperback_textbooks/ug_5/",
    },
    {
      "title": "NQ 1",
      "image": "assets/images/ab-resources/nq_1.png",
      "offline": "assets/html/ab/paperback_textbooks/nq_1/index.html",
      "folder": "assets/html/ab/paperback_textbooks/nq_1/",
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
      appBar: AppBar(title: const Text("AB Paperback Textbooks")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () async {
              final fileUrl = await _copyAssetFolder(
                book['folder']!,
                book['offline']!.split('/').last,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      WebViewPage(title: book['title']!, url: fileUrl),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(book['image']!, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book['title']!,
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
