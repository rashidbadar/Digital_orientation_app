import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  bool _hasError = false;
  String _errorMessage = '';

  String _getUrl(String path) {
    if (!widget.isLocal) return path;
    if (kIsWeb) return path;

    // For local files, ensure we're pointing to the index.html
    String finalPath = path;

    // If path is a directory (ends with slash), append index.html
    if (finalPath.endsWith('/')) {
      finalPath = '${finalPath}index.html';
    }
    // If path doesn't have a file extension, assume it's a directory and add index.html
    else if (!finalPath.contains('.')) {
      finalPath = '$finalPath/index.html';
    }

    if (Platform.isAndroid) {
      return 'file:///android_asset/flutter_assets/$finalPath';
    } else if (Platform.isIOS) {
      return 'file://Frameworks/App.framework/flutter_assets/$finalPath';
    } else {
      return 'file://$finalPath';
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    final url = _getUrl(widget.contentPath);
    print('=== WEBVIEW DEBUG ===');
    print('Original path: ${widget.contentPath}');
    print('Final URL: $url');
    print('Platform: ${Platform.operatingSystem}');
    print('=== END DEBUG ===');

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            print('Loading progress: $progress%');
          },
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
            print('Page started loading: $url');
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
            print('Page finished loading: $url');
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = 'Error: ${error.description}\nURL: ${error.url}';
            });
            print('WEBVIEW ERROR: ${error.description}');
            print('Error URL: ${error.url}');
            print('Error Type: ${error.errorType}');
            print('Error Code: ${error.errorCode}');
          },
          onUrlChange: (urlChange) {
            print('URL changed to: ${urlChange.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void _reloadPage() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (_hasError)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _reloadPage,
              tooltip: 'Reload',
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          if (_isLoading)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading Adobe Captivate Project...'),
                ],
              ),
            ),

          if (_hasError)
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.black54,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Failed to load content',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _reloadPage,
                      child: const Text('Try Again'),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Check if the HTML files exist in your assets folder',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
