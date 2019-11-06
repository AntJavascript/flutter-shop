import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_ifo.g.dart';


@JsonSerializable()
  class UserIfo extends Object with _$UserIfoSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  UserIfoData data;

  UserIfo(this.code,this.data,);

  factory UserIfo.fromJson(Map<String, dynamic> srcJson) => _$UserIfoFromJson(srcJson);

}

  
@JsonSerializable()
  class UserIfoData extends Object with _$UserIfoDataSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'CreteTime')
  String creteTime;

  @JsonKey(name: 'Phone')
  String phone;

  @JsonKey(name: 'Password')
  String password;

  @JsonKey(name: 'Email')
  String email;

  @JsonKey(name: 'Face')
  String face;

  @JsonKey(name: 'UserName')
  String userName;

  UserIfoData(this.id,this.creteTime,this.phone,this.password,this.email,this.face,this.userName,);

  factory UserIfoData.fromJson(Map<String, dynamic> srcJson) => _$UserIfoDataFromJson(srcJson);

}

  
