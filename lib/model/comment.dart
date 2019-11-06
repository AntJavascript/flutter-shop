import 'package:json_annotation/json_annotation.dart'; 
  
part 'comment.g.dart';


@JsonSerializable()
  class Comment extends Object with _$CommentSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<CommentData> data;

  @JsonKey(name: 'msg')
  String msg;

  Comment(this.code,this.data,this.msg,);

  factory Comment.fromJson(Map<String, dynamic> srcJson) => _$CommentFromJson(srcJson);
  
  }
  

  
@JsonSerializable()
  class CommentData extends Object with _$CommentDataSerializerMixin{

  @JsonKey(name: 'Comment')
  String comment;

  @JsonKey(name: 'CommentImg')
  String commentImg;

  @JsonKey(name: 'CreateTime')
  String createTime;

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'OrderId')
  String orderId;

  @JsonKey(name: 'ProductId')
  int productId;

  @JsonKey(name: 'Star')
  int star;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'UserInfo')
  UserInfo userInfo;

  CommentData(this.comment,this.commentImg,this.createTime,this.id,this.orderId,this.productId,this.star,this.userId,this.userInfo,);

  factory CommentData.fromJson(Map<String, dynamic> srcJson) => _$CommentDataFromJson(srcJson);

}

  
@JsonSerializable()
  class UserInfo extends Object with _$UserInfoSerializerMixin{

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

  UserInfo(this.id,this.creteTime,this.phone,this.password,this.email,this.face,this.userName,);

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) => _$UserInfoFromJson(srcJson);

}

  
