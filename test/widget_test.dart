import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:digital_orientation/screens/webview_page.dart';

// Fake WebViewPlatform for widget tests
class FakeWebViewPlatform extends WebViewPlatform {
  @override
  WebViewPlatformController createPlatformWebViewController(
    WebViewPlatformCallbacksHandler? handler,
  ) {
    return FakeWebViewPlatformController();
  }

  @override
  WebViewWidgetPlatform createPlatformWebViewWidget({
    required WebViewPlatformController controller,
  }) {
    return FakeWebViewWidget();
  }

  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
    WebViewPlatformCallbacksHandler? handler,
  ) {
    return FakePlatformNavigationDelegate();
  }

  @override
  PlatformCookieManager createPlatformCookieManager() {
    return FakePlatformCookieManager();
  }
}

// Fake WebView controller
class FakeWebViewPlatformController extends WebViewPlatformController {
  @override
  Future<void> loadUrl(String url, {Map<String, String>? headers}) async {}
  @override
  Future<void> loadHtmlString(String html, {String? baseUrl}) async {}
  @override
  Future<void> reload() async {}
  @override
  Future<void> goBack() async {}
  @override
  Future<void> goForward() async {}
  @override
  Future<void> evaluateJavascript(String javascriptString) async {}
}

// Fake WebView widget
class FakeWebViewWidget extends WebViewWidgetPlatform {
  @override
  Widget build(BuildContext context) {
    return Container(); // just a placeholder
  }
}

// Fake Navigation delegate
class FakePlatformNavigationDelegate extends PlatformNavigationDelegate {}

// Fake Cookie manager
class FakePlatformCookieManager extends PlatformCookieManager {}

void main() {
  // Set the fake WebViewPlatform before tests
  setUpAll(() {
    WebViewPlatform.instance = FakeWebViewPlatform();
  });

  testWidgets('WebViewPage loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WebViewPage(
          title: 'English PG',
          offlinePath: 'assets/html/sk/paperback_textbooks/eng_pg/index.html',
        ),
      ),
    );

    // AppBar title exists
    expect(find.text('English PG'), findsOneWidget);

    // Loader exists initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump to finish loading
    await tester.pumpAndSettle();

    // Loader disappears
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // WebView widget exists
    expect(find.byType(WebViewWidget), findsOneWidget);
  });
}
