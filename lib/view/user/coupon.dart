import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';
import 'package:native_app/model/add_cart.dart';
import 'package:native_app/model/user_coupon.dart';

import 'package:shared_preferences/shared_preferences.dart';

// 获取优惠券列表
Future getUserCouponList() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['UserCouponList'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().post("$url", options: options);
    return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class CouponPage extends StatefulWidget {
  const CouponPage();
  @override
  CouponPageState createState() => CouponPageState();
}

class CouponPageState extends State<CouponPage> {
  CouponPageState();

  // 是否正在加载
  bool loading = false;

  // 列表
  List<UserList> list = [];

  // 当前显示类型
  int type = 1;

  // 状态类型集合
  List<Map<String, dynamic>> typeList = [
    {"type": 1, "text": "全部"},
    {"type": 2, "text": "生效中"},
    {"type": 3, "text": "已使用"},
    {"type": 4, "text": "已失效"}
  ];

  @override
  void initState() {
    super.initState();

    UserCoupon resultData;

    getUserCouponList().then((data) {
      print('请求数据');
      try {
        resultData = UserCoupon.fromJson(data);
        print(resultData.userList[0].title);
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
        return;
      }
      this.setState(() {
        list = resultData.userList;
        loading = loading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: typeList.map((item) {
                return Expanded(
                  child: InkWell(
                    onTap: () {
                      this.setState((){
                        type = item['type'];
                      });
                    },
                    child: Container(
                      height: 20,
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey[350],width: item['type'] == 4 ? 0.0 : 0.5)
                        )
                      ),
                      child: Text(
                        item['text'],
                        style: TextStyle(fontSize: 16.0,color: item['type'] == this.type ? Theme.of(context).primaryColor : Colors.grey),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        title: Text(
          "优惠券",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          color: Colors.grey[100],
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '￥',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18.0),
                            ),
                            Text(
                              list[index].price.toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 42.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    list[index].title,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  // Expanded(
                                  //   child: Container(),
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Text(list[index].desc,
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Text(
                                '有效期至:${list[index].endTime}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
