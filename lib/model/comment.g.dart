// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return new Comment(
      json['code'] as int,
      (json['data'] as List)
          ?.map((e) => e == null
              ? null
              : new CommentData.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['msg'] as String);
}

abstract class _$CommentSerializerMixin {
  int get code;
  List<CommentData> get data;
  String get msg;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'code': code, 'data': data, 'msg': msg};
}

CommentData _$CommentDataFromJson(Map<String, dynamic> json) {
  return new CommentData(
      json['Comment'] as String,
      json['CommentImg'] as String,
      json['CreateTime'] as String,
      json['Id'] as int,
      json['OrderId'] as String,
      json['ProductId'] as int,
      json['Star'] as int,
      json['UserId'] as int,
      json['UserInfo'] == null
          ? null
          : new UserInfo.fromJson(json['UserInfo'] as Map<String, dynamic>));
}

abstract class _$CommentDataSerializerMixin {
  String get comment;
  String get commentImg;
  String get createTime;
  int get id;
  String get orderId;
  int get productId;
  int get star;
  int get userId;
  UserInfo get userInfo;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Comment': comment,
        'CommentImg': commentImg,
        'CreateTime': createTime,
        'Id': id,
        'OrderId': orderId,
        'ProductId': productId,
        'Star': star,
        'UserId': userId,
        'UserInfo': userInfo
      };
}

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return new UserInfo(
      json['Id'] as int,
      json['CreteTime'] as String,
      json['Phone'] as String,
      json['Password'] as String,
      json['Email'] as String,
      json['Face'] as String,
      json['UserName'] as String);
}

abstract class _$UserInfoSerializerMixin {
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
