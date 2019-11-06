import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:native_app/view/find/list.dart';
import '../view/classify/index.dart';
import '../view/home/index.dart';
import '../view/classify/list.dart';
import '../view/home/detail.dart';
import '../view/login/login.dart';
import '../view/login/register.dart';
import '../view/user/cart.dart';
import '../view/user/confirmOrder.dart';
import '../view/user/orderMap.dart';
import '../view/user/addMap.dart';
import '../view/user/editMap.dart';
import '../view/user/index.dart';
import '../view/user/orderList.dart';
import '../view/user/orderDetail.dart';
import '../view/user/coupon.dart';
import '../view/user/server.dart';
import '../view/user/mapList.dart';
import '../view/find/list.dart';
// 分类列表
Handler classifyHanderl =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return ClassifyIndex();
  }
);
// 首页
Handler homeHanderl =Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return HomePage();
  }
);
// 商品列表
Handler productListHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    print(Uri.decodeComponent(params['data'][0]));
    return ProductListPage(params['data'][0]);
  }
);
// 商品详情
Handler productDetailtHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    print("_____" + params['id'][0]);
    return ProductDetail(params['id'][0]);
  }
);
// 登录界面
Handler logintHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return LoginPage();
  }
);
// 注册界面
Handler registertHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return RegisterPage();
  }
);
// 购物车界面
Handler cartHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return CartPage();
  }
);
// 确认订单界面
Handler confirmOrderHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return ConfirmOrderPage();
  }
);
// 收货地址界面
Handler orderMapHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return OrderMapPage();
  }
);
// 新增收货地址界面
Handler addMapHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return AddMapPage();
  }
);
// 我的界面
Handler userHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return UserPage();
  }
);
// 订单管理界面
Handler orderHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    print('订单类型' + params['orderType'][0]);
    return OrderPage(int.parse(params['orderType'][0]));
  }
);
// 订单管理界面
Handler orderDetailHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    print("__订单id___" + params['id'][0]);
    return OrderDetailPage(params['id'][0]);
  }
);
// 优惠券界面
Handler couponHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return CouponPage();
  }
);
// 客服中心界面
Handler serverHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return ServerPage();
  }
);
// 个人地址列表界面
Handler userMapListHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return MapListPage();
  }
);
// 发现列表界面
Handler findHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    return FindPage();
  }
);
// 修改收货地址界面
Handler editMapHanderl =Handler(
  handlerFunc: (BuildContext context, Map<String,dynamic> params){
    print("__地址___");
    print(params['id'][0]);
    return EditMapPage(params['id'][0]);
  }
);
