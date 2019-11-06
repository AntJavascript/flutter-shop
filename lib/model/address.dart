import 'package:json_annotation/json_annotation.dart'; 
  
part 'address.g.dart';


@JsonSerializable()
  class Address extends Object with _$AddressSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  AddressData data;

  @JsonKey(name: 'msg')
  String msg;

  Address(this.code,this.data,this.msg,);

  factory Address.fromJson(Map<String, dynamic> srcJson) => _$AddressFromJson(srcJson);

}

  
@JsonSerializable()
  class AddressData extends Object with _$AddressDataSerializerMixin{

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

  AddressData(this.id,this.userId,this.isDefault,this.province,this.city,this.area,this.detail,this.phone,this.consignee,);

  factory AddressData.fromJson(Map<String, dynamic> srcJson) => _$AddressDataFromJson(srcJson);

}

  
