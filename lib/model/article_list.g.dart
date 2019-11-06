// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return new ArticleList(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new ArticleListData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['total'] as int);
}

abstract class _$ArticleListSerializerMixin {
  int get code;
  List<ArticleListData> get data;
  int get total;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'total': total};
}

ArticleListData _$ArticleListDataFromJson(Map<String, dynamic> json) {
  return new ArticleListData(
      json['Id'] as int,
      json['Title'] as String,
      json['Desc'] as String,
      json['Content'] as String,
      json['CreateTime'] as String,
      json['ProductId'] as int,
      json['ViewCount'] as int);
}

abstract class _$ArticleListDataSerializerMixin {
  int get id;
  String get title;
  String get desc;
  String get content;
  String get createTime;
  int get productId;
  int get viewCount;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Title': title,
        'Desc': desc,
        'Content': content,
        'CreateTime': createTime,
        'ProductId': productId,
        'ViewCount': viewCount
      };
}
