// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Classify _$ClassifyFromJson(Map<String, dynamic> json) {
  return new Classify(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new ClassifyData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['msg'] as String,
      json['total'] as int);
}

abstract class _$ClassifySerializerMixin {
  int get code;
  List<ClassifyData> get data;
  String get msg;
  int get total;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg, 'total': total};
}

ClassifyData _$ClassifyDataFromJson(Map<String, dynamic> json) {
  return new ClassifyData(
      json['Id'] as int,
      json['ClassifyName'] as String,
      json['ParentId'] as int,
      json['Img'] as String,
      (json['Children'] as List)
          ?.map((e) => e == null
              ? null
              : new Children.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$ClassifyDataSerializerMixin {
  int get id;
  String get classifyName;
  int get parentId;
  String get img;
  List<Children> get children;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'ClassifyName': classifyName,
        'ParentId': parentId,
        'Img': img,
        'Children': children
      };
}

Children _$ChildrenFromJson(Map<String, dynamic> json) {
  return new Children(json['Id'] as int, json['ClassifyName'] as String,
      json['ParentId'] as int, json['Img'] as String);
}

abstract class _$ChildrenSerializerMixin {
  int get id;
  String get classifyName;
  int get parentId;
  String get img;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'ClassifyName': classifyName,
        'ParentId': parentId,
        'Img': img
      };
}
