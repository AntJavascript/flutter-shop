import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../config/web.config.dart';
import 'dart:async';
import 'dart:core';
import 'package:native_app/model/detail.dart';
import 'package:native_app/model/comment.dart';
import 'package:native_app/model/add_cart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../router/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 获取商品详情
Future getProductDetail(id) async {
  try {
    var url = webApi['detail'] + '/' + id;
    Response response = await Dio().get("$url");
    return response.data;
  } catch (e) {
    print(e);
  }
}

// 获取商品评论
Future getProductComment(id) async {
  try {
    var url = webApi['comment'] + '/' + id;
    Response response = await Dio().get("$url");
    return response.data;
  } catch (e) {
    print(e);
  }
}


class ProductDetail extends StatefulWidget {
  final dynamic id;

  ProductDetail(this.id);

  _ProductDetailState createState() => _ProductDetailState(id);
}

class _ProductDetailState extends State<ProductDetail> {
  // 是否正在请求
  bool loading = false;
  // 详情数据
  Detail detail;
  // 评论列表
  List<CommentData> productComment = [];
  // 商品id
  final dynamic id;
  // 轮播图
  List<String> album = [];
  //购买数量
  int quantity = 1;
  // 属性类型数量
  int specs = 0;
  // 选择的属性数值
  List<String> selectAttr = [];

  _ProductDetailState(this.id);

  @override
  void initState() {
    // 获取详情
    getProductDetail(this.id).then((data) {
      Detail productDetail = Detail.fromJson(data);

      List<String> list = [];
      productDetail.data.specsList.map((key) {
        list.add('');
      }).toList();

      setState(() {
        detail = productDetail;
        loading = true;
        album = productDetail.data.album.split(',');
        specs = productDetail.data.specsList.length;
        selectAttr = list;
      });
    });
    // 获取评论
    getProductComment(this.id).then((data) {
      Comment productCommentData = Comment.fromJson(data);

      List<CommentData> commentList = [];
      productCommentData.data.map((item) {
        commentList.add(item);
      }).toList();

      setState(() {
        productComment = commentList;
      });
    });

    super.initState();
  }
  // 显示价格
  String showPrice(){
    var rule = this.selectAttr.join(',');
    String str = '';
    this.detail.attrList.map((item){
      if(item.specs == rule){
        str = item.productPrice.toString();
      }
    }).toList();
    if(str == ''){
      return detail.data.price.toString();
    } else{
      return str;
    }
  }

  // 加入购物车
void addCart(attr, cartNumber, id, context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String
    token = prefs.getString('token');
    print('token数据:');
    print(token);
    var url = webApi['addCart'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().post("$url",
        data: {
          'Attr': attr,
          'CartNumber': cartNumber,
          'ProductId': int.parse(id)
        },
        options: options);
    Common addCart = Common.fromJson(response.data);
    if (addCart.code == 401) {
      showDialog(
          context: context,
          child: AlertDialog(
            title: Text('提示'),
            content: Text(addCart.msg),
            actions: <Widget>[
              new FlatButton(
                child: new Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Application.router.navigateTo(context, "/login");
                },
              ),
            ],
          ));
    } else {}
  } catch (e) {
    print(e);
  }
}

  // 规则组合
  Widget newSpecsList(SpecsList data, int index) {
    List<Widget> widets = [];
    // 属性名称
    widets.add(Container(
      margin: EdgeInsets.only(left: 8.0),
      child: Text(data.name),
    ));
    int subIndex = 0;

    List<Widget> wrap = [];
    data.checkedCities.map((item) {
      subIndex += 1;
      wrap.add(checkedCities(index, subIndex, item));
    }).toList();
    widets.add(Wrap(children: wrap));
    // 分割线
    widets.add(Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.grey[100]))),
    ));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widets,
    );
  }

  //
  Widget checkedCities(index, subIndex, String data) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 15.0, right: 7.0, top: 5.0, bottom: 5.0),
        padding:
            EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
            color: selectAttr[index - 1] == data
                ? Theme.of(context).primaryColor
                : Colors.grey[100]),
        child: Text(data,
            style: TextStyle(
                color: selectAttr[index - 1] == data
                    ? Colors.white
                    : Colors.black)),
      ),
      onTap: () {
        this.setState(() {
          selectAttr[index - 1] =
              detail.data.specsList[index - 1].checkedCities[subIndex - 1];
        });
        print('选择的规格：' + this.selectAttr.join(''));
      },
    );
  }

  // 功能函数
  fun() {
    var index = 0;
    return Column(
        children: detail.data.specsList.map((f) {
      index += 1;
      return newSpecsList(f, index);
    }).toList());
  }

  // 评论布局
  Widget commentUI(List<CommentData> data) {
    List<Widget> widets = [];
    data.map((item) {
      List<Widget> stars = [];
      List<Widget> starsIcon = [];
      stars.add(Text(
        item.userInfo.phone,
        style: TextStyle(fontSize: 16.0),
      ));
      for (var i = 0; i < item.star; i++) {
        starsIcon.add(Icon(
          Icons.star,
          color: Colors.red,
          size: 18.0,
        ));
      }
      stars.add(Row(
        children: starsIcon,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      ));

      widets.add(Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.network(
                    item.userInfo.face,
                    width: 45,
                    height: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: stars,
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 45.0, top: 10.0),
            child: Text(item.comment, style: TextStyle(fontSize: 16.0)),
          )
        ],
      ));
    }).toList();
    if (this.productComment.length > 3) {
      widets.add(Center(
        child: Material(
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            onTap: () {},
            child: Container(
              height: 36.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                border: Border.all(color: Colors.grey[400]),
              ),
              child: Center(
                child: Text('查看全部评论'),
              ),
            ),
          ),
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    elevation: 0.0,
                    title: Text(
                      loading ? detail.data.title : '商品详情',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // 商品图片轮播
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: new SliverList(
                        delegate: new SliverChildListDelegate(<Widget>[
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width - 100.0,
                        child: loading
                            ? new Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return new Image.network(
                                    album[index],
                                    fit: BoxFit.fitWidth,
                                  );
                                },
                                itemCount: album.length,
                                pagination: new SwiperPagination(
                                    builder: DotSwiperPaginationBuilder(
                                        size: 6.0,
                                        activeSize: 6.0,
                                        color: Colors.grey)),
                                autoplay: true,
                              )
                            : Container(),
                      ),
                    ])),
                  ),
                  // 标题、价格、销量、产地等信息
                  SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: new SliverList(
                          delegate: new SliverChildListDelegate(<Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("￥",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20)),
                                  Text(showPrice(),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 32)),
                                  Text("￥" + detail.data.orignPrice.toString(),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ],
                              ),
                              Container(
                                child: Text(detail.data.title,
                                    style: TextStyle(fontSize: 18.0)),
                                margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              ),
                              Container(
                                child: Text(detail.data.productDesc,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.grey)),
                                margin: EdgeInsets.only(bottom: 8.0),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("产地：" + detail.data.placeOrigin,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16.0)),
                                  Text("快递：" + detail.data.freight.toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16.0)),
                                  Text(
                                      "销量：" +
                                          detail.data.salesVolume.toString(),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16.0)),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 10.0,
                        )
                      ]))),
                  // 产品规格
                  SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: new SliverList(
                          delegate: new SliverChildListDelegate(<Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "规格选择",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Container(
                                height: 10.0,
                              ),
                              fun()
                            ],
                          ),
                        ),
                        Container(
                          height: 10.0,
                        )
                      ]))),
                  SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: new SliverList(
                          delegate: new SliverChildListDelegate(<Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 5.0, left: 8.0, right: 8.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "购买数量",
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Material(
                                      child: InkWell(
                                        onTap: () {
                                          this.setState(() {
                                            quantity = this.quantity += 1;
                                          });
                                        },
                                        splashColor:
                                            Colors.grey.withOpacity(0.3),
                                        highlightColor:
                                            Colors.grey.withOpacity(0.1),
                                        child: Container(
                                            child: Icon(
                                              Icons.add,
                                              size: 14.0,
                                            ),
                                            height: 32.0,
                                            width: 32.0),
                                      ),
                                    ),
                                    Container(
                                      width: 50.0,
                                      child: Text(
                                        this.quantity.toString(),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Material(
                                      child: InkWell(
                                        onTap: () {
                                          if (this.quantity > 1) {
                                            this.setState(() {
                                              quantity = this.quantity -= 1;
                                            });
                                          }
                                        },
                                        child: Container(
                                            child: Icon(
                                              Icons.remove,
                                              size: 14.0,
                                            ),
                                            height: 32.0,
                                            width: 32.0),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 10.0,
                        )
                      ]))),
                  SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: new SliverList(
                          delegate: new SliverChildListDelegate(<Widget>[
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '用户评论',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              this.productComment.length > 0
                                  ? Text(
                                      '${this.productComment.length}条评价',
                                      style: TextStyle(fontSize: 16.0),
                                    )
                                  : Text(
                                      '0条评价',
                                      style: TextStyle(fontSize: 16.0),
                                    )
                            ],
                          ),
                          padding: EdgeInsets.all(8.0),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.white,
                          child: this.productComment.length > 0
                              ? commentUI(this.productComment)
                              : Text(''),
                        ),
                        Container(
                          height: 10.0,
                        )
                      ]))),
                  SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: new SliverList(
                          delegate: new SliverChildListDelegate(<Widget>[
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0,
                                    height: 12.0,
                                    margin:
                                        EdgeInsets.only(right: 5.0, top: 3.0),
                                  ),
                                  Text(
                                    '商品详情',
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                ],
                              ),
                              Container(
                                child: Html(data: this.detail.data.detail),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(8.0),
                        ),
                        Container(
                          height: 10.0,
                        )
                      ])))
                ],
              )
            : Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(),
              ),
            ),
        bottomNavigationBar: loading? Container(
          height: 44.0,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: <Widget>[
              Center(
                  child: Container(
                child: InkWell(
                  child: Icon(Icons.shopping_cart),
                  onTap: (){
                    Application.router.navigateTo(context, "/cart");
                  },
                ),
                width: 94.0,
              )),
              Expanded(
                  child: Material(
                child: InkWell(
                  onTap: () {
                    addCart(0, this.quantity, this.id, context);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: Center(
                      child: Text('加入购物车',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ):Container(
          height: 0.0,
        ));
  }
}
