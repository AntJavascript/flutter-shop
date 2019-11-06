import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_app/model/user_address.dart';

// 获取收货地址
Future getUserAddress() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['AddressList'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().post("$url", options: options);
    print(response.data);
    return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class MapListPage extends StatefulWidget {
  const MapListPage();
  @override
  MapListPageState createState() => MapListPageState();
}

class MapListPageState extends State<MapListPage> {
  MapListPageState();

  // 个人收货地址列表
  List<UserAddressData> addressList = [];

  @override
  void initState() {
    super.initState();

    UserAddress userAddressData; // 收货地址数据

    getUserAddress().then((data) {
      try {
        userAddressData = UserAddress.fromJson(data);
      } catch (err) {
        print(err);
      }
      this.setState(() {
        addressList = userAddressData.data;
      });
    });
  }

  listUI() {
    List<Widget> itemList = [];
    addressList.map((item) {
      itemList.add(
        Dismissible(
          direction: DismissDirection.endToStart,
          key: new Key(item.id.toString()),
          secondaryBackground: Container(
            color: Colors.red,
            padding: EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete,color: Colors.white,),
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
                  child: AlertDialog(
                    title: Text('提示'),
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
                  ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[100]))),
            padding:
                EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            item.consignee,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Container(
                            width: 30.0,
                          ),
                          Text(item.phone,
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.grey)),
                          item.isDefault == 1
                              ? Container(
                                  margin: EdgeInsets.only(left: 3.0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  padding: EdgeInsets.all(2.0),
                                  child: Text('默认',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.white)),
                                )
                              : Container()
                        ],
                      ),
                      Container(
                        height: 10.0,
                      ),
                      Text(item.province + item.city + item.area + item.detail,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey))
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Application.router.navigateTo(context, "/editMap/${item.id}");
                  },
                  child: Icon(Icons.edit),
                )
              ],
            ),
          ),
        ),
      );
    }).toList();
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              '收货地址',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      Application.router
                          .navigateTo(context, "/addMap")
                          .then((onValue) {
                        UserAddress userAddressData; // 收货地址数据
                        getUserAddress().then((data) {
                          try {
                            userAddressData = UserAddress.fromJson(data);
                          } catch (err) {
                            print(err);
                          }
                          this.setState(() {
                            addressList = userAddressData.data;
                          });
                        });
                      });
                    },
                    child: Text(
                      '新增地址',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(listUI())))
        ]));
  }
}
