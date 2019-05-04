class Article {
  final String text;
  final String url;
  final String by;
  final int score;
  final int time;

  const Article(
      {this.text,
      this.url,
      this.by,
      this.score,
      this.time});

  factory Article.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Article(
      text: json['title'] ?? '[null]',
      url: json['url'] ?? '',
      time: json['time'],
      by: json['by'] ?? '',
      score: json['score'] ?? 0
    );
  }
}

final articles = [
  Article(
    text: 'Circular Shock leads the way into glory',
    time: 7263763,
    by: 'Ramona',
    url: 'www.wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 78368723,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 3276728,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 327647,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 234234,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 234324,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 234234,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),

  Article(
    text: 'Circular Shock',
    time: 324234234,
    by: 'Ramona',
    url: 'wiley.com',
    score: 12,
  ),
];
