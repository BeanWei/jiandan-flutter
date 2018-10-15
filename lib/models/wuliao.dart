class WuLiao {
  WuLiao({
    this.author,
    this.positive,
    this.negative,
    this.comment,
    this.picUrl,
  });

  final String author;
  final String positive;
  final String negative;
  final String comment;
  final String picUrl;

  @override
  bool operator == (Object other) {
    identical(this, other) ||
        other is WuLiao &&
            author == other.author &&
            positive == other.positive &&
            negative == other.negative &&
            comment == other.comment &&
            picUrl == other.picUrl;
  }

  @override
  int get hashCode =>
      author.hashCode ^
      positive.hashCode ^
      negative.hashCode ^
      comment.hashCode ^
      picUrl.hashCode;
}