import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './config/web.config.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';

import './view/home/index.dart';

import './router/routes.dart';
import './router/application.dart';

void main() async {
  runApp(App());
  try {
     var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    var url = webApi['login'];
    print('自动登录请求开始');
    Response response = await Dio().post("$url", data: {
        'phone': '15817351609',
        'password': '465608'
      });
     print(response.headers['set-cookie'][0].split(';')[0]);
     SharedPreferences token = await SharedPreferences.getInstance();
     token.setString("token", response.headers['set-cookie'][0].split(';')[0]);
     print('自动登录结束');
     print(response);
    } catch (e) {
      print(e);
    }
  if (Platform.isAndroid) {
    // 设置沉浸式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class App extends StatelessWidget {
  // final router = Router();

   App() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Routes.configureRoutes(router);
    // Application.router = router;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 64, 207, 160),
      ),
      home: Home(),
    );
  }
}
