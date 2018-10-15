class DuanZi {
  DuanZi({
    this.author,
    this.positive,
    this.negative,
    this.comment,
    this.content,
  });

  final String author;
  final String positive;
  final String negative;
  final String comment;
  final String content;

  @override
  bool operator == (Object other) {
    identical(this, other) ||
        other is DuanZi &&
            author == other.author &&
            positive == other.positive &&
            negative == other.negative &&
            comment == other.comment &&
            content == other.content;
  }

  @override
  int get hashCode =>
      author.hashCode ^
      positive.hashCode ^
      negative.hashCode ^
      comment.hashCode ^
      content.hashCode;
}