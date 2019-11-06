import 'package:json_annotation/json_annotation.dart'; 
  
part 'user_coupon.g.dart';


@JsonSerializable()
  class UserCoupon extends Object with _$UserCouponSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<UserCouponData> data;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'user_list')
  List<UserList> userList;

  UserCoupon(this.code,this.data,this.total,this.userList,);

  factory UserCoupon.fromJson(Map<String, dynamic> srcJson) => _$UserCouponFromJson(srcJson);

}

  
@JsonSerializable()
  class UserCouponData extends Object with _$UserCouponDataSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'CouponId')
  int couponId;

  @JsonKey(name: 'IsUse')
  int isUse;

  UserCouponData(this.id,this.userId,this.couponId,this.isUse,);

  factory UserCouponData.fromJson(Map<String, dynamic> srcJson) => _$UserCouponDataFromJson(srcJson);

}

  
@JsonSerializable()
  class UserList extends Object with _$UserListSerializerMixin{

  @JsonKey(name: 'Desc')
  String desc;

  @JsonKey(name: 'EndTime')
  String endTime;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'IsUse')
  int isUse;

  @JsonKey(name: 'MinAccount')
  int minAccount;

  @JsonKey(name: 'Price')
  int price;

  @JsonKey(name: 'StartTime')
  String startTime;

  @JsonKey(name: 'Title')
  String title;

  UserList(this.desc,this.endTime,this.id,this.isUse,this.minAccount,this.price,this.startTime,this.title,);

  factory UserList.fromJson(Map<String, dynamic> srcJson) => _$UserListFromJson(srcJson);

}

  
