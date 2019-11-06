import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';
import 'package:native_app/model/add_cart.dart';
import 'package:native_app/model/order_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:shared_preferences/shared_preferences.dart';

// 获取订单详情
Future getOrderDetail(String id) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['GetUserOrderDetail'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().get("$url/$id", options: options);
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

/// 质感设计样式
class OrderDetailPage extends StatefulWidget {
  final String id;
  const OrderDetailPage(this.id);

  @override
  OrderDetailPageState createState() => OrderDetailPageState(id);
}

class OrderDetailPageState extends State<OrderDetailPage> {
  OrderDetailPageState(this.id);

  // 商品id
  final String id;

  // 订单数据
  OrderDetail orderDetail = null;

  // 是否正在加载
  bool loading = false;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    OrderDetail resultData;
    getOrderDetail(this.id).then((data) {
      try {
        resultData = OrderDetail.fromJson(data);
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
      print(resultData);
      setState(() {
        orderDetail = resultData;
        loading = loading;
      });
    });
  }

  // 订单列表布局
  Widget orderListUI(OrderDetailData order, BuildContext context) {
    List<Widget> child = [];
    for (var i = 0; i < order.productList.length; i++) {
      var item = order.productList[i];
      child.add(Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            InkWell(
                onTap: () {},
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
                            Container(
                              margin: EdgeInsets.only(
                                top: 5.0,
                                bottom: 5.0
                              ),
                              child: Text(
                              order.productSpecsList[i].id > 0
                                  ? order.productSpecsList[i].specs
                                  : '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 14.0),
                            ),
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
          ],
        ),
      ));
    }
    Widget list = Column(children: child);

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            title: Text(
              '订单详情',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                loading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              height: 60.0,
                              color: Theme.of(context).primaryColor,
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Icon(Icons.credit_card),
                                  Text(
                                    orderStatus(
                                        orderDetail.data.order.orderStatus),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22.0),
                                  )
                                ],
                              )),
                          Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    '收货人：${orderDetail.data.order.name}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    '联系电话：${orderDetail.data.order.phone}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    '收货地址：${orderDetail.data.order.address}',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text('留言：'),
                                Text(orderDetail.data.order.remarks),
                              ],
                            ),
                          ),
                          Container(
                            height: 10.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              '订单号：${orderDetail.data.order.orderId}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          orderListUI(orderDetail.data, context),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '商品总额',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '￥${orderDetail.data.order.totalPrice.toString()}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '配送费',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '￥${orderDetail.data.order.freightAmount.toString()}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '优惠券',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '￥${orderDetail.data.order.couponAmount.toString()}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '实付款：',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '￥${orderDetail.data.order.realPayAmount.toString()}',
                                        style: TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '下单时间：',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                          '${orderDetail.data.order.createTime}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : Container(
                        child: Center(
                          child: Text('数据加载中'),
                        ),
                      )
              ])))
        ]),
        bottomNavigationBar: orderDetail != null ? Container(
          height: 45.0,
          padding: EdgeInsets.only(
            right: 10.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
             orderDetail.data.order.orderStatus == 1 || orderDetail.data.order.orderStatus == 2? InkWell(
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
              ): Container(),
              orderDetail.data.order.orderStatus == 1?
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 82.0,
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Text(
                      '继续支付',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ): Container(),
              orderDetail.data.order.orderStatus == 3?
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                onTap: () {},
                child: Container(
                  height: 36.0,
                  width: 82.0,
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Text('确认收货', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ): Container(),
              orderDetail.data.order.orderStatus == 5?
              InkWell(
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
              ): Container()
            ],
          ),
        ):Container(),
        );
  }
}
