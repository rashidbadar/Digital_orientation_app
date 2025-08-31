import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import '../screens/webview_page.dart';

class AIPaperbackTextbooks extends StatelessWidget {
  const AIPaperbackTextbooks({super.key});

  final List<Map<String, String>> books = const [
    {
      "title": "English PG",
      "image": "assets/images/ai-resources/eng_pg.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_pg/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_pg/",
    },
    {
      "title": "English Nursery",
      "image": "assets/images/ai-resources/eng_nur.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_nur/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_nur/",
    },
    {
      "title": "English Prep",
      "image": "assets/images/ai-resources/eng_prep.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_prep/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_prep/",
    },
    {
      "title": "Math PG",
      "image": "assets/images/ai-resources/math_pg.png",
      "offline": "assets/html/ai/paperback_textbooks/math_pg/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_pg/",
    },
    {
      "title": "Math Nursery",
      "image": "assets/images/ai-resources/math_nur.png",
      "offline": "assets/html/ai/paperback_textbooks/math_nur/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_nur/",
    },
    {
      "title": "Math Prep",
      "image": "assets/images/ai-resources/math_prep.png",
      "offline": "assets/html/ai/paperback_textbooks/math_prep/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_prep/",
    },
    {
      "title": "Urdu PG",
      "image": "assets/images/ai-resources/urdu_pg.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_pg/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_pg/",
    },
    {
      "title": "Urdu Nursery",
      "image": "assets/images/ai-resources/urdu_nur.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_nur/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_nur/",
    },
    {
      "title": "Urdu Prep",
      "image": "assets/images/ai-resources/urdu_prep.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_prep/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_prep/",
    },
    {
      "title": "Art A",
      "image": "assets/images/ai-resources/art_a.png",
      "offline": "assets/html/ai/paperback_textbooks/art_a/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_a/",
    },
    {
      "title": "Art B",
      "image": "assets/images/ai-resources/art_b.png",
      "offline": "assets/html/ai/paperback_textbooks/art_b/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_b/",
    },
    {
      "title": "Art C",
      "image": "assets/images/ai-resources/art_c.png",
      "offline": "assets/html/ai/paperback_textbooks/art_c/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_c/",
    },
    {
      "title": "Art 1",
      "image": "assets/images/ai-resources/art_1.png",
      "offline": "assets/html/ai/paperback_textbooks/art_1/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_1/",
    },
    {
      "title": "Art 2",
      "image": "assets/images/ai-resources/art_2.png",
      "offline": "assets/html/ai/paperback_textbooks/art_2/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_2/",
    },
    {
      "title": "Art 3",
      "image": "assets/images/ai-resources/art_3.png",
      "offline": "assets/html/ai/paperback_textbooks/art_3/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_3/",
    },
    {
      "title": "Art 4",
      "image": "assets/images/ai-resources/art_4.png",
      "offline": "assets/html/ai/paperback_textbooks/art_4/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_4/",
    },
    {
      "title": "Art 5",
      "image": "assets/images/ai-resources/art_5.png",
      "offline": "assets/html/ai/paperback_textbooks/art_5/index.html",
      "folder": "assets/html/ai/paperback_textbooks/art_5/",
    },
    {
      "title": "Eng 1",
      "image": "assets/images/ai-resources/eng_1.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_1/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_1/",
    },
    {
      "title": "Eng 2",
      "image": "assets/images/ai-resources/eng_2.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_2/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_2/",
    },
    {
      "title": "Eng 3",
      "image": "assets/images/ai-resources/eng_3.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_3/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_3/",
    },
    {
      "title": "Eng 4",
      "image": "assets/images/ai-resources/eng_4.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_4/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_4/",
    },
    {
      "title": "Eng 5",
      "image": "assets/images/ai-resources/eng_5.png",
      "offline": "assets/html/ai/paperback_textbooks/eng_5/index.html",
      "folder": "assets/html/ai/paperback_textbooks/eng_5/",
    },
    {
      "title": "Urdu 1",
      "image": "assets/images/ai-resources/urdu_1.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_1/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_1/",
    },
    {
      "title": "Urdu 2",
      "image": "assets/images/ai-resources/urdu_2.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_2/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_2/",
    },
    {
      "title": "Urdu 3",
      "image": "assets/images/ai-resources/urdu_3.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_3/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_3/",
    },
    {
      "title": "Urdu 4",
      "image": "assets/images/ai-resources/urdu_4.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_4/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_4/",
    },
    {
      "title": "Urdu 5",
      "image": "assets/images/ai-resources/urdu_5.png",
      "offline": "assets/html/ai/paperback_textbooks/urdu_5/index.html",
      "folder": "assets/html/ai/paperback_textbooks/urdu_5/",
    },
    {
      "title": "Math 1",
      "image": "assets/images/ai-resources/math_1.png",
      "offline": "assets/html/ai/paperback_textbooks/math_1/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_1/",
    },
    {
      "title": "Math 2",
      "image": "assets/images/ai-resources/math_2.png",
      "offline": "assets/html/ai/paperback_textbooks/math_2/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_2/",
    },
    {
      "title": "Math 3",
      "image": "assets/images/ai-resources/math_3.png",
      "offline": "assets/html/ai/paperback_textbooks/math_3/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_3/",
    },
    {
      "title": "Math 4",
      "image": "assets/images/ai-resources/math_4.png",
      "offline": "assets/html/ai/paperback_textbooks/math_4/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_4/",
    },
    {
      "title": "Math 5",
      "image": "assets/images/ai-resources/math_5.png",
      "offline": "assets/html/ai/paperback_textbooks/math_5/index.html",
      "folder": "assets/html/ai/paperback_textbooks/math_5/",
    },
    {
      "title": "GR 1",
      "image": "assets/images/ai-resources/gr_1.png",
      "offline": "assets/html/ai/paperback_textbooks/gr_1/index.html",
      "folder": "assets/html/ai/paperback_textbooks/gr_1/",
    },
    {
      "title": "GR 2",
      "image": "assets/images/ai-resources/gr_2.png",
      "offline": "assets/html/ai/paperback_textbooks/gr_2/index.html",
      "folder": "assets/html/ai/paperback_textbooks/gr_2/",
    },
    {
      "title": "GR 3",
      "image": "assets/images/ai-resources/gr_3.png",
      "offline": "assets/html/ai/paperback_textbooks/gr_3/index.html",
      "folder": "assets/html/ai/paperback_textbooks/gr_3/",
    },
    {
      "title": "GR 4",
      "image": "assets/images/ai-resources/gr_4.png",
      "offline": "assets/html/ai/paperback_textbooks/gr_4/index.html",
      "folder": "assets/html/ai/paperback_textbooks/gr_4/",
    },
    {
      "title": "GR 5",
      "image": "assets/images/ai-resources/gr_5.png",
      "offline": "assets/html/ai/paperback_textbooks/gr_5/index.html",
      "folder": "assets/html/ai/paperback_textbooks/gr_5/",
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
      appBar: AppBar(title: const Text("AI Paperback Textbooks")),
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
