import 'dart:core';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/web.config.dart';

import '../components/NavList.dart';
import 'package:native_app/model/classify.dart';

// 首页分类导航
navTakeMap(int count, List<Children> list) {
  List<NavList> result = [];
  list.take(count).map((item) {
    result.add(new NavList(
      img: item.img,
      name: item.classifyName,
      id: item.id,
    ));
  }).toList();
  return result;
}

// 时间格式
String dateFormat(String str) {
  var date = DateTime.parse(str);
  try {
    date = DateTime.parse(str);
  } catch (err) {
    return '';
  }
  var year = date.year;
  var month = date.month;
  var day = date.day;
  var hour = date.hour;
  var minute = date.minute;
  var second = date.second;
  return '${year.toString()} - ${month.toString()} - ${day.toString()}  ${hour.toString()} : ${minute.toString()} : ${second.toString()}';
}
// 自动登录
  void login() async {
    try {
     var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    var url = webApi['login'];
    print('自动登录请求开始');
    Response response = await Dio().post("$url", data: {
        'phone': 15817351609,
        'password': 465608
      });
     print(response.headers['set-cookie'][0].split(';')[0]);
     SharedPreferences token = await SharedPreferences.getInstance();
     token.setString("token", response.headers['set-cookie'][0].split(';')[0]);
     print('自动登录结束');
      print(response);
    } catch (e) {
      print(e);
    }
  }
