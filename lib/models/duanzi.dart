import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'duanzi.g.dart';


@JsonSerializable()
class DuanZi {
  String status;
  int current_page;
  int total_comments;
  int page_count;
  int count;
  List<DuanZiComments> comments;
  DuanZi({
    this.status,
    this.current_page,
    this.total_comments,
    this.page_count, this.count,
    this.comments});
  factory DuanZi.fromJson(Map<String, dynamic> json) => _$DuanZiFromJson(json);
  Map<String, dynamic> toJson() => _$DuanZiToJson(this);
}


@JsonSerializable()
class DuanZiComments {
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
  DuanZiComments({
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
    this.text_content,});
  factory DuanZiComments.fromJson(Map<String, dynamic> json) => _$DuanZiCommentsFromJson(json);
  Map<String, dynamic> toJson() => _$DuanZiCommentsToJson(this);
}

