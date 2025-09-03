import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/asset_loader.dart';

class WebContentScreen extends StatefulWidget {
  final String title;
  final String contentPath;
  final bool isLocal;

  const WebContentScreen({
    super.key,
    required this.title,
    required this.contentPath,
    this.isLocal = true,
  });

  @override
  State<WebContentScreen> createState() => _WebContentScreenState();
}

class _WebContentScreenState extends State<WebContentScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      );

    _loadContent();
  }

  Future<void> _loadContent() async {
    if (widget.isLocal) {
      try {
        final htmlContent = await AssetLoader.loadHtml(widget.contentPath);
        await _controller.loadHtmlString(htmlContent);
      } catch (e) {
        // Show a basic error page if HTML fails to load
        await _controller.loadHtmlString('''
          <html>
            <body style="font-family: sans-serif; padding:20px;">
              <h3>Error loading ${widget.contentPath}</h3>
              <p>$e</p>
            </body>
          </html>
        ''');
      }
    } else {
      final uri = Uri.parse(widget.contentPath);
      await _controller.loadRequest(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
