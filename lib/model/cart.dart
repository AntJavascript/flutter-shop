import 'package:json_annotation/json_annotation.dart'; 
  
part 'cart.g.dart';


@JsonSerializable()
  class Cart extends Object with _$CartSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  dynamic msg;

  @JsonKey(name: 'data')
  List<CartData> data;

  @JsonKey(name: 'total')
  int total;

  Cart(this.code,this.data,this.total,this.msg);

  factory Cart.fromJson(Map<String, dynamic> srcJson) => _$CartFromJson(srcJson);

}

  
@JsonSerializable()
  class CartData extends Object with _$CartDataSerializerMixin{

  @JsonKey(name: 'Cart')
  CartInfo cart;

  @JsonKey(name: 'AttrList')
  AttrList attrList;

  @JsonKey(name: 'ProductImg')
  String productImg;

  @JsonKey(name: 'ProductTitle')
  String productTitle;

  @JsonKey(name: 'ProductPrice')
  dynamic productPrice;

  @JsonKey(name: 'ProductStock')
  int productStock;

  CartData(this.cart,this.attrList,this.productImg,this.productTitle,this.productPrice,this.productStock,);

  factory CartData.fromJson(Map<String, dynamic> srcJson) => _$CartDataFromJson(srcJson);

}

  
@JsonSerializable()
  class CartInfo extends Object with _$CartInfoSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ProductId')
  int productId;

  @JsonKey(name: 'CartNumber')
  int cartNumber;

  @JsonKey(name: 'Attr')
  int attr;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'Status')
  int status;

  @JsonKey(name: 'IsBuy')
  int isBuy;

  CartInfo(this.id,this.productId,this.cartNumber,this.attr,this.userId,this.status,this.isBuy,);

  factory CartInfo.fromJson(Map<String, dynamic> srcJson) => _$CartInfoFromJson(srcJson);

}

  
@JsonSerializable()
  class AttrList extends Object with _$AttrListSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ProductId')
  int productId;

  @JsonKey(name: 'Specs')
  String specs;

  @JsonKey(name: 'CreateTime')
  String createTime;

  @JsonKey(name: 'ProductStock')
  String productStock;

  @JsonKey(name: 'ProductPrice')
  String productPrice;

  AttrList(this.id,this.productId,this.specs,this.createTime,this.productStock,this.productPrice,);

  factory AttrList.fromJson(Map<String, dynamic> srcJson) => _$AttrListFromJson(srcJson);

}

  
