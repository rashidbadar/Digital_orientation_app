import 'package:flutter/services.dart';

class AssetLoader {
  /// Loads an HTML file from assets/html/[path] and fixes relative paths
  static Future<String> loadHtml(String filePath) async {
    try {
      final assetPath = filePath.startsWith('assets/')
          ? filePath
          : 'assets/html/$filePath';

      final htmlContent = await rootBundle.loadString(assetPath);

      return _fixRelativePaths(htmlContent, assetPath);
    } catch (e) {
      return """
      <html>
        <body style="font-family: sans-serif; padding:20px;">
          <h3>Error loading $filePath</h3>
          <p>$e</p>
        </body>
      </html>
      """;
    }
  }

  /// Fix relative paths (css, js, images, url(...) in CSS) inside HTML for WebView
  static String _fixRelativePaths(String html, String htmlAssetPath) {
    final htmlFolder = htmlAssetPath.substring(
      0,
      htmlAssetPath.lastIndexOf('/'),
    );
    const base = 'file:///android_asset/flutter_assets/';

    String toAbsolute(String relativePath) {
      // If already absolute, return as is
      if (relativePath.startsWith('assets/') ||
          relativePath.startsWith('file:') ||
          relativePath.startsWith('http')) {
        return '$base$relativePath';
      }

      // Normalize ../ in paths
      var path = relativePath;
      var folder = htmlFolder;

      while (path.startsWith('../')) {
        path = path.substring(3);
        folder = folder.substring(0, folder.lastIndexOf('/'));
      }

      return '$base$folder/$path';
    }

    // Fix src and href
    html = html.replaceAllMapped(
      RegExp(r'src="(?!https?:|file:)([^"]+)"'),
      (m) => 'src="${toAbsolute(m[1]!)}"',
    );

    html = html.replaceAllMapped(
      RegExp(r'href="(?!https?:|file:)([^"]+)"'),
      (m) => 'href="${toAbsolute(m[1]!)}"',
    );

    // Fix url(...) in CSS
    html = html.replaceAllMapped(RegExp(r'url\(([^)]+)\)'), (m) {
      var path = m[1]!.trim();
      if ((path.startsWith('"') && path.endsWith('"')) ||
          (path.startsWith("'") && path.endsWith("'"))) {
        path = path.substring(1, path.length - 1);
      }
      return 'url("${toAbsolute(path)}")';
    });

    return html;
  }
}
