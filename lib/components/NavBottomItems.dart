 import 'package:flutter/material.dart';
  // 底部导航
  List<BottomNavigationBarItem> navBottomItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.near_me),
      title: Text('发现'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我的'),
    ),
  ];
