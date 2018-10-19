import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
part 'news.g.dart';


@JsonSerializable()
class News {
  String status;
  int count;
  int count_total;
  int pages;
  List<NewsPosts> posts;
  News({
    this.status,
    this.count,
    this.count_total,
    this.pages,
    this.posts});
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}

@JsonSerializable()
class NewsPosts {
  int id;
  String url;
  String title;
  String excerpt;
  String date;
  int comment_count;
  CustomFields custom_fields;
  NewsPosts({
    this.id,
    this.url,
    this.title,
    this.excerpt,
    this.date,
    this.comment_count,
    this.custom_fields});
  factory NewsPosts.fromJson(Map<String, dynamic> json) => _$NewsPostsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsPostsToJson(this);
}

@JsonSerializable()
class CustomFields {
  List thumb_c;
  CustomFields({
    this.thumb_c
  });
  factory CustomFields.fromJson(Map<String, dynamic> json) => _$CustomFieldsFromJson(json);
  Map<String, dynamic> toJson() => _$CustomFieldsToJson(this);
}
