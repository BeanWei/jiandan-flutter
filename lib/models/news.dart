class News {
  News({
    this.id,
    this.url,
    this.title,
    this.excerpt,
    this.cover,
  });

  final String id;
  final String url;
  final String title;
  final String excerpt;
  final String cover;

  @override
  bool operator == (Object other) {
    identical(this, other) ||
        other is News &&
            id == other.id &&
            url == other.url &&
            title == other.title &&
            excerpt == other.excerpt &&
            cover == other.cover;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode ^
      title.hashCode ^
      excerpt.hashCode ^
      cover.hashCode;
}