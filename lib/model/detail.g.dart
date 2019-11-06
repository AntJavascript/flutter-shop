// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) {
  return new Detail(
      (json['attrList'] as List)
          ?.map((e) => e == null
              ? null
              : new AttrList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['code'] as int,
      json['data'] == null
          ? null
          : new DetailData.fromJson(json['data'] as Map<String, dynamic>),
      json['msg'] as String,
      json['num'] as int);
}

abstract class _$DetailSerializerMixin {
  List<AttrList> get attrList;
  int get code;
  DetailData get data;
  String get msg;
  int get num;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'attrList': attrList,
        'code': code,
        'data': data,
        'msg': msg,
        'num': num
      };
}

AttrList _$AttrListFromJson(Map<String, dynamic> json) {
  return new AttrList(
      json['Id'] as int,
      json['ProductId'] as int,
      json['Specs'] as String,
      json['CreateTime'] as String,
      json['ProductStock'] as String,
      json['ProductPrice'] as String);
}

abstract class _$AttrListSerializerMixin {
  int get id;
  int get productId;
  String get specs;
  String get createTime;
  String get productStock;
  String get productPrice;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'ProductId': productId,
        'Specs': specs,
        'CreateTime': createTime,
        'ProductStock': productStock,
        'ProductPrice': productPrice
      };
}

DetailData _$DetailDataFromJson(Map<String, dynamic> json) {
  return new DetailData(
      json['Id'] as int,
      json['Title'] as String,
      json['ProductDesc'] as String,
      json['Price'],
      json['Detail'] as String,
      json['AttributeList'] as String,
      json['Stock'] as int,
      json['Status'] as int,
      json['OrignPrice'],
      json['Freight'] as int,
      json['PlaceOrigin'] as String,
      json['Album'] as String,
      json['Thumbnail'] as String,
      json['SalesVolume'] as int,
      json['Hot'] as int,
      json['Recommend'] as int,
      (json['SpecsList'] as List)
          ?.map((e) => e == null
              ? null
              : new SpecsList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$DetailDataSerializerMixin {
  int get id;
  String get title;
  String get productDesc;
  dynamic get price;
  String get detail;
  String get attributeList;
  int get stock;
  int get status;
  dynamic get orignPrice;
  int get freight;
  String get placeOrigin;
  String get album;
  String get thumbnail;
  int get salesVolume;
  int get hot;
  int get recommend;
  List<SpecsList> get specsList;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'Title': title,
        'ProductDesc': productDesc,
        'Price': price,
        'Detail': detail,
        'AttributeList': attributeList,
        'Stock': stock,
        'Status': status,
        'OrignPrice': orignPrice,
        'Freight': freight,
        'PlaceOrigin': placeOrigin,
        'Album': album,
        'Thumbnail': thumbnail,
        'SalesVolume': salesVolume,
        'Hot': hot,
        'Recommend': recommend,
        'SpecsList': specsList
      };
}

SpecsList _$SpecsListFromJson(Map<String, dynamic> json) {
  return new SpecsList(
      (json['checkedCities'] as List)?.map((e) => e as String)?.toList(),
      json['name'] as String);
}

abstract class _$SpecsListSerializerMixin {
  List<String> get checkedCities;
  String get name;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'checkedCities': checkedCities, 'name': name};
}
