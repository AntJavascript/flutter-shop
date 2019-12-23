import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:native_app/model/product.dart';
import 'package:native_app/model/classify.dart';
import '../../components/NavList.dart'; // 分类导航区域布局
// import '../../model/MenuListServe.dart'; // 分类导航区域数据结构
import '../../components/ProductList.dart';
import '../../config/web.config.dart';
import '../../components/NavBottomItems.dart';

import '../../router/application.dart';
import '../../utils/utils.dart';

// 获取商品列表
Future getProductList() async {
  try {
    var dio = Dio();
    var url = webApi['productList'];
    Response response = await dio.get("$url?page=1&limit=10");
    return response.data;
  } catch (e) {
    print(e);
  }
}

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

/// 首页
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  
  @override
  bool get wantKeepAlive => true;

  int currentBannerIndex = 0;

    // 轮播图
  var recommend = [
    "http://47.107.101.76/static/upload/1566643032.webp",
    "http://47.107.101.76/static/upload/1566644192.webp",
    "http://47.107.101.76/static/upload/1566643284.webp",
    "http://47.107.101.76/static/upload/1566642477.webp",
    "http://47.107.101.76/static/upload/1566645256.webp",
    "http://47.107.101.76/static/upload/1566642775.webp",
    "http://47.107.101.76/static/upload/1566642251.webp",
    "http://47.107.101.76/static/upload/1566643913.webp"
  ];

  List<ProductData> productList = <ProductData>[]; // 商品列表
  List<NavList> navServeList = []; // 分类导航

  // 分类导航列表
  Widget bodyGrid(List<NavList> menu) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          var params = menu[index].name + menu[index].id.toString();
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, "/productList/${Uri.encodeComponent(params)}");
            },
            child: NavList(
              name: menu[index].name,
              img: 'http://47.107.101.76/' + menu[index].img,
            ),
          );
        }, childCount: navServeList.length),
      );
  // 商品列表
  Widget bodyProductList(List<ProductData> shop) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return ProductList(
            id: shop[index].id,
            url: shop[index].thumbnail,
            price: shop[index].price,
            market: shop[index].orignPrice,
            name: shop[index].title,
          );
        }, childCount: productList.length),
      );

@override
  Future initState() {
    // 获取商品列表数据
    getProductList().then((data) {
      print('获取商品列表数据');
      Product product = Product.fromJson(data);
      List<ProductData> showData = <ProductData>[];
      product.data.forEach((v) => {showData.add(v)});
      setState(() {
        productList = showData;
      });
      print(productList);
    });
    // 获取分类列表数据
    getCategoryList().then((data) {
      Classify list = Classify.fromJson(data);
      print('获取分类列表数据');

      List<NavList> showData = [];
      if (list.data.length <= 0) {
        return;
      }
      print(list.data[0].children);
      for (var i = 0; i < list.data.length; i++) {
        print('children');
        print(list.data[i].children);
        switch (i.toString()) {
          case '0':
            {
              showData.addAll(navTakeMap(3, list.data[i].children));
            }
            break;
          case '1':
            {
              showData.addAll(navTakeMap(2, list.data[i].children));
            }
            break;
          case '2':
            {
              showData.addAll(navTakeMap(2, list.data[i].children));
            }
            break;
          case '3':
            {
              showData.addAll(navTakeMap(2, list.data[i].children));
            }
            break;
          case '4':
            {
              showData.addAll(navTakeMap(1, list.data[i].children));
            }
            break;
        }
      }
      print('showData' + showData.toString());
      setState(() {
        navServeList = showData;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          '首页',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(0.0),
          sliver: new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 100.0,
              margin: EdgeInsets.only(bottom: 10.0),
              child: new Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return new Image.network(
                    recommend[index],
                    fit: BoxFit.contain,
                  );
                },
                itemCount: recommend.length,
                pagination: new SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        size: 6.0, activeSize: 6.0, color: Colors.grey)),
                autoplay: true,
              ),
            ),
          ])),
        ),
        new SliverPadding(
          padding: const EdgeInsets.all(0.0),
          sliver: new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
            Container(
              height: 10.0,
              color: Colors.white,
            )
          ])),
        ),
        bodyGrid(navServeList),
        new SliverPadding(
          padding: const EdgeInsets.all(0.0),
          sliver: new SliverList(
              delegate: new SliverChildListDelegate(<Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 10.0),
            ),
          ])),
        ),
        bodyProductList(productList),
      ],
    ),
    );
  }
}
