import 'dart:core';
import 'package:flutter/material.dart';
import 'package:native_app/view/home/home_page.dart';
import 'package:native_app/view/classify/index.dart';
import 'package:native_app/view/find/list.dart';
import 'package:native_app/view/user/cart.dart';
import 'package:native_app/view/user/index.dart';

import '../../components/NavBottomItems.dart';

import '../../router/application.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _pageList = [
    HomePage(),
    ClassifyIndex(),
    FindPage(),
    CartPage(),
    UserPage(),
  ];
  var _appBarTitle = [
    '首页',
    '分类',
    '发现',
    '购物车',
    '我的',
  ];
  final _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    this.setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);

    @override
    void initState() {
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onItemTapped,
        children: [
          HomePage(),
          ClassifyIndex(),
          FindPage(),
          CartPage(),
          UserPage()
        ],
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navBottomItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
