// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return new OrderDetail(
      json['code'] as int,
      json['data'] == null
          ? null
          : new OrderDetailData.fromJson(json['data'] as Map<String, dynamic>),
      json['msg'] as String);
}

abstract class _$OrderDetailSerializerMixin {
  int get code;
  OrderDetailData get data;
  String get msg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg};
}

OrderDetailData _$OrderDetailDataFromJson(Map<String, dynamic> json) {
  return new OrderDetailData(
      json['Order'] == null
          ? null
          : new Order.fromJson(json['Order'] as Map<String, dynamic>),
      (json['ProductList'] as List)
          ?.map((e) => e == null
              ? null
              : new ProductList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['CartList'] as List)
          ?.map((e) => e == null
              ? null
              : new CartList.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['ProductSpecsList'] as List)
          ?.map((e) => e == null
              ? null
              : new ProductSpecsList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$OrderDetailDataSerializerMixin {
  Order get order;
  List<ProductList> get productList;
  List<CartList> get cartList;
  List<ProductSpecsList> get productSpecsList;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Order': order,
        'ProductList': productList,
        'CartList': cartList,
        'ProductSpecsList': productSpecsList
      };
}

Order _$OrderFromJson(Map<String, dynamic> json) {
  return new Order(
      json['Id'] as int,
      json['ProductId'] as String,
      json['CartId'] as String,
      json['RealPayAmount'],
      json['CouponId'] as int,
      json['CouponAmount'],
      json['Phone'] as String,
      json['Name'] as String,
      json['Address'] as String,
      json['PayType'] as int,
      json['FreightAmount'],
      json['Remarks'] as String,
      json['OrderStatus'] as int,
      json['UserId'] as int,
      json['Logistics'] as String,
      json['LogisticsNumber'] as String,
      json['BuyNumber'] as int,
      json['OrderId'] as String,
      json['CreateTime'] as String,
      json['TotalPrice'],
      json['SendTime'] as String,
      json['PayTime'] as String,
      json['ReceiveTime'] as String,
      json['AttrId'] as String);
}

abstract class _$OrderSerializerMixin {
  int get id;
  String get productId;
  String get cartId;
  dynamic get realPayAmount;
  int get couponId;
  dynamic get couponAmount;
  String get phone;
  String get name;
  String get address;
  int get payType;
  dynamic get freightAmount;
  String get remarks;
  int get orderStatus;
  int get userId;
  String get logistics;
  String get logisticsNumber;
  int get buyNumber;
  String get orderId;
  String get createTime;
  dynamic get totalPrice;
  String get sendTime;
  String get payTime;
  String get receiveTime;
  String get attrId;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'ProductId': productId,
        'CartId': cartId,
        'RealPayAmount': realPayAmount,
        'CouponId': couponId,
        'CouponAmount': couponAmount,
        'Phone': phone,
        'Name': name,
        'Address': address,
        'PayType': payType,
        'FreightAmount': freightAmount,
        'Remarks': remarks,
        'OrderStatus': orderStatus,
        'UserId': userId,
        'Logistics': logistics,
        'LogisticsNumber': logisticsNumber,
        'BuyNumber': buyNumber,
        'OrderId': orderId,
        'CreateTime': createTime,
        'TotalPrice': totalPrice,
        'SendTime': sendTime,
        'PayTime': payTime,
        'ReceiveTime': receiveTime,
        'AttrId': attrId
      };
}

ProductList _$ProductListFromJson(Map<String, dynamic> json) {
  return new ProductList(
      json['Id'] as int,
      json['Title'] as String,
      json['ProductDesc'] as String,
      (json['Price'] as num)?.toDouble(),
      json['Detail'] as String,
      json['AttributeList'] as String,
      json['Stock'] as int,
      json['Status'] as int,
      (json['OrignPrice'] as num)?.toDouble(),
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

abstract class _$ProductListSerializerMixin {
  int get id;
  String get title;
  String get productDesc;
  double get price;
  String get detail;
  String get attributeList;
  int get stock;
  int get status;
  double get orignPrice;
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

CartList _$CartListFromJson(Map<String, dynamic> json) {
  return new CartList(
      json['Id'] as int,
      json['ProductId'] as int,
      json['CartNumber'] as int,
      json['Attr'] as int,
      json['UserId'] as int,
      json['Status'] as int,
      json['IsBuy'] as int);
}

abstract class _$CartListSerializerMixin {
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

ProductSpecsList _$ProductSpecsListFromJson(Map<String, dynamic> json) {
  return new ProductSpecsList(
      json['Id'] as int,
      json['ProductId'] as int,
      json['Specs'] as String,
      json['CreateTime'] as String,
      json['ProductStock'] as String,
      json['ProductPrice'] as String);
}

abstract class _$ProductSpecsListSerializerMixin {
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
