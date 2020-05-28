import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';



class WebView extends StatelessWidget {

  final String url,title;

  WebView(this.url,this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebviewScaffold(
        url: this.url,
        appBar: AppBar(
          title: Text(this.title),
        ),
      ),
    );
  }
}