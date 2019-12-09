import 'package:flutter/material.dart';
import './router_handler.dart';
import 'package:fluro/fluro.dart';

class Routes{
  static String root='/';
  static String classifyPage = '/classify';
  static String productList = '/productList/:data';
  static String productDetail = '/productDetail/:id';
  static String login = '/login';
  static String register = '/register';
  static String cart = '/cart';
  static String confirmOrder = '/confirmOrder';
  static String orderMap = '/orderMap';
  static String addMap = '/addMap';
  static String editMap = '/editMap/:id';
  static String user = '/user';
  static String order = '/order/:orderType';
  static String orderDetail = '/orderDetail/:id';
  static String coupon = '/coupon';
  static String server = '/server';
  static String userMapList = '/userMapList';
  static String find = '/find';
  
  static void configureRoutes(Router router){
    router.notFoundHandler= new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
      }
    );

    router.define(root,handler:homeHanderl);
    router.define(classifyPage,handler:classifyHanderl);
    router.define(productList,handler:productListHanderl);
    router.define(productDetail,handler:productDetailtHanderl);
    router.define(login,handler:logintHanderl);
    router.define(register,handler:registertHanderl);
    router.define(cart,handler:cartHanderl);
    router.define(confirmOrder,handler:confirmOrderHanderl);
    router.define(orderMap,handler:orderMapHanderl);
    router.define(addMap,handler:addMapHanderl);
    router.define(user,handler:userHanderl);
    router.define(order,handler:orderHanderl);
    router.define(orderDetail,handler:orderDetailHanderl);
    router.define(coupon,handler:couponHanderl);
    router.define(server,handler:serverHanderl);
    router.define(userMapList,handler:userMapListHanderl);
    router.define(find,handler:findHanderl);
    router.define(editMap,handler:editMapHanderl);
  }

}
