import 'dart:async';
import 'dart:core';
import 'dart:core' as prefix0;
import 'package:native_app/view/find/list.dart';
import 'package:native_app/view/home/index.dart';
import 'package:native_app/view/user/cart.dart';
import 'package:native_app/view/classify/index.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';
import '../../components/NavBottomItems.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_app/model/user_ifo.dart';
import 'package:native_app/model/add_cart.dart';
import '../../components/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 获取用户信息
Future getUserInfo() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['GetUserInfo'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().get("$url", options: options);
    return response.data;
  } catch (e) {
    print(e);
  }
}

// 常用功能model
class ToolsList {
  String title;
  IconData icon;
  String route;
  Color color;

  ToolsList({this.title, this.icon, this.route, this.color});
}

// 订单类型model
class OrderModel {
  IconData icon;
  String title;
  String route;

  OrderModel({this.title, this.icon, this.route});
}

/// 质感设计样式
class UserPage extends StatefulWidget {
  const UserPage();
  @override
  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> with AutomaticKeepAliveClientMixin<UserPage> {
  @override
  bool get wantKeepAlive => true;
  UserPageState();

  UserIfo userIfo = null;

  bool isLoading = false;

  int _selectedIndex = 4;

  // 常用功能列表
  List<ToolsList> tools = [
    new ToolsList(
        icon: Icons.people,
        title: '好友列表',
        route: 'friend',
        color: Colors.lightBlue),
    new ToolsList(
        icon: Icons.receipt,
        title: '优惠券',
        route: 'coupon',
        color: Colors.orange),
    new ToolsList(
        icon: Icons.room,
        title: '收货地址',
        route: 'userMapList',
        color: Colors.red),
    new ToolsList(
        icon: Icons.monetization_on,
        title: '优惠活动',
        route: 'discount',
        color: Colors.green),
    new ToolsList(
        icon: Icons.face,
        title: '意见反馈',
        route: 'feedback',
        color: Colors.redAccent),
    new ToolsList(
        icon: Icons.share,
        title: '分享APP',
        route: 'shareApp',
        color: Color.fromARGB(255, 64, 207, 160)),
  ];

  // 订单类型
  List<OrderModel> orderModelList = [
    new OrderModel(icon: Icons.credit_card, title: '待付款', route: '1'),
    new OrderModel(
        icon: Icons.account_balance_wallet, title: '待发货', route: '2'),
    new OrderModel(icon: Icons.card_travel, title: '待收货', route: '3'),
    new OrderModel(icon: Icons.chat, title: '待评价', route: '4'),
    new OrderModel(icon: Icons.assignment, title: '全部订单', route: '0')
  ];

  @override
  void initState() {
    super.initState();
    UserIfo userInfoData;
    bool loading = false;

    getUserInfo().then((data) {
      try {
        userInfoData = UserIfo.fromJson(data);
        loading = true;
      } catch (err) {
        print("解析错误");
        loading = false;
        userInfoData = null;
      }
      print(data);
      this.setState(() {
        userIfo = userInfoData;
        isLoading = loading;
      });
    });
  }

  void _onItemTapped(int index) {
    if (index == 4) {
      return;
    }
    if (index == 3) {
      Application.router.navigateTo(context, "/cart");
      return;
    }
    this.setState(() {
      _selectedIndex = index;
    });
  }

  Widget UserIndexUI() {
    return CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            title: Text(
              '我的',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      Application.router.navigateTo(context, "/settings");
                    },
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(
                <Widget>[
                  Container(
                    height: 160.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/login_bg.png',
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  // height: 160.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30.0,
                          width: MediaQuery.of(context).size.width,
                          height: 110.0,
                          child: Column(
                            children: this.isLoading
                                ? <Widget>[
                                    Container(
                                      width: 60.0,
                                      height: 60.0,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(60.0),
                                        child: CachedNetworkImage(
                                          imageUrl: userIfo.data.face,
                                          width: 60.0,
                                          height: 60.0,
                                          placeholder: (context, url) =>
                                              new Icon(
                                            Icons.image,
                                            color: Colors.grey[300],
                                            size: 60.0,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              new Icon(
                                            Icons.image,
                                            color: Colors.grey[300],
                                            size: 60.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 15.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          userIfo.data.userName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 14.0,
                                        )
                                      ],
                                    ),
                                  ]
                                : <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 30.0,
                                          right: 30.0,
                                          top: 15.0,
                                          bottom: 15.0),
                                      child: InkWell(
                                        onTap: () {
                                          Application.router
                                              .navigateTo(context, "/login");
                                        },
                                        child: Text(
                                          '去登录',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0))),
                                    )
                                  ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: 60.0, right: 60.0, top: 20.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '余额',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('5',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Color.fromARGB(255, 255, 144, 0)))
                        ],
                      ),
                      Container(
                        width: 1.0,
                        color: Colors.grey[300],
                        height: 30.0,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '优惠券',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text('2',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Color.fromARGB(255, 255, 144, 0)))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                )
              ]))),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                Container(
                  child: Text('我的订单'),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: orderModelList.map((item) {
                      return InkWell(
                        onTap: () {
                          Application.router
                              .navigateTo(context, "/order/${item.route}");
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(item.icon),
                            Container(
                              height: 8.0,
                            ),
                            Text(item.title)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                ),
                Container(
                  child: Text('常用功能'),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 8.0),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[300]))),
                ),
              ]))),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1.3,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Ink(
                child: InkWell(
                  onTap: () {
                    Application.router
                        .navigateTo(context, "/${tools[index].route}");
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          tools[index].icon,
                          size: 30.0,
                          color: tools[index].color,
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Text(tools[index].title)
                      ],
                    ),
                  ),
                ),
              );
            }, childCount: tools.length),
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserIndexUI(),
    );
  }
}
