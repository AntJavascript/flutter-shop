import 'package:json_annotation/json_annotation.dart'; 
  
part 'detail.g.dart';


@JsonSerializable()
  class Detail extends Object with _$DetailSerializerMixin{

  @JsonKey(name: 'attrList')
  List<AttrList> attrList;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  DetailData data;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'num')
  int num;

  Detail(this.attrList,this.code,this.data,this.msg,this.num,);

  factory Detail.fromJson(Map<String, dynamic> srcJson) => _$DetailFromJson(srcJson);

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

  
@JsonSerializable()
  class DetailData extends Object with _$DetailDataSerializerMixin{

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

  @JsonKey(name: 'Freight')
  int freight;

  @JsonKey(name: 'PlaceOrigin')
  String placeOrigin;

  @JsonKey(name: 'Album')
  String album;

  @JsonKey(name: 'Thumbnail')
  String thumbnail;

  @JsonKey(name: 'SalesVolume')
  int salesVolume;

  @JsonKey(name: 'Hot')
  int hot;

  @JsonKey(name: 'Recommend')
  int recommend;

  @JsonKey(name: 'SpecsList')
  List<SpecsList> specsList;

  DetailData(this.id,this.title,this.productDesc,this.price,this.detail,this.attributeList,this.stock,this.status,this.orignPrice,this.freight,this.placeOrigin,this.album,this.thumbnail,this.salesVolume,this.hot,this.recommend,this.specsList,);

  factory DetailData.fromJson(Map<String, dynamic> srcJson) => _$DetailDataFromJson(srcJson);

}

  
@JsonSerializable()
  class SpecsList extends Object with _$SpecsListSerializerMixin{

  @JsonKey(name: 'checkedCities')
  List<String> checkedCities;

  @JsonKey(name: 'name')
  String name;

  SpecsList(this.checkedCities,this.name,);

  factory SpecsList.fromJson(Map<String, dynamic> srcJson) => _$SpecsListFromJson(srcJson);

}

  
