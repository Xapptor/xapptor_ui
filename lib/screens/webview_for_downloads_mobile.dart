import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:xapptor_logic/file_downloader/file_downloader.dart';

class WebviewForDownloadsMobile extends StatefulWidget {
  WebviewForDownloadsMobile({
    required this.url,
    required this.topbar_color,
    required this.native_screen,
  });

  final String url;
  final Color topbar_color;
  final Widget native_screen;

  @override
  _WebviewForDownloadsMobileState createState() =>
      _WebviewForDownloadsMobileState();
}

class _WebviewForDownloadsMobileState extends State<WebviewForDownloadsMobile> {
  late InAppWebViewController webview;
  ReceivePort _port = ReceivePort();
  bool mobile_webview = false;

  register_port() async {
    await FlutterDownloader.initialize(debug: true);

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(download_callback);
  }

  static void download_callback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  download(Uri uri) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final directory = UniversalPlatform.isAndroid
          ? (await getExternalStorageDirectory())!.path
          : (await getApplicationDocumentsDirectory()).absolute.path;

      final task_id = await FlutterDownloader.enqueue(
        url: uri.toString(),
        savedDir: directory,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );

      String file_name = uri.pathSegments.last.split('/').last;
      String file_path = directory + "/" + file_name;
      File file = File(file_path);
      FileDownloader.save(
          src: base64Encode(await file.readAsBytes()), file_name: file_name);
    } else {
      print('Permission Denied');
    }
  }

  init_config() async {
    if (UniversalPlatform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
  }

  check_if_webview_is_enabled() async {
    var app_snap = await FirebaseFirestore.instance
        .collection("metadata")
        .doc("app")
        .get();

    Map<String, dynamic>? app_data = app_snap.data();

    if (app_data != null) {
      mobile_webview = app_data["mobile_webview"]
              [UniversalPlatform.isAndroid ? "android" : "ios"] ??
          false;
      if (mobile_webview) {
        Timer(Duration(milliseconds: 800), () {
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
        ? WillPopScope(
            onWillPop: () async {
              if (await webview.canGoBack()) webview.goBack();
              return false;
            },
            child: Container(
              color: widget.topbar_color,
              child: SafeArea(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(widget.url),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      useOnDownloadStart: true,
                      cacheEnabled: false,
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webview = controller;
                    Timer(Duration(milliseconds: 1500), () {
                      webview.reload();
                    });
                  },
                  onLoadStart: (InAppWebViewController controller, Uri? uri) {},
                  onLoadStop: (InAppWebViewController controller, Uri? uri) {},
                  onDownloadStart: (controller, uri) {
                    download(uri);
                  },
                ),
              ),
            ),
          )
        : widget.native_screen;
  }
}
