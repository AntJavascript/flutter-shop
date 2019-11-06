import 'package:json_annotation/json_annotation.dart'; 
  
part 'product.g.dart';


@JsonSerializable()
  class Product extends Object with _$ProductSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<ProductData> data;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'total')
  int total;

  Product(this.code,this.data,this.msg,this.total,);

  factory Product.fromJson(Map<String, dynamic> srcJson) => _$ProductFromJson(srcJson);

}

  
@JsonSerializable()
  class ProductData extends Object with _$ProductDataSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'ProductDesc')
  String productDesc;

  @JsonKey(name: 'Price')
  dynamic price;

  @JsonKey(name: 'Detail')
  String detail;

  @JsonKey(name: 'AttributeList')
  String attributeList;

  @JsonKey(name: 'Stock')
  int stock;

  @JsonKey(name: 'Status')
  int status;

  @JsonKey(name: 'OrignPrice')
  dynamic orignPrice;

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

  ProductData(this.id,this.title,this.productDesc,this.price,this.detail,this.attributeList,this.stock,this.status,this.orignPrice,this.categoryId,this.categoryName,this.categorySubId,this.categorySubName,this.createTime,this.updateTime,this.freight,this.placeOrigin,this.album,this.productSpecs,this.thumbnail,this.isDel,this.salesVolume,this.hot,this.recommend,);

  factory ProductData.fromJson(Map<String, dynamic> srcJson) => _$ProductDataFromJson(srcJson);

}

  
