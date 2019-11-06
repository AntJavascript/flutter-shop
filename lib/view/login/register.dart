import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';

/// 质感设计样式
class RegisterPage extends StatefulWidget {
  const RegisterPage();
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  RegisterPageState();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // 点击登录
  void login() async {
    try {
      print(phoneController.text);
      print(this.passwordController.text);
      var url = webApi['login'];
      Response response = await Dio().post("$url", data: {
        'phone': this.phoneController.text,
        'password': this.passwordController.text
      });
      print(response);
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
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              '注册',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[],
          ),
          SliverPadding(
              padding: const EdgeInsets.all(0.0),
              sliver: new SliverList(
                  delegate: new SliverChildListDelegate(<Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/login_bg.png',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 42.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5.0, right: 10.0),
                              child: Icon(
                                Icons.phone_iphone,
                                color: Theme.of(context).primaryColor,
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "手机号码",
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey[300])),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Theme.of(context)
                                                .primaryColor))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 25.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 42.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 5.0, right: 10.0),
                              child: Icon(
                                Icons.verified_user,
                                color: Theme.of(context).primaryColor,
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "验证码",
                                    suffix: Text("获取验证码"),
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.grey[300])),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Theme.of(context)
                                                .primaryColor))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40.0,
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            login();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Theme.of(context).primaryColor,
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 40,
                            height: 42.0,
                            child: Text(
                              '下一步',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ])))
        ]));
  }
}
