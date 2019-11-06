// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAddress _$UserAddressFromJson(Map<String, dynamic> json) {
  return new UserAddress(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new UserAddressData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['msg'] as String);
}

abstract class _$UserAddressSerializerMixin {
  int get code;
  List<UserAddressData> get data;
  String get msg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg};
}

UserAddressData _$UserAddressDataFromJson(Map<String, dynamic> json) {
  return new UserAddressData(
      json['Id'] as int,
      json['UserId'] as int,
      json['IsDefault'] as int,
      json['Province'] as String,
      json['City'] as String,
      json['Area'] as String,
      json['Detail'] as String,
      json['Phone'] as String,
      json['Consignee'] as String);
}

abstract class _$UserAddressDataSerializerMixin {
  int get id;
  int get userId;
  int get isDefault;
  String get province;
  String get city;
  String get area;
  String get detail;
  String get phone;
  String get consignee;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'UserId': userId,
        'IsDefault': isDefault,
        'Province': province,
        'City': city,
        'Area': area,
        'Detail': detail,
        'Phone': phone,
        'Consignee': consignee
      };
}
