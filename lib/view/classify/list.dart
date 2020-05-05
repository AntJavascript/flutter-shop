import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import '../../config/web.config.dart';
import 'package:native_app/model/product.dart';
import '../../router/application.dart';

// 获取商品列表
Future getProductList(id) async {
  try {
    var url = webApi['classifyIdFindListData'] + '/' + id;
    Response response = await Dio().get("$url?page=1&limit=10");
    return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class ProductListPage extends StatefulWidget {
  final dynamic name;
  const ProductListPage(this.name);
  @override
  ProductListPageState createState() => ProductListPageState(name);
}

class ProductListPageState extends State<ProductListPage> {
  final dynamic name;
  // 默认显示条数
  int _count = 0;
  String showName = '';
  String id = '';
  List<ProductData> productList = <ProductData>[]; // 商品列表

  ProductListPageState(this.name);

  @override
  void initState() {
    RegExp exp = new RegExp(r"([^\d]+)");
    Iterable<Match> matches = exp.allMatches(Uri.decodeComponent(this.name));

    for (Match m in matches) {
      this.setState(() => {showName = m.group(0)});
    }
    RegExp idexp = new RegExp(r"(\d+)");
    Iterable<Match> idmatches =
        idexp.allMatches(Uri.decodeComponent(this.name));

    for (Match m in idmatches) {
      this.id = m.group(0);
    }
    // 获取商品列表数据
    getProductList(this.id).then((data) {
      Product product = Product.fromJson(data);
      List<ProductData> showData = <ProductData>[];
      product.data.forEach((v) => {showData.add(v)});
      setState(() {
        productList = showData;
        _count = product.total;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.showName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            // setState(() {
            //   _count = 20;
            // });
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            // setState(() {
            //   _count += 20;
            // });
          });
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                print('productList数据');
                print(productList);
                if (productList.length > 0) {
                  var id = productList[index].id;
                  return InkWell(
                      onTap: () {
                        Application.router
                            .navigateTo(context, "/productDetail/$id");
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0, color: Colors.grey[100]))),
                        child: Row(children: <Widget>[
                          Container(
                            child: Image.network(productList[index].thumbnail,
                                width: 110.0, height: 110.0),
                            margin: EdgeInsets.all(5.0),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 125.0,
                            child: Column(children: <Widget>[
                              Text(productList[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 18.0)),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 8.0, right: 5.0, top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text("已售 " +
                                        productList[index]
                                            .salesVolume
                                            .toString()),
                                    Text(
                                      productList[index].placeOrigin,
                                      style: TextStyle(color: Colors.grey[400]),
                                    )
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        "￥" +
                                            productList[index].price.toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 18.0, color: Colors.red)),
                                    Text(
                                        "￥" +
                                            productList[index]
                                                .orignPrice
                                                .toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 14.0,
                                            color: Colors.grey))
                                  ],
                                ),
                              )
                            ], mainAxisAlignment: MainAxisAlignment.start),
                          )
                        ], mainAxisAlignment: MainAxisAlignment.start),
                      ));
                } else {
                  return Center(
                    child: Container(
                      width: 30.0,
                      height: 30.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
              },
              childCount: _count,
            ),
          ),
        ],
      ),
    );
  }
}
