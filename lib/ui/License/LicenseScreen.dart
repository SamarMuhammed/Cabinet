import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reidsc/core/services/DioBaseService.dart';
import 'package:reidsc/core/services/LicenseService.dart';
import 'package:reidsc/data/model/license/License.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
// #enddocregion platform_imports// Added WebView import

import '../../generic/imageDialog.dart';

class LicenseScreen extends StatefulWidget {
  final License license;

  const LicenseScreen({Key? key, required this.license}) : super(key: key);

  @override
  _LicenseScreenState createState() => _LicenseScreenState();
}

class _LicenseScreenState extends State<LicenseScreen> {
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    // Optionally enable hybrid composition for Android (optional for better performance)
    // WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Golden License",
          style: GoogleFonts.tajawal(
            textStyle: TextStyle(fontSize: 18.sp),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_forward_ios, textDirection: TextDirection.ltr),
            color: Colors.black,
          )
        ],
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://www.goldenlicense.gov.eg//guide_en.aspx'))),
        onWebViewCreated: (InAppWebViewController webViewController) {
          _webViewController = webViewController;
        },
        onLoadStop: (controller, url) {
          // Add logic here if needed after the page loads
        },
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
        ),
      ),
    );
  }
}
