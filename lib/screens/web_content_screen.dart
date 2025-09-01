import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ADD THIS IMPORT
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
  String _effectivePath = '';

  String _getEffectivePath(String path) {
    if (!widget.isLocal) {
      return path; // For web URLs, return as-is
    }

    // For local paths, ensure we have a specific file to load
    if (path.endsWith('/')) {
      // If it's a folder path, append index.html
      return '${path}index.html';
    } else if (!path.contains('.')) {
      // If it's a path without extension, assume it's a folder and add index.html
      return '$path/index.html';
    }

    // If it already has a file extension, return as-is
    return path;
  }

  String _getUrl(String path) {
    if (!widget.isLocal) return path;

    String finalPath = path;

    // Remove 'assets/' prefix if present (Android adds it automatically)
    if (finalPath.startsWith('assets/')) {
      finalPath = finalPath.substring(7);
    }

    if (Platform.isAndroid) {
      return 'file:///android_asset/flutter_assets/$finalPath';
    } else if (Platform.isIOS) {
      return 'file://Frameworks/App.framework/flutter_assets/$finalPath';
    } else {
      return 'file://$finalPath';
    }
  }

  // UPDATED: Simplified asset existence check
  Future<bool> _assetExists(String path) async {
    try {
      if (kIsWeb) {
        // For web, we can't easily check if file exists, so we assume it does
        return true;
      } else {
        // For mobile, try to load the asset using rootBundle
        await rootBundle.load('assets/$path');
        return true;
      }
    } catch (e) {
      print('Asset not found: assets/$path, error: $e');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() async {
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
          },
        ),
      );

    // Get the effective path (handles folders -> index.html)
    _effectivePath = _getEffectivePath(widget.contentPath);

    // Check if asset exists first (for local files)
    if (widget.isLocal) {
      final assetExists = await _assetExists(_effectivePath);

      if (!assetExists) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage =
              'Asset not found: assets/$_effectivePath\n\n'
              'Please check:\n'
              '1. File exists in assets/ folder\n'
              '2. Path is correct in pubspec.yaml\n'
              '3. Run "flutter clean && flutter pub get"';
        });
        return;
      }
    }

    final url = _getUrl(_effectivePath);
    print('=== WEBVIEW DEBUG ===');
    print('Original path: ${widget.contentPath}');
    print('Effective path: $_effectivePath');
    print('Final URL: $url');
    print('Platform: ${Platform.operatingSystem}');
    print('=== END DEBUG ===');

    try {
      await _controller.loadRequest(Uri.parse(url));
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage =
            'Failed to load URL: $e\n\n'
            'Trying to load: $url\n'
            'From original: ${widget.contentPath}';
      });
    }
  }

  void _reloadPage() {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _initializeWebView();
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
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Debug Information'),
                  content: Text(
                    'Original Path: ${widget.contentPath}\n'
                    'Effective Path: $_effectivePath\n'
                    'Is Local: ${widget.isLocal}\n'
                    'Error: $_errorMessage\n\n'
                    'Make sure:\n'
                    '1. File exists in correct location\n'
                    '2. Path is in pubspec.yaml assets\n'
                    '3. Run "flutter clean && flutter pub get"',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            tooltip: 'Debug Info',
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
                  Text('Loading Content...'),
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
                      'Check if the file exists in your assets folder',
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
