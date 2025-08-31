import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String
  url; // Can be online URL or local asset path starting with 'assets/html/'

  const WebViewPage({super.key, required this.title, required this.url});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize WebView controller
    final params = const PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            debugPrint("Loading progress: $progress%");
          },
          onPageStarted: (url) {
            setState(() => _isLoading = true);
            debugPrint("Page started: $url");
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
            debugPrint("Page finished: $url");
          },
          onWebResourceError: (error) {
            debugPrint("WebView error: ${error.description}");
          },
        ),
      );

    // ✅ Load local asset or online URL
    if (widget.url.startsWith('assets/')) {
      // Use this method for safe local HTML loading
      _controller.loadFlutterAsset(widget.url);
    } else {
      _controller.loadRequest(Uri.parse(widget.url));
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
