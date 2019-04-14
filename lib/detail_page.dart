import 'package:flutter/material.dart';
import 'package:flutter_post/model/news.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  DetailPage({this.article});

  void shareUrl() {
    Share.share('Read the full news from ' + article.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: new Icon(Icons.close, color: Colors.black),),
        elevation: 0.1,
        title: new Text(article.url),
        backgroundColor: Colors.white,
      ),
      body: WebView(initialUrl: article.url,),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.share, color: Colors.white),
        onPressed: shareUrl,),
    );
  }
}
