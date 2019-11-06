import 'dart:async';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config/web.config.dart';
import '../../router/application.dart';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 质感设计样式
class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  LoginPageState();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // 点击登录
  void login() async {
    try {
     var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    var url = webApi['login'];
    Response response = await Dio().post("$url", data: {
        'phone': this.phoneController.text,
        'password': this.passwordController.text
      });
     print(response.headers['set-cookie'][0].split(';')[0]);

     SharedPreferences token = await SharedPreferences.getInstance();
     token.setString("token", response.headers['set-cookie'][0].split(';')[0]);
      Application.router.pop(context);
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
            title: Text(
              '登录',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              Align(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: (){
                        Application.router.navigateTo(context, "/register");
                      },
                      child: Text(
                        '注册',
                        style: TextStyle(fontSize: 16.0,color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
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
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "密码",
                                    suffix: Text("忘记密码？"),
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
                              '登录',
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
