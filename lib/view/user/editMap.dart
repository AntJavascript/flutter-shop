import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:native_app/model/add_cart.dart';
import 'package:native_app/model/address.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:native_app/model/user_address.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/loading.dart';

// 获取收货地址详情
Future getUserAddress(id) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var url = webApi['UserAddressDetail'];
    Map<String, dynamic> headers = new Map();
    headers['Cookie'] = token;
    Options options = new Options(headers: headers);
    Response response = await Dio().get("$url/$id", options: options);
    return response.data;
  } catch (e) {
    print(e);
  }
}

/// 质感设计样式
class EditMapPage extends StatefulWidget {
  final id;
  const EditMapPage(this.id);
  @override
  EditMapPageState createState() => EditMapPageState(id);
}

class EditMapPageState extends State<EditMapPage> {
  final id;
  EditMapPageState(this.id);

  bool isDefault = false; // 是否默认地址
  String province = ''; // 省
  String city = ''; // 市
  String area = ''; // 县
  bool loading = false;

  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController detailController;

  @override
  void initState() {
    super.initState();
    bool loading = false;
    Address addressDetail;
    getUserAddress(id).then((data) {
      print(data);
      try {
        addressDetail = Address.fromJson(data);
        loading = true;
      } catch (err) {}
      this.setState(() {
        loading = true;
        nameController =
            TextEditingController.fromValue(TextEditingValue(text: addressDetail.data.consignee));
        phoneController =
            TextEditingController.fromValue(TextEditingValue(text: addressDetail.data.phone));
        detailController =
            TextEditingController.fromValue(TextEditingValue(text: addressDetail.data.detail));
        province = addressDetail.data.province;
        city = addressDetail.data.city;
        area = addressDetail.data.area;
      });
    });
  }

  // 新增
  editAddress() async {
    if (nameController.text == '') {
      Fluttertoast.showToast(
          msg: "请输入姓名",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.black);
      return;
    }
    if (phoneController.text == '') {
      Fluttertoast.showToast(
          msg: "请输入手机号码",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.black);
      return;
    }
    if (detailController.text == '') {
      Fluttertoast.showToast(
          msg: "请输入详细地址",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.black);
      return;
    }
    if (province == '') {
      Fluttertoast.showToast(
          msg: "请选择地区",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.black);
      return;
    }
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      var url = webApi['AddUserAddress'];
      Map<String, dynamic> headers = new Map();
      headers['Cookie'] = token;
      Options options = new Options(headers: headers);

      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new LoadingDialog(
              //调用对话框
              text: '正在获取详情...',
            );
          });

      Response response = await Dio().post("$url", options: options, data: {
        'Area': area,
        'City': city,
        'Consignee': nameController.text,
        'Detail': detailController.text,
        'IsDefault': isDefault ? 1 : 0,
        'Phone': phoneController.text,
        'Province': province
      });
      print(response.data);
      Common resultData;
      try {
        resultData = Common.fromJson(response.data);
      } catch (err) {
        print(err);
      }
      print(resultData);
      if (resultData.code == 200) {
        Fluttertoast.showToast(
            msg: "新增成功",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.black);
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
            msg: "新增失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.black);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
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
              '修改收货地址',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100])))),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('收货人'),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            controller: nameController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: '输入姓名', border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('手机号码'),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: '输入手机号码', border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('详细地址'),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                            controller: detailController,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                                hintText: '街道、楼牌号等', border: InputBorder.none)),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55.0,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('所在地区'),
                      InkWell(
                        onTap: () async {
                          Result result = await CityPickers.showCityPicker(
                              context: context, height: 300.0);
                          print(result);
                          this.setState(() {
                            province = result.provinceName;
                            city = result.cityName;
                            area = result.areaName;
                          });
                        },
                        child: Container(
                          child: Text(
                            province == ''
                                ? '选择地区'
                                : '${this.province},${this.city},${this.area}',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[100]))),
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('设为默认'),
                      Switch(
                          value: isDefault,
                          onChanged: (bool newValue) {
                            this.setState(() {
                              isDefault = newValue;
                            });
                          })
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () {
                    editAddress();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Theme.of(context).primaryColor,
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    height: 42.0,
                    child: Text(
                      '确定修改',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ])))
        ]));
  }
}
