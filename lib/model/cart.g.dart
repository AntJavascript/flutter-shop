// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return new Cart(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new CartData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['total'] as int,
      json['msg']);
}

abstract class _$CartSerializerMixin {
  int get code;
  dynamic get msg;
  List<CartData> get data;
  int get total;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'msg': msg, 'data': data, 'total': total};
}

CartData _$CartDataFromJson(Map<String, dynamic> json) {
  return new CartData(
      json['Cart'] == null
          ? null
          : new CartInfo.fromJson(json['Cart'] as Map<String, dynamic>),
      json['AttrList'] == null
          ? null
          : new AttrList.fromJson(json['AttrList'] as Map<String, dynamic>),
      json['ProductImg'] as String,
      json['ProductTitle'] as String,
      json['ProductPrice'],
      json['ProductStock'] as int);
}

abstract class _$CartDataSerializerMixin {
  CartInfo get cart;
  AttrList get attrList;
  String get productImg;
  String get productTitle;
  dynamic get productPrice;
  int get productStock;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Cart': cart,
        'AttrList': attrList,
        'ProductImg': productImg,
        'ProductTitle': productTitle,
        'ProductPrice': productPrice,
        'ProductStock': productStock
      };
}

CartInfo _$CartInfoFromJson(Map<String, dynamic> json) {
  return new CartInfo(
      json['Id'] as int,
      json['ProductId'] as int,
      json['CartNumber'] as int,
      json['Attr'] as int,
      json['UserId'] as int,
      json['Status'] as int,
      json['IsBuy'] as int);
}

abstract class _$CartInfoSerializerMixin {
  int get id;
  int get productId;
  int get cartNumber;
  int get attr;
  int get userId;
  int get status;
  int get isBuy;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'ProductId': productId,
        'CartNumber': cartNumber,
        'Attr': attr,
        'UserId': userId,
        'Status': status,
        'IsBuy': isBuy
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
