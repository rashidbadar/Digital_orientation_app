// lib/models/resource_model.dart

class Resource {
  final String title;
  final String imagePath;
  final String htmlPath; // Can be folder path or specific file path
  final bool isLocal; // True for local files, false for web URLs

  Resource({
    required this.title,
    required this.imagePath,
    required this.htmlPath,
    this.isLocal = true,
  });

  // Getter to provide the correct path for WebView loading
  String get effectivePath {
    if (!isLocal) {
      return htmlPath; // For web URLs, return as-is
    }

    // For local paths, ensure we have a specific file to load
    if (htmlPath.endsWith('/')) {
      // If it's a folder path, append index.html
      return '${htmlPath}index.html';
    } else if (!htmlPath.contains('.')) {
      // If it's a path without extension, assume it's a folder and add index.html
      return '$htmlPath/index.html';
    }

    // If it already has a file extension, return as-is
    return htmlPath;
  }

  // Helper method to check if this is a folder path
  bool get isFolderPath {
    return isLocal && (htmlPath.endsWith('/') || !htmlPath.contains('.'));
  }

  // Helper method to get the directory path (for asset loading)
  String get directoryPath {
    if (isFolderPath) {
      return htmlPath;
    } else {
      // Extract directory from file path
      final lastSlash = htmlPath.lastIndexOf('/');
      if (lastSlash != -1) {
        return htmlPath.substring(0, lastSlash + 1);
      }
      return '';
    }
  }
}
