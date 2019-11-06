import 'package:json_annotation/json_annotation.dart'; 
  
part 'add_cart.g.dart';


@JsonSerializable()
  class Common extends Object with _$CommonSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  dynamic data;

  @JsonKey(name: 'msg')
  String msg;

  Common(this.code,this.data,this.msg,);

  factory Common.fromJson(Map<String, dynamic> srcJson) => _$CommonFromJson(srcJson);

}
