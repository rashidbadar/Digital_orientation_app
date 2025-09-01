import 'package:flutter/services.dart';

class AssetLoader {
  // Load HTML content from assets
  static Future<String> loadHTML(String filePath) async {
    try {
      return await rootBundle.loadString('assets/$filePath');
    } catch (e) {
      return _getErrorHTML('Error loading HTML: $e\nPath: assets/$filePath');
    }
  }

  // Error HTML template
  static String _getErrorHTML(String error) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Loading Content</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            padding: 40px;
            text-align: center;
            color: #555;
        }
        .error-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .error-title {
            color: #d32f2f;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .error-details {
            background-color: #fff3f3;
            padding: 15px;
            border-radius: 4px;
            border-left: 4px solid #d32f2f;
            text-align: left;
            margin: 20px 0;
            font-family: monospace;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-title">⚠️ Content Failed to Load</div>
        <p>The requested learning content could not be loaded.</p>
        <div class="error-details">$error</div>
        <p style="margin-top: 20px; color: #666;">
            Please check if the file exists in your assets folder.
        </p>
    </div>
</body>
</html>
''';
  }
}
