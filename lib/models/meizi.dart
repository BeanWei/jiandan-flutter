class Meizi {
  Meizi({
    this.title,
    this.url,
  });

  final String title;
  final String url;

  @override
  bool operator == (Object other) {
    identical(this, other) ||
    other is Meizi &&
      title == other.title &&
      url == other.url;
  }

  @override
  int get hashCode =>
      title.hashCode ^
      url.hashCode;
}