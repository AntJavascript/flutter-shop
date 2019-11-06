import 'package:json_annotation/json_annotation.dart'; 
  
part 'order_list.g.dart';


@JsonSerializable()
  class OrderList extends Object with _$OrderListSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<OrderListData> data;

  @JsonKey(name: 'total')
  int total;

  OrderList(this.code,this.data,this.total,);

  factory OrderList.fromJson(Map<String, dynamic> srcJson) => _$OrderListFromJson(srcJson);

}

  
@JsonSerializable()
  class OrderListData extends Object with _$OrderListDataSerializerMixin{

  @JsonKey(name: 'Order')
  Order order;

  @JsonKey(name: 'ProductList')
  List<ProductList> productList;

  @JsonKey(name: 'CartList')
  List<CartList> cartList;

  @JsonKey(name: 'ProductSpecsList')
  List<ProductSpecsList> productSpecsList;

  @JsonKey(name: 'Comment')
  List<dynamic> comment;

  OrderListData(this.order,this.productList,this.cartList,this.productSpecsList,this.comment,);

  factory OrderListData.fromJson(Map<String, dynamic> srcJson) => _$OrderListDataFromJson(srcJson);

}

  
@JsonSerializable()
  class Order extends Object with _$OrderSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ProductId')
  String productId;

  @JsonKey(name: 'CartId')
  String cartId;

  @JsonKey(name: 'RealPayAmount')
  dynamic realPayAmount;

  @JsonKey(name: 'CouponId')
  int couponId;

  @JsonKey(name: 'CouponAmount')
  int couponAmount;

  @JsonKey(name: 'Phone')
  String phone;

  @JsonKey(name: 'Name')
  String name;

  @JsonKey(name: 'Address')
  String address;

  @JsonKey(name: 'PayType')
  int payType;

  @JsonKey(name: 'FreightAmount')
  int freightAmount;

  @JsonKey(name: 'Remarks')
  String remarks;

  @JsonKey(name: 'OrderStatus')
  int orderStatus;

  @JsonKey(name: 'UserId')
  int userId;

  @JsonKey(name: 'Logistics')
  String logistics;

  @JsonKey(name: 'LogisticsNumber')
  String logisticsNumber;

  @JsonKey(name: 'BuyNumber')
  int buyNumber;

  @JsonKey(name: 'OrderId')
  String orderId;

  @JsonKey(name: 'CreateTime')
  String createTime;

  @JsonKey(name: 'TotalPrice')
  dynamic totalPrice;

  @JsonKey(name: 'SendTime')
  String sendTime;

  @JsonKey(name: 'PayTime')
  String payTime;

  @JsonKey(name: 'ReceiveTime')
  String receiveTime;

  @JsonKey(name: 'AttrId')
  String attrId;

  Order(this.id,this.productId,this.cartId,this.realPayAmount,this.couponId,this.couponAmount,this.phone,this.name,this.address,this.payType,this.freightAmount,this.remarks,this.orderStatus,this.userId,this.logistics,this.logisticsNumber,this.buyNumber,this.orderId,this.createTime,this.totalPrice,this.sendTime,this.payTime,this.receiveTime,this.attrId,);

  factory Order.fromJson(Map<String, dynamic> srcJson) => _$OrderFromJson(srcJson);

}

  
@JsonSerializable()
  class ProductList extends Object with _$ProductListSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'ProductDesc')
  String productDesc;

  @JsonKey(name: 'Price')
  double price;

  @JsonKey(name: 'Detail')
  String detail;

  @JsonKey(name: 'AttributeList')
  String attributeList;

  @JsonKey(name: 'Stock')
  int stock;

  @JsonKey(name: 'Status')
  int status;

  @JsonKey(name: 'OrignPrice')
  double orignPrice;

  @JsonKey(name: 'CategoryId')
  int categoryId;

  @JsonKey(name: 'CategoryName')
  String categoryName;

  @JsonKey(name: 'CategorySubId')
  int categorySubId;

  @JsonKey(name: 'CategorySubName')
  String categorySubName;

  @JsonKey(name: 'CreateTime')
  String createTime;

  @JsonKey(name: 'UpdateTime')
  String updateTime;

  @JsonKey(name: 'Freight')
  int freight;

  @JsonKey(name: 'PlaceOrigin')
  String placeOrigin;

  @JsonKey(name: 'Album')
  String album;

  @JsonKey(name: 'ProductSpecs')
  String productSpecs;

  @JsonKey(name: 'Thumbnail')
  String thumbnail;

  @JsonKey(name: 'IsDel')
  int isDel;

  @JsonKey(name: 'SalesVolume')
  int salesVolume;

  @JsonKey(name: 'Hot')
  int hot;

  @JsonKey(name: 'Recommend')
  int recommend;

  ProductList(this.id,this.title,this.productDesc,this.price,this.detail,this.attributeList,this.stock,this.status,this.orignPrice,this.categoryId,this.categoryName,this.categorySubId,this.categorySubName,this.createTime,this.updateTime,this.freight,this.placeOrigin,this.album,this.productSpecs,this.thumbnail,this.isDel,this.salesVolume,this.hot,this.recommend,);

  factory ProductList.fromJson(Map<String, dynamic> srcJson) => _$ProductListFromJson(srcJson);

}

  
@JsonSerializable()
  class CartList extends Object with _$CartListSerializerMixin{

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

  CartList(this.id,this.productId,this.cartNumber,this.attr,this.userId,this.status,this.isBuy,);

  factory CartList.fromJson(Map<String, dynamic> srcJson) => _$CartListFromJson(srcJson);

}

  
@JsonSerializable()
  class ProductSpecsList extends Object with _$ProductSpecsListSerializerMixin{

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

  ProductSpecsList(this.id,this.productId,this.specs,this.createTime,this.productStock,this.productPrice,);

  factory ProductSpecsList.fromJson(Map<String, dynamic> srcJson) => _$ProductSpecsListFromJson(srcJson);

}

  
