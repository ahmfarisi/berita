class Berita {
  final String author;
  final String title;
  final String url;
  final String publishedAt;

  Berita(
      {required this.author,
      required this.title,
      required this.url,
      required this.publishedAt});

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
