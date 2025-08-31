import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const DigitalOrientationApp());
}

class DigitalOrientationApp extends StatelessWidget {
  const DigitalOrientationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Orientation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}

// Example WebViewPage to load offline first, then online
class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  bool _isOnline = false;

  final String offlineFile =
      'assets/offline.html'; // put your offline html in assets
  final String onlineUrl = 'https://your-online-link.com';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (JavaScriptMessage message) {
          // Decode JSON message from offline html
          var data = jsonDecode(message.message);
          if (data['status'] == 'completed') {
            // When offline project is completed → load online page
            setState(() {
              _isOnline = true;
              _controller.loadRequest(Uri.parse(onlineUrl));
            });
          }
        },
      )
      ..loadFlutterAsset(offlineFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isOnline ? "Online View" : "Offline View")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
