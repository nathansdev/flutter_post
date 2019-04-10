import 'package:flutter/material.dart';
import 'package:flutter_post/model/news.dart';
import 'package:flutter_post/services/news_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Post',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: NewsPage(title: 'Flutter Post'),
    );
  }
}

class NewsPage extends StatefulWidget {
  NewsPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Align(alignment: Alignment.center, child: Text(widget.title),),
        elevation: 0.1,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: _buildNews(),
    );
  }

  Widget _buildNews() {
    return FutureBuilder<News>(
        future: loadNews(), builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return _buildLoadingRow();
        case ConnectionState.done:
          if (snapshot.hasError) {
            return _buildErrorRow();
          }
          return _buildNewsRowList(snapshot.data.articles);
        case ConnectionState.active:
      }
    });
  }

  Widget _buildNewsRowList(List<Article> articles) {
    return ListView.builder(itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: _buildListTile(articles[index]),),);
        });
  }

  Widget _buildErrorRow() {
    return Align(alignment: Alignment.center,
      child: Text("Error!", style: _textStyle(Colors.white, FontWeight.bold)),);
  }

  Widget _buildListTile(Article article) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0, vertical: 10.0),
      title: new Text(article.title,
        style: _textStyle(Colors.white, FontWeight.bold),
      ),
      onTap: pushToDetailPage,);
  }

  TextStyle _textStyle(Color color, FontWeight weight) {
    return TextStyle(color: color, fontWeight: weight);
  }

  pushToDetailPage() {

  }

  Widget _buildLoadingRow() {
    return Align(
      alignment: Alignment.center, child: CircularProgressIndicator(),);
  }
}
