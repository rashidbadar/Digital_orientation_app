import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebContentScreen extends StatelessWidget {
  final String title;
  final String contentPath;
  final bool isLocal;

  const WebContentScreen({
    Key? key,
    required this.title,
    required this.contentPath,
    this.isLocal = true,
  }) : super(key: key);

  String _getUrl(String path) {
    if (!isLocal) return path;
    if (kIsWeb) return path;
    if (Platform.isAndroid) return 'file:///android_asset/flutter_assets/$path';
    if (Platform.isIOS)
      return 'file://Frameworks/App.framework/flutter_assets/$path';
    return 'file://$path';
  }

  @override
  Widget build(BuildContext context) {
    final url = _getUrl(contentPath);
    print('Loading content from: $url');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..loadRequest(Uri.parse(url))
          ..setJavaScriptMode(JavaScriptMode.unrestricted),
      ),
    );
  }
}
