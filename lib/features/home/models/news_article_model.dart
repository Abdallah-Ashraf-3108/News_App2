class NewsArticleModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  NewsArticleModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // Convert String To Map
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  // Convert Data From Map To Model
  factory NewsArticleModel.fromJson(Map<String, dynamic> map) {
    return NewsArticleModel(
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'] as String,
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }

  String formatDateTime() {
    if (publishedAt == null) return "";
    final diff = DateTime.now().difference(DateTime.parse(publishedAt!));
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";

    return "${diff.inDays}d ago";
  }
}
