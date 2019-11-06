// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Common _$CommonFromJson(Map<String, dynamic> json) {
  return new Common(json['code'] as int, json['data'], json['msg'] as String);
}

abstract class _$CommonSerializerMixin {
  int get code;
  dynamic get data;
  String get msg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg};
}
