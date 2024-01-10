import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:path_provider/path_provider.dart';

class WebviewForDownloadsMobile extends StatefulWidget {
  const WebviewForDownloadsMobile({
    super.key,
    required this.url,
    required this.topbar_color,
    required this.native_screen,
  });

  final String url;
  final Color topbar_color;
  final Widget native_screen;

  @override
  State<WebviewForDownloadsMobile> createState() => _WebviewForDownloadsMobileState();
}

class _WebviewForDownloadsMobileState extends State<WebviewForDownloadsMobile> {
  late InAppWebViewController webview;
  final ReceivePort _port = ReceivePort();
  bool mobile_webview = false;

  register_port() async {
    await FlutterDownloader.initialize(debug: true);

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      // String id = data[0];
      // DownloadTaskStatus status = data[1];
      // int progress = data[2];
      // setState(() {});
    });

    FlutterDownloader.registerCallback(download_callback);
  }

  static download_callback(
    String id,
    int status,
    int progress,
  ) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  download(Uri uri) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final directory = UniversalPlatform.isAndroid
          ? (await getExternalStorageDirectory())!.path
          : (await getApplicationDocumentsDirectory()).absolute.path;

      await FlutterDownloader.enqueue(
        url: uri.toString(),
        savedDir: directory,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );
    } else {
      debugPrint('Permission Denied');
    }
  }

  init_config() async {
    if (UniversalPlatform.isAndroid) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  check_if_webview_is_enabled() async {
    var app_snap = await FirebaseFirestore.instance.collection("metadata").doc("app").get();

    Map<String, dynamic>? app_data = app_snap.data();

    if (app_data != null) {
      mobile_webview = app_data["mobile_webview"][UniversalPlatform.isAndroid ? "android" : "ios"] ?? false;
      if (mobile_webview) {
        Timer(const Duration(milliseconds: 800), () {
          setState(() {});
        });
        init_config();
        register_port();
      }
    }
  }

  @override
  void initState() {
    check_if_webview_is_enabled();
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mobile_webview
        ? PopScope(
            canPop: false,
            onPopInvoked: (did_pop) async {
              if (await webview.canGoBack()) webview.goBack();
            },
            child: Container(
              color: widget.topbar_color,
              child: SafeArea(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri.uri(
                      Uri.parse(widget.url),
                    ),
                  ),
                  initialSettings: InAppWebViewSettings(
                    useOnDownloadStart: true,
                    cacheEnabled: false,
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webview = controller;
                    Timer(const Duration(milliseconds: 1500), () {
                      webview.reload();
                    });
                  },
                  onLoadStart: (InAppWebViewController controller, Uri? uri) {},
                  onLoadStop: (InAppWebViewController controller, Uri? uri) {},
                  onDownloadStartRequest: (controller, request) {
                    if (request.url.toString().contains("http")) {
                      download(request.url);
                    } else {
                      debugPrint("Current Uri does not contain a Url");
                    }
                  },
                ),
              ),
            ),
          )
        : widget.native_screen;
  }
}
