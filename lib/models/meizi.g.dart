// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meizi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeiZi _$MeiZiFromJson(Map<String, dynamic> json) {
  return MeiZi(
      status: json['status'] as String,
      current_page: json['current_page'] as int,
      total_comments: json['total_comments'] as int,
      page_count: json['page_count'] as int,
      count: json['count'] as int,
      comments: (json['comments'] as List)
          ?.map((e) => e == null
              ? null
              : MeiZiComments.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$MeiZiToJson(MeiZi instance) => <String, dynamic>{
      'status': instance.status,
      'current_page': instance.current_page,
      'total_comments': instance.total_comments,
      'page_count': instance.page_count,
      'count': instance.count,
      'comments': instance.comments
    };

MeiZiComments _$MeiZiCommentsFromJson(Map<String, dynamic> json) {
  return MeiZiComments(
      comment_ID: json['comment_ID'] as String,
      comment_post_ID: json['comment_post_ID'] as String,
      comment_author: json['comment_author'] as String,
      comment_date: json['comment_date'] as String,
      comment_date_gmt: json['comment_date_gmt'] as String,
      comment_content: json['comment_content'] as String,
      user_id: json['user_id'] as String,
      vote_positive: json['vote_positive'] as String,
      vote_negative: json['vote_negative'] as String,
      sub_comment_count: json['sub_comment_count'] as String,
      text_content: json['text_content'] as String,
      pics: json['pics'] as List);
}

Map<String, dynamic> _$MeiZiCommentsToJson(MeiZiComments instance) =>
    <String, dynamic>{
      'comment_ID': instance.comment_ID,
      'comment_post_ID': instance.comment_post_ID,
      'comment_author': instance.comment_author,
      'comment_date': instance.comment_date,
      'comment_date_gmt': instance.comment_date_gmt,
      'comment_content': instance.comment_content,
      'user_id': instance.user_id,
      'vote_positive': instance.vote_positive,
      'vote_negative': instance.vote_negative,
      'sub_comment_count': instance.sub_comment_count,
      'text_content': instance.text_content,
      'pics': instance.pics
    };
