import 'dart:async';
import 'dart:core';
import 'package:native_app/view/classify/index.dart';
import 'package:native_app/view/home/index.dart';
import 'package:native_app/view/user/cart.dart';
import 'package:native_app/view/user/index.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import '../../config/web.config.dart';
import 'package:native_app/model/article_list.dart';
import '../../router/application.dart';
import '../../components/NavBottomItems.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 获取商品列表
Future getList() async {
  try {
    var url = webApi['ArticleList'];
    Response response = await Dio().get("$url?page=1&limit=10");
    return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class FindPage extends StatefulWidget {
  const FindPage();
  @override
  FindPageState createState() => FindPageState();
}

class FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin<FindPage> {

  @override
  bool get wantKeepAlive => true;

  // 默认显示条数
  int _count = 0;
  List<ArticleListData> list = <ArticleListData>[]; // 列表

  FindPageState();


  @override
  void initState() {
    // 获取商品列表数据
    getList().then((data) {
      ArticleList product = ArticleList.fromJson(data);
      List<ArticleListData> showData = <ArticleListData>[];
      product.data.forEach((v) => {showData.add(v)});
      setState(() {
        list = showData;
        _count = product.total;
      });
    });
    super.initState();
  }

  Widget FindPageUI() {
    return EasyRefresh.custom(
        header: MaterialHeader(),
        footer: MaterialFooter(),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {
              // _count = 20;
            });
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {
              // _count += 20;
            });
          });
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (list.length > 0) {
                  var id = list[index].id;
                  return InkWell(
                      onTap: () {
                        Application.router
                            .navigateTo(context, "/findDetail/$id");
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Container(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://ss0.bdstatic.com/k4oZeXSm1A5BphGlnYG/skin/207.jpg?2',
                                        placeholder: (context, url) => new Icon(
                                          Icons.image,
                                          color: Colors.grey[300],
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.image,
                                          color: Colors.grey[300],
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8.0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          36,
                                      margin: EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Text(
                                        list[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(8.0),
                                child: Text(
                                  list[index].desc,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                }
              },
              childCount: _count,
            ),
          ),
        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          '发现',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FindPageUI(),
    );
  }
}
