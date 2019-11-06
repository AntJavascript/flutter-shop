// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return new Product(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new ProductData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['msg'] as String,
      json['total'] as int);
}

abstract class _$ProductSerializerMixin {
  int get code;
  List<ProductData> get data;
  String get msg;
  int get total;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg, 'total': total};
}

ProductData _$ProductDataFromJson(Map<String, dynamic> json) {
  return new ProductData(
      json['Id'] as int,
      json['Title'] as String,
      json['ProductDesc'] as String,
      json['Price'],
      json['Detail'] as String,
      json['AttributeList'] as String,
      json['Stock'] as int,
      json['Status'] as int,
      json['OrignPrice'],
      json['CategoryId'] as int,
      json['CategoryName'] as String,
      json['CategorySubId'] as int,
      json['CategorySubName'] as String,
      json['CreateTime'] as String,
      json['UpdateTime'] as String,
      json['Freight'] as int,
      json['PlaceOrigin'] as String,
      json['Album'] as String,
      json['ProductSpecs'] as String,
      json['Thumbnail'] as String,
      json['IsDel'] as int,
      json['SalesVolume'] as int,
      json['Hot'] as int,
      json['Recommend'] as int);
}

abstract class _$ProductDataSerializerMixin {
  int get id;
  String get title;
  String get productDesc;
  dynamic get price;
  String get detail;
  String get attributeList;
  int get stock;
  int get status;
  dynamic get orignPrice;
  int get categoryId;
  String get categoryName;
  int get categorySubId;
  String get categorySubName;
  String get createTime;
  String get updateTime;
  int get freight;
  String get placeOrigin;
  String get album;
  String get productSpecs;
  String get thumbnail;
  int get isDel;
  int get salesVolume;
  int get hot;
  int get recommend;
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
        'CategoryId': categoryId,
        'CategoryName': categoryName,
        'CategorySubId': categorySubId,
        'CategorySubName': categorySubName,
        'CreateTime': createTime,
        'UpdateTime': updateTime,
        'Freight': freight,
        'PlaceOrigin': placeOrigin,
        'Album': album,
        'ProductSpecs': productSpecs,
        'Thumbnail': thumbnail,
        'IsDel': isDel,
        'SalesVolume': salesVolume,
        'Hot': hot,
        'Recommend': recommend
      };
}
