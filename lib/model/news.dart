class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({this.status, this.totalResults, this.articles});

  factory News.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['articles'] as List;
    List<Article> articleList = list.map((i) => Article.fromJson(i)).toList();
    return News(
        status: parsedJson['status'],
        totalResults: parsedJson['totalResults'],
        articles: articleList);
  }
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> parsedJson) {
    return Article(
        source: Source.fromJson(parsedJson['source']),
        author: parsedJson['author'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        url: parsedJson['url'],
        urlToImage: parsedJson['urlToImage'],
        publishedAt: parsedJson['publishedAt'],
        content: parsedJson['content']);
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> parsedJson) {
    return Source(id: parsedJson['id'], name: parsedJson['name']);
  }
}
