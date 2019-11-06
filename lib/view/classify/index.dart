import 'package:flutter/material.dart';
import 'package:native_app/view/find/list.dart';
import 'package:native_app/view/home/index.dart';
import 'package:native_app/view/user/cart.dart';
import 'package:native_app/view/user/index.dart';

import 'package:native_app/model/classify.dart';
import '../../router/application.dart';
import '../../components/NavBottomItems.dart';
import '../../config/web.config.dart';
import 'package:dio/dio.dart';

// 获取分类列表
Future getCategoryList() async {
  try {
    var url = webApi['categoryList'];
    Response response = await Dio().get(url);
    return response.data;
  } catch (e) {
    print(e);
  }
}

class ClassifyIndex extends StatefulWidget {
  ClassifyIndex({Key key}) : super(key: key);

  @override
  _ClassifyIndexState createState() => _ClassifyIndexState();
}

class _ClassifyIndexState extends State<ClassifyIndex> {
  List<ClassifyData> classifyList = <ClassifyData>[]; // 分类列表

  @override
  void initState() {
    // 获取分类列表数据
    getCategoryList().then((data) {
      Classify list = Classify.fromJson(data);
      List<ClassifyData> showData = <ClassifyData>[];
      list.data.forEach((v) => {showData.add(v)});
      setState(() {
        classifyList = list.data;
      });
    });
    super.initState();
  }

  int _selectedIndex = 0; // 选择的分类索引
  int bottomNavIndex = 1;
  bool loading = false;

  void _onItemTapped(int index) {
    if(index == 1) {
      return;
    }
    if (index == 3) {
      Application.router.navigateTo(context, "/cart");
      return;
    }
    this.setState(() {
      bottomNavIndex = index;
    });
  }

  Widget ClassifyUI() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "分类",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: classifyList.length > 0 ? Row(children: <Widget>[
        // 左侧导航分类列表
        Container(
            width: 100.0,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[100],
            child: ListView.builder(
              itemCount: classifyList.length,
              itemBuilder: (BuildContext context, int index) {
                // 当前选中项
                bool flag = false;
                if (_selectedIndex == index) {
                  flag = true;
                }
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                    color: flag ? Colors.green[50] : Colors.grey[100],
                    height: 44.0,
                    child: Center(
                      child: Text(classifyList[index].classifyName,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: flag
                                  ? Theme.of(context).primaryColor
                                  : Colors.black)),
                    ),
                  ),
                );
              },
            )),
        // 子分类列表
        (classifyList.length > 0 &&
                classifyList[_selectedIndex].children.length > 0)
            ? Container(
                width: MediaQuery.of(context).size.width - 100.0,
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                      childAspectRatio: 1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int subIndex) {
                      // // 路由传递参数
                      // Map<String,dynamic> params;
                      // var params = new Map<String,dynamic>();
                      var params = classifyList[_selectedIndex]
                              .children[subIndex]
                              .classifyName +
                          classifyList[_selectedIndex]
                              .children[subIndex]
                              .id
                              .toString();
                      // params['name'] = classifyList[_selectedIndex].children[subIndex].classifyName;
                      // params['id'] = classifyList[_selectedIndex].children[subIndex].id;
                      return new Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 5.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              onTap: () => {
                                Application.router.navigateTo(context,
                                    "/productList/${Uri.encodeComponent(params)}")
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(height: 5.0),
                                  Image.network(
                                      "http://47.107.101.76/" +
                                          classifyList[_selectedIndex]
                                              .children[subIndex]
                                              .img,
                                      width: 50.0,
                                      height: 50.0),
                                  Text(classifyList[_selectedIndex]
                                      .children[subIndex]
                                      .classifyName)
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                      childCount:
                            classifyList[_selectedIndex].children.length),
                  )
                ]))
            : Container()
      ]): Center(
        child: CircularProgressIndicator(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navBottomItems,
        currentIndex: 1,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (this.bottomNavIndex.toString()) {
      case '0':
        {
          return HomePage();
        }
        break;
      case '1':
        {
          return ClassifyUI();
        }
        break;
      case '2':
        {
          return FindPage();
        }
        break;
      case '3':
        {
          return CartPage();
        }
        break;
      case '4':
        {
          return UserPage();
        }
        break;
      default:
        {
          return ClassifyUI();
        }
    }
  }
}
