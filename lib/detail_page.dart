import 'package:flutter/material.dart';
import 'package:flutter_post/model/news.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  DetailPage({this.article});

  Widget _topContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.network(
            article.urlToImage,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _bottomContent(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              article.title != null ? article.title : "",
              style: TextStyle(fontSize: 20.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              article.description != null ? article.description : "",
              style: TextStyle(fontSize: 16.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              article.content != null ? article.content : "",
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[_topContent(context), _bottomContent(context)],
      ),
    );
  }
}
