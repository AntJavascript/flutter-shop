import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_address.g.dart';


@JsonSerializable()
  class UserAddress extends Object with _$UserAddressSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<UserAddressData> data;

  @JsonKey(name: 'msg')
  String msg;

  UserAddress(this.code,this.data,this.msg,);

  factory UserAddress.fromJson(Map<String, dynamic> srcJson) => _$UserAddressFromJson(srcJson);

}

  
@JsonSerializable()
  class UserAddressData extends Object with _$UserAddressDataSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'IsDefault')
  int isDefault;

  @JsonKey(name: 'Province')
  String province;

  @JsonKey(name: 'City')
  String city;

  @JsonKey(name: 'Area')
  String area;

  @JsonKey(name: 'Detail')
  String detail;

  @JsonKey(name: 'Phone')
  String phone;

  @JsonKey(name: 'Consignee')
  String consignee;

  UserAddressData(this.id,this.userId,this.isDefault,this.province,this.city,this.area,this.detail,this.phone,this.consignee,);

  factory UserAddressData.fromJson(Map<String, dynamic> srcJson) => _$UserAddressDataFromJson(srcJson);

}

  
