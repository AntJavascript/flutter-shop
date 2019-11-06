// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return new Address(
      json['code'] as int,
      json['data'] == null
          ? null
          : new AddressData.fromJson(json['data'] as Map<String, dynamic>),
      json['msg'] as String);
}

abstract class _$AddressSerializerMixin {
  int get code;
  AddressData get data;
  String get msg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg};
}

AddressData _$AddressDataFromJson(Map<String, dynamic> json) {
  return new AddressData(
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

abstract class _$AddressDataSerializerMixin {
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
