// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ifo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserIfo _$UserIfoFromJson(Map<String, dynamic> json) {
  return new UserIfo(
      json['code'] as int,
      json['data'] == null
          ? null
          : new UserIfoData.fromJson(json['data'] as Map<String, dynamic>));
}

abstract class _$UserIfoSerializerMixin {
  int get code;
  UserIfoData get data;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data};
}

UserIfoData _$UserIfoDataFromJson(Map<String, dynamic> json) {
  return new UserIfoData(
      json['Id'] as int,
      json['CreteTime'] as String,
      json['Phone'] as String,
      json['Password'] as String,
      json['Email'] as String,
      json['Face'] as String,
      json['UserName'] as String);
}

abstract class _$UserIfoDataSerializerMixin {
  int get id;
  String get creteTime;
  String get phone;
  String get password;
  String get email;
  String get face;
  String get userName;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Id': id,
        'CreteTime': creteTime,
        'Phone': phone,
        'Password': password,
        'Email': email,
        'Face': face,
        'UserName': userName
      };
}
