// lib/models/resource_model.dart

class Resource {
  final String title;
  final String imagePath;
  final String
  htmlPath; // Path to the HTML asset (e.g., 'assets/html/sk/paperback_textbook/apex_pg/')
  final bool isLocal; // True for local files, false for web URLs

  Resource({
    required this.title,
    required this.imagePath,
    required this.htmlPath,
    this.isLocal = true,
  });
}
