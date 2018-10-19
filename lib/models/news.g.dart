// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) {
  return News(
      status: json['status'] as String,
      count: json['count'] as int,
      count_total: json['count_total'] as int,
      pages: json['pages'] as int,
      posts: (json['posts'] as List)
          ?.map((e) =>
              e == null ? null : NewsPosts.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'status': instance.status,
      'count': instance.count,
      'count_total': instance.count_total,
      'pages': instance.pages,
      'posts': instance.posts
    };

NewsPosts _$NewsPostsFromJson(Map<String, dynamic> json) {
  return NewsPosts(
      id: json['id'] as int,
      url: json['url'] as String,
      title: json['title'] as String,
      excerpt: json['excerpt'] as String,
      date: json['date'] as String,
      comment_count: json['comment_count'] as int,
      custom_fields: json['custom_fields'] == null
          ? null
          : CustomFields.fromJson(
              json['custom_fields'] as Map<String, dynamic>));
}

Map<String, dynamic> _$NewsPostsToJson(NewsPosts instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'excerpt': instance.excerpt,
      'date': instance.date,
      'comment_count': instance.comment_count,
      'custom_fields': instance.custom_fields
    };

CustomFields _$CustomFieldsFromJson(Map<String, dynamic> json) {
  return CustomFields(thumb_c: json['thumb_c'] as List);
}

Map<String, dynamic> _$CustomFieldsToJson(CustomFields instance) =>
    <String, dynamic>{'thumb_c': instance.thumb_c};
