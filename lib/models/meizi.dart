import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'meizi.g.dart';


@JsonSerializable()
class MeiZi {
  String status;
  int current_page;
  int total_comments;
  int page_count;
  int count;
  List<MeiZiComments> comments;
  MeiZi({
    this.status,
    this.current_page,
    this.total_comments,
    this.page_count, this.count,
    this.comments});
  factory MeiZi.fromJson(Map<String, dynamic> json) => _$MeiZiFromJson(json);
  Map<String, dynamic> toJson() => _$MeiZiToJson(this);
}

@JsonSerializable()
class MeiZiComments {
  String comment_ID;
  String comment_post_ID;
  String comment_author;
  String comment_date;
  String comment_date_gmt;
  String comment_content;
  String user_id;
  String vote_positive;
  String vote_negative;
  String sub_comment_count;
  String text_content;
  List pics;
  MeiZiComments({
    this.comment_ID,
    this.comment_post_ID,
    this.comment_author,
    this.comment_date,
    this.comment_date_gmt,
    this.comment_content,
    this.user_id,
    this.vote_positive,
    this.vote_negative,
    this.sub_comment_count,
    this.text_content,
    this.pics});
  factory MeiZiComments.fromJson(Map<String, dynamic> json) => _$MeiZiCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$MeiZiCommentsToJson(this);
}
