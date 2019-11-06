import 'package:json_annotation/json_annotation.dart'; 
  
part 'article_list.g.dart';


@JsonSerializable()
  class ArticleList extends Object with _$ArticleListSerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<ArticleListData> data;

  @JsonKey(name: 'total')
  int total;

  ArticleList(this.code,this.data,this.total,);

  factory ArticleList.fromJson(Map<String, dynamic> srcJson) => _$ArticleListFromJson(srcJson);

}

  
@JsonSerializable()
  class ArticleListData extends Object with _$ArticleListDataSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'Title')
  String title;

  @JsonKey(name: 'Desc')
  String desc;

  @JsonKey(name: 'Content')
  String content;

  @JsonKey(name: 'CreateTime')
  String createTime;

  @JsonKey(name: 'ProductId')
  int productId;

  @JsonKey(name: 'ViewCount')
  int viewCount;

  ArticleListData(this.id,this.title,this.desc,this.content,this.createTime,this.productId,this.viewCount,);

  factory ArticleListData.fromJson(Map<String, dynamic> srcJson) => _$ArticleListDataFromJson(srcJson);

}

  
