import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../screens/webview_page.dart';

class SKPaperbackTextbooks extends StatelessWidget {
  const SKPaperbackTextbooks({super.key});

  final List<Map<String, String>> books = const [
    {
      "title": "English Play Group",
      "image": "assets/images/sk-resources/textbooks/eng_pg.png",
      "offline": "assets/html/sk/paperback_textbook/eng_pg/index.html",
      "folder": "assets/html/sk/paperback_textbook/eng_pg/",
    },
    {
      "title": "English Nursery",
      "image": "assets/images/sk-resources/textbooks/eng_nur.png",
      "offline": "assets/html/sk/paperback_textbook/eng_nur/index.html",
      "folder": "assets/html/sk/paperback_textbook/eng_nur/",
    },
    {
      "title": "English Prep",
      "image": "assets/images/sk-resources/textbooks/eng_prep.png",
      "offline": "assets/html/sk/paperback_textbook/eng_prep/index.html",
      "folder": "assets/html/sk/paperback_textbook/eng_prep/",
    },
    {
      "title": "Math Play Group",
      "image": "assets/images/sk-resources/textbooks/math_pg.png",
      "offline": "assets/html/sk/paperback_textbook/math_pg/index.html",
      "folder": "assets/html/sk/paperback_textbook/math_pg/",
    },
    {
      "title": "Math Nursery",
      "image": "assets/images/sk-resources/textbooks/math_nur.png",
      "offline": "assets/html/sk/paperback_textbook/math_nur/index.html",
      "folder": "assets/html/sk/paperback_textbook/math_nur/",
    },
    {
      "title": "Math Prep",
      "image": "assets/images/sk-resources/textbooks/math_prep.png",
      "offline": "assets/html/sk/paperback_textbook/math_prep/index.html",
      "folder": "assets/html/sk/paperback_textbook/math_prep/",
    },
    {
      "title": "Urdu Play Group",
      "image": "assets/images/sk-resources/textbooks/urdu_pg.png",
      "offline": "assets/html/sk/paperback_textbook/urdu_pg/index.html",
      "folder": "assets/html/sk/paperback_textbook/urdu_pg/",
    },
    {
      "title": "Urdu Nursery",
      "image": "assets/images/sk-resources/textbooks/urdu_nur.png",
      "offline": "assets/html/sk/paperback_textbook/urdu_nur/index.html",
      "folder": "assets/html/sk/paperback_textbook/urdu_nur/",
    },
    {
      "title": "Urdu Prep",
      "image": "assets/images/sk-resources/textbooks/urdu_prep.png",
      "offline": "assets/html/sk/paperback_textbook/urdu_prep/index.html",
      "folder": "assets/html/sk/paperback_textbook/urdu_prep/",
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
      appBar: AppBar(title: const Text("SK Paperback Textbooks")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
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
