class Meizi {
  Meizi({
    this.id,
    this.url,
  });

  final String id;
  final String url;

  @override
  bool operator == (Object other) {
    identical(this, other) ||
    other is Meizi &&
      id == other.id &&
      url == other.url;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      url.hashCode;
}