import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../model/order_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:native_app/model/add_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 获取订单列表
Future getOrderList(int page, int limit, int type) async {
  print('当前页码：' +
      page.toString() +
      'limit：' +
      limit.toString() +
      'type：' +
      type.toString());
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['UserOrderList'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().get("$url",
        options: options,
        queryParameters: {'page': page, 'limit': limit, 'type': type});
    print(response.data);
    return response.data;
  } catch (e) {
    print(e);
  }
}

// 订单状态
String orderStatus(int status) {
  if (status == 1) {
    return '待付款';
  } else if (status == 2) {
    return '待发货';
  } else if (status == 3) {
    return '配送中';
  } else if (status == 4) {
    return '待收货';
  } else if (status == 5) {
    return '待评价';
  } else if (status == 6) {
    return '已完成';
  } else if (status == 7) {
    return '已取消';
  }
}

// 订单列表布局
Widget orderListUI(OrderListData order, BuildContext context) {
  List<Widget> child = [];
  for (var i = 0; i < order.productList.length; i++) {
    var item = order.productList[i];
    child.add(Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          InkWell(
              onTap: () {
                Application.router
                    .navigateTo(context, "/orderDetail/${order.order.id}");
              },
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: item.thumbnail,
                    width: 100.0,
                    height: 100.0,
                    placeholder: (context, url) => new Icon(
                      Icons.image,
                      color: Colors.grey[300],
                      size: 100.0,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Icons.image,
                      color: Colors.grey[300],
                      size: 100.0,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            order.productSpecsList[i].id > 0
                                ? order.productSpecsList[i].specs
                                : '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                order.productSpecsList[i].id > 0
                                    ? '￥${order.productSpecsList[i].productPrice}'
                                    : '￥${order.productList[i].price.toString()}',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 22.0),
                              ),
                              Text(
                                order.cartList[i].cartNumber > 0
                                    ? 'x${order.cartList[i].cartNumber}'
                                    : '',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              order.order.orderStatus == 1 || order.order.orderStatus == 2
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.grey[400]),
                        ),
                        child: Center(
                          child: Text('取消订单'),
                        ),
                      ),
                    )
                  : Container(),
              order.order.orderStatus == 1
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Center(
                          child: Text(
                            '继续支付',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              order.order.orderStatus == 3
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Center(
                          child: Text('确认收货',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  : Container(),
              order.order.orderStatus == 5
                  ? InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      onTap: () {},
                      child: Container(
                        height: 36.0,
                        width: 82.0,
                        margin: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.grey[400]),
                        ),
                        child: Center(
                          child: Text('去评价'),
                        ),
                      ),
                    )
                  : Container()
            ],
          )
        ],
      ),
    ));
  }
  Widget list = Column(children: child);

  return list;
}

/// 质感设计样式
class OrderPage extends StatefulWidget {
  final int orderType;

  const OrderPage(this.orderType);

  @override
  OrderPageState createState() => OrderPageState(orderType);
}

class OrderPageState extends State<OrderPage> {
  OrderPageState(this.orderType);

  TabController _controller;
  // 是否正在加载
  bool loading = false;
  // 条数
  int total = 0;
  // 当前页数
  int page = 1;
  // 订单类型
  final int orderType;
  // 每次获取条数
  int limit = 10;
  // 当前tab
  int currentPage = 0;
  // 订单列表
  List<OrderListData> orderList = <OrderListData>[];

  final List<Map<String, dynamic>> _tabValues = [
    {'title': '全部','route': '0'},
    {'title': '待付款','route': '1'},
    {'title': '待发货','route': '2'},
    {'title': '待收货','route': '3'},
    {'title': '待评价','route': '4'},
  ];

  @override
  void initState() {
    super.initState();
    // 设置当前tab
    this.setState((){
      currentPage = orderType;
    });
    _controller = TabController(
      length: _tabValues.length,
      initialIndex: this.orderType,
      vsync: ScrollableState(),
    );
    // tab切换回调
    _controller.addListener(() {
      print('当前索引' + _controller.index.toString());
      OrderList resultData;
      this.setState(() {
          orderList = [];
          total = 0;
        });
      getOrderList(1, this.limit, _controller.index).then((data) {
        try {
          resultData = OrderList.fromJson(data);
        } catch (err) {
          print("加载解析错误");
          Common addCart = Common.fromJson(data);
          showDialog(
              context: context,
              child: AlertDialog(
                title: Text('提示'),
                content: Text(addCart.msg == null ? '' : addCart.msg),
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
          print(err);
          return;
        }
        this.setState(() {
          currentPage = _controller.index;
          orderList = resultData.data;
          total = resultData.data.length;
          page = 1;
        });
      });
    });

    OrderList resultData;
    // 获取列表
    getOrderList(this.page, this.limit, this.orderType).then((data) {
      try {
        resultData = OrderList.fromJson(data);
        loading = true;
      } catch (err) {
        print("解析错误");
        loading = false;
        Common addCart = Common.fromJson(data);
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text('提示'),
              content: Text(addCart.msg == null ? '' : addCart.msg),
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
        print(err);
        return;
      }
      this.setState(() {
        orderList = resultData.data;
        loading = loading;
        total = resultData.data.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '订单管理',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            tabs: _tabValues.map((item) {
              return Text(
                item['title'],
                style: TextStyle(fontSize: 18.0),
              );
            }).toList(),
            controller: _controller,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[200],
            indicatorWeight: 2.0,
            indicatorPadding: EdgeInsets.only(
              top: 5.0,
            ),
            labelStyle: TextStyle(height: 4.0),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: _tabValues.map((item) {
            return currentPage == int.parse(item['route']) ? EasyRefresh.custom(
              header: MaterialHeader(),
              footer: MaterialFooter(),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2), () {
                  setState(() {
                    total = this.limit;
                  });
                });
              },
              onLoad: () async {
                OrderList resultData;
                int currentPage = this.page + 1;
                print('this.page' + this.page.toString());
                print('当前加载页码' + currentPage.toString());
                getOrderList(currentPage, this.limit, this.orderType)
                    .then((data) {
                  try {
                    resultData = OrderList.fromJson(data);
                  } catch (err) {
                    print("加载解析错误");
                    Common addCart = Common.fromJson(data);
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('提示'),
                          content: Text(addCart.msg == null ? '' : addCart.msg),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('确定'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Application.router
                                    .navigateTo(context, "/login");
                              },
                            ),
                          ],
                        ));
                    print(err);
                    return;
                  }
                  this.orderList.addAll(resultData.data);
                  this.setState(() {
                    orderList = this.orderList;
                    total = total + resultData.data.length;
                    page = currentPage;
                  });
                });
              },
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '订单号：${orderList[index].order.orderId}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      orderStatus(
                                          orderList[index].order.orderStatus),
                                      style: TextStyle(
                                          color: Colors.orange[600],
                                          fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                              orderListUI(orderList[index], context),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: total,
                  ),
                ),
              ],
            ): Center(
              child: SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(),
              ),
            );
          }).toList(),
        ));
  }
}
