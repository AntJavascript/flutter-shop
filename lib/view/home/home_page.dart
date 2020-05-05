import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:native_app/model/product.dart';
import 'package:native_app/model/classify.dart';
import '../../components/NavList.dart'; // 分类导航区域布局
import '../../components/ProductList.dart';
import '../../config/web.config.dart';

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

class HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;
  bool isgetClassify = false; // 是否正在获取分类数据
  bool isgetProductList = false; // 是否正在商品列表数据
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
   // 获取分类列表
   setCategorys() {
    getCategoryList().then((data) {
      Classify list = Classify.fromJson(data);
      List<NavList> showData = [];
      if (list.data.length <= 0) {
        setState(() {
          isgetClassify = true;
        });
        return;
      }
      for (var i = 0; i < list.data.length; i++) {
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
      setState(() {
        navServeList = showData;
        isgetClassify = true;
      });
    });
  }

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
      // print('商品列表加载完成');
      // print(data);
      Product product = Product.fromJson(data);
      List<ProductData> showData = <ProductData>[];
      product.data.forEach((v) => {showData.add(v)});
      setState(() {
        productList = showData;
        isgetProductList = true;
      });
    });
    setCategorys(); // 获取分类
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
          this.navServeList.length > 0
              ? bodyGrid(navServeList)
              : new SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: new SliverList(
                      delegate: new SliverChildListDelegate(<Widget>[
                    Center(
                      child: isgetClassify ? Container(
                        margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        height: 30.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.grey[400]),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text('重试', style: TextStyle(fontSize: 14.0),),
                          ),
                          onTap: () {
                            // 获取分类列表数据
                            setCategorys();
                          },
                        ),
                      ) : Container(
                        height: 110.0,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                        ),
                      ),
                    ),
                  ])),
                ),
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
          this.productList.length > 0
              ? bodyProductList(productList)
              : new SliverPadding(
                  padding: const EdgeInsets.all(0.0),
                  sliver: new SliverList(
                      delegate: new SliverChildListDelegate(<Widget>[
                    Center(
                      child: isgetProductList ? Container(
                        margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        height: 36.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(color: Colors.grey[400]),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text('重试', style: TextStyle(fontSize: 14.0),),
                          ),
                          onTap: () {
                            getProductList().then((data) {
                              Product product = Product.fromJson(data);
                              List<ProductData> showData = <ProductData>[];
                              product.data.forEach((v) => {showData.add(v)});
                              setState(() {
                                productList = showData;
                              });
                            });
                          },
                        ),
                      ): 
                      Container(
                        height: 30.0,
                        child: SizedBox(
                          width: 30.0,
                          height: 30.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                    ),
                  ])),
                ),
        ],
      ),
    );
  }
}
