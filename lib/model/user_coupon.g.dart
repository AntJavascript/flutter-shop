// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCoupon _$UserCouponFromJson(Map<String, dynamic> json) {
  return new UserCoupon(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new UserCouponData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['total'] as int,
      (json['user_list'] as List)
          ?.map((e) => e == null
              ? null
              : new UserList.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

abstract class _$UserCouponSerializerMixin {
  int get code;
  List<UserCouponData> get data;
  int get total;
  List<UserList> get userList;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'data': data,
        'total': total,
        'user_list': userList
      };
}

UserCouponData _$UserCouponDataFromJson(Map<String, dynamic> json) {
  return new UserCouponData(json['Id'] as int, json['UserId'] as int,
      json['CouponId'] as int, json['IsUse'] as int);
}

abstract class _$UserCouponDataSerializerMixin {
  int get id;
  int get userId;
  int get couponId;
  int get isUse;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'UserId': userId,
        'CouponId': couponId,
        'IsUse': isUse
      };
}

UserList _$UserListFromJson(Map<String, dynamic> json) {
  return new UserList(
      json['Desc'] as String,
      json['EndTime'] as String,
      json['Id'] as int,
      json['IsUse'] as int,
      json['MinAccount'] as int,
      json['Price'] as int,
      json['StartTime'] as String,
      json['Title'] as String);
}

abstract class _$UserListSerializerMixin {
  String get desc;
  String get endTime;
  int get id;
  int get isUse;
  int get minAccount;
  int get price;
  String get startTime;
  String get title;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Desc': desc,
        'EndTime': endTime,
        'Id': id,
        'IsUse': isUse,
        'MinAccount': minAccount,
        'Price': price,
        'StartTime': startTime,
        'Title': title
      };
}
