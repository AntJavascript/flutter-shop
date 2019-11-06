import 'dart:core';
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
