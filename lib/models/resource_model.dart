// lib/models/resource_model.dart
import 'package:flutter/services.dart';

class Resource {
  final String title;
  final String htmlPath; // Can be folder path or specific file path
  final bool isLocal; // True for local assets, false for web URLs

  Resource({required this.title, required this.htmlPath, this.isLocal = true});

  /// Normalize paths for Flutter assets (replace backslashes)
  String get _normalizedHtmlPath => htmlPath.replaceAll('\\', '/');

  /// Returns the correct path for WebView loading
  String get effectivePath {
    if (!isLocal) return htmlPath; // Remote URL, use as-is

    String path = _normalizedHtmlPath;

    // If it's a folder path (ends with '/' or has no extension), append index.html
    if (path.endsWith('/')) {
      return '${path}index.html';
    } else if (!path.contains('.')) {
      return '$path/index.html';
    }

    // Already a file
    return path;
  }

  /// Check if path represents a folder
  bool get isFolderPath {
    final path = _normalizedHtmlPath;
    return isLocal && (path.endsWith('/') || !path.contains('.'));
  }

  /// Get folder directory path
  String get directoryPath {
    final path = _normalizedHtmlPath;
    if (isFolderPath) return path;

    final lastSlash = path.lastIndexOf('/');
    if (lastSlash != -1) return path.substring(0, lastSlash + 1);
    return '';
  }

  /// Load HTML as string from Flutter assets (for WebView)
  Future<String> loadHtml() async {
    if (!isLocal) throw Exception('Cannot load remote HTML using loadHtml()');
    return await rootBundle.loadString(effectivePath);
  }
}
