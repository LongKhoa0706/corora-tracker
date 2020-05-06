import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNewsScreen extends StatelessWidget {
  final String urlNews;
  bool isLoading = false;

  DetailNewsScreen({@required this.urlNews});

  final Completer<WebViewController> _controller = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: urlNews == null ? "" : WebView(
          initialUrl: urlNews,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController c){
            _controller.complete(c);
          },
        ),
      ),
    );
  }
}
