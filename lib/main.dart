import 'package:flutter/material.dart';
import 'package:flutter_post/detail_page.dart';
import 'package:flutter_post/model/news.dart';
import 'package:flutter_post/services/news_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Feeds',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primaryColor: Colors.white),
      home: NewsPage(title: 'Flutter Feeds'),
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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
          return InkWell(child: Card(
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
            child: _buildCardItem(articles[index]),),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(article: articles[index],)));
            },);
        });
  }

  Widget _buildErrorRow() {
    return Align(alignment: Alignment.center,
      child: Text("Error!", style: _textStyle(Colors.white, FontWeight.bold)),);
  }

  Widget _buildCardItem(Article article) {
    return new Container(
      height: 250.0,
      child: new Stack(
        children: <Widget>[
          _cardBackground(article),
          _cardContent(article)
        ],
      ),
    );
  }

  Widget _cardBackground(Article article) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.luminosity),
            image: new NetworkImage(
                article.urlToImage != null ? article.urlToImage : null),
            fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _cardContent(Article article) {
    return new Align
      (child: Container(
      alignment: Alignment.bottomCenter,
      height: 80.0,
      padding: EdgeInsets.all(10),
      child: new Column(mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new Text(article.title,
              style: TextStyle(color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ), alignment: Alignment.bottomLeft,
    );
  }

  TextStyle _textStyle(Color color, FontWeight weight) {
    return TextStyle(color: color, fontWeight: weight);
  }

  Widget _buildLoadingRow() {
    return Align(
      alignment: Alignment.center, child: CircularProgressIndicator(),);
  }
}
