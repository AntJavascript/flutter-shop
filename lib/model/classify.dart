import 'package:json_annotation/json_annotation.dart'; 
  
part 'classify.g.dart';


@JsonSerializable()
  class Classify extends Object with _$ClassifySerializerMixin{

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'data')
  List<ClassifyData> data;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'total')
  int total;

  Classify(this.code,this.data,this.msg,this.total,);

  factory Classify.fromJson(Map<String, dynamic> srcJson) => _$ClassifyFromJson(srcJson);

}

  
@JsonSerializable()
  class ClassifyData extends Object with _$ClassifyDataSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ClassifyName')
  String classifyName;

  @JsonKey(name: 'ParentId')
  int parentId;

  @JsonKey(name: 'Img')
  String img;

  @JsonKey(name: 'Children')
  List<Children> children;

  ClassifyData(this.id,this.classifyName,this.parentId,this.img,this.children,);

  factory ClassifyData.fromJson(Map<String, dynamic> srcJson) => _$ClassifyDataFromJson(srcJson);

}

  
@JsonSerializable()
  class Children extends Object with _$ChildrenSerializerMixin{

  @JsonKey(name: 'Id')
  int id;

  @JsonKey(name: 'ClassifyName')
  String classifyName;

  @JsonKey(name: 'ParentId')
  int parentId;

  @JsonKey(name: 'Img')
  String img;

  Children(this.id,this.classifyName,this.parentId,this.img,);

  factory Children.fromJson(Map<String, dynamic> srcJson) => _$ChildrenFromJson(srcJson);

}