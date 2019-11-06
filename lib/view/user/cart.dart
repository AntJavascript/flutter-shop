import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_app/model/cart.dart';
import 'package:native_app/model/add_cart.dart';
import 'package:cached_network_image/cached_network_image.dart';

// 获取购物车列表
Future getCartList() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['cart'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().get("$url", options: options);
    return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class CartPage extends StatefulWidget {
  const CartPage();
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  CartPageState();

  // 是否正在请求
  bool loading = false;
  // 购物车列表
  List<CartData> list = [];
  // 合计
  double total = 0.0;

  // 是否正在编辑
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    Cart cartData;
    // 获取数据
    getCartList().then((data) {
      print(data);
      try {
        cartData = Cart.fromJson(data);
      } catch (err) {
        print("解析错误");
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
      }
      double totals = 0;
      cartData.data
          .map((item) => {
                if (item.cart.status == 1)
                  {
                    if (item.attrList.id == 0)
                      {
                        totals += double.parse(item.productPrice.toString()) *
                            item.cart.cartNumber,
                      }
                    else
                      {
                        totals += double.parse(
                                item.attrList.productPrice.toString()) *
                            item.cart.cartNumber,
                      }
                  }
              })
          .toList();
      setState(() {
        total = totals;
        loading = true;
        list = cartData.data;
      });
    });
  }

// 修改购物车状态
  Future checkStatus(item, status) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      var url = webApi['CartStatus'];
      Map<String, dynamic> headers = new Map();
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);
      Response response = await Dio().post("$url",
          data: {'CartId': item.cart.id, 'IsCheck': status}, options: options);
      item.cart.status = status;
      double totals = 0;
      if (item.attrList.id == 0) {
        totals +=
            double.parse(item.productPrice.toString()) * item.cart.cartNumber;
      } else {
        totals += double.parse(item.attrList.productPrice.toString()) *
            item.cart.cartNumber;
      }
      if (status == 1) {
        total += totals;
      } else {
        total -= totals;
      }
      this.setState(() {
        list = list;
        total = total;
      });
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // 是否还有库存
  bool isStock(item) {
    var flag = true;
    if (item.attrList.id == 0) {
      flag = item.productStock > 0;
    } else {
      flag = int.parse(item.attrList.productStock) > 0;
    }
    return flag;
  }

  // 显示的价格
  String showPrice(CartData item) {
    var price = '';
    if (item.attrList.id == 0) {
      price = item.productPrice.toString();
    } else {
      price = item.attrList.productPrice;
    }
    return price;
  }

  listUI() {
    List<Widget> itemList = [];
    if (loading) {
      list.map((item) {
        itemList.add(
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            margin: EdgeInsets.only(bottom: 20.0, right: 8.0),
            child: Dismissible(
              direction: DismissDirection.endToStart,
              key: new Key(item.cart.id.toString()),
              secondaryBackground: Container(
                color: Colors.red,
                padding: EdgeInsets.only(right: 20.0),
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.green,
                child: Icon(Icons.delete),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示${item.cart.id.toString()}'),
                          content: Text("确定删除？"),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text('取消'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            new FlatButton(
                              child: new Text('确定'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                }
              },
              child: Row(
                children: <Widget>[
                  isStock(item)
                      ? Stack(
                          children: <Widget>[
                            Container(
                                alignment: Alignment.center,
                                child: item.cart.status == 1
                                    ? Icon(
                                        Icons.check,
                                        size: 18.0,
                                        color: Colors.white,
                                      )
                                    : Container(),
                                margin: EdgeInsets.only(left: 10.0),
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                    color: item.cart.status == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                        color: item.cart.status == 1
                                            ? Theme.of(context).primaryColor
                                            : Colors.grey[350]),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0)))),
                            Opacity(
                              opacity: 0,
                              child: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                value: item.cart.status == 1 ? true : false,
                                onChanged: (bool value) {
                                  checkStatus(item, value ? 1 : 0);
                                },
                              ),
                            )
                          ],
                        )
                      : Container(
                          width: 40.0,
                        ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          child: CachedNetworkImage(
                            width: 100.0,
                            height: 100.0,
                            imageUrl: item.productImg,
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
                          width: 100.0,
                          height: 100.0,
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            margin: EdgeInsets.only(
                              left: 5.0
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(item.productTitle,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16.0)),
                                item.attrList.specs != ''
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0))),
                                        margin: EdgeInsets.only(
                                            top: 5.0, bottom: 5.0),
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                            top: 3.0,
                                            bottom: 3.0),
                                        child: Text(
                                          item.attrList.specs,
                                          style: TextStyle(
                                              color: Colors.grey[500]),
                                          maxLines: 2,
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "￥" + showPrice(item),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 22.0),
                                    ),
                                    isEdit
                                        ? Container(
                                            child: Row(
                                              children: <Widget>[
                                                Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      item.cart.cartNumber++;
                                                      this.setState(() {
                                                        list = this.list;
                                                      });
                                                    },
                                                    splashColor: Colors.grey
                                                        .withOpacity(0.3),
                                                    highlightColor: Colors.grey
                                                        .withOpacity(0.1),
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
                                                    item.cart.cartNumber
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Material(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (item.cart.cartNumber >
                                                          1) {
                                                        item.cart.cartNumber--;
                                                        this.setState(() {
                                                          list = this.list;
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
                                        : Text("x" +
                                            item.cart.cartNumber.toString(), style: TextStyle(fontSize: 14.0, color: Colors
                                            .grey),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }).toList();
    }
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 1.0,
            title: Text(
              '购物车',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      this.setState(() {
                        isEdit = !this.isEdit;
                      });
                    },
                    child: isEdit ? Text("完成") : Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(loading
                      ? listUI()
                      : <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: SizedBox(
                                width: 30.0,
                                height: 30.0,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        ])))
        ]),
        bottomNavigationBar: loading
            ? Container(
                height: 44.0,
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text('合计：'),
                          Text(
                            '￥${total.toStringAsFixed(2).toString()}',
                            style: TextStyle(color: Colors.red, fontSize: 22.0),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Application.router.navigateTo(context, "/confirmOrder");
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        margin: EdgeInsets.only(left: 15.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Text('去结算',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                height: 0.0,
              ));
  }
}
