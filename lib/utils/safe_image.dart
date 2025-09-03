import 'dart:io';

String safeImage(
  String path, {
  String placeholder = 'assets/images/placeholder.png',
}) {
  if (path.isEmpty) return placeholder;

  // For web or platforms where we can't check file existence easily, just return the path
  // You can enhance this for more platform-specific checks
  try {
    if (File(path).existsSync()) {
      return path;
    } else {
      return placeholder;
    }
  } catch (e) {
    // If any error occurs (invalid path, permissions, etc.), return placeholder
    return placeholder;
  }
}
