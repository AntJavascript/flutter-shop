# 一个用于学习flutter的商城项目（所有数据来自真实接口）
项目持续更新中...

# 商城部分截图：
<img src='./example/screen/微信图片_20191106232251.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232243.jpg' width='260  style='float:left'>
<img src='./example/screen/微信图片_20191106232209.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232235.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232226.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232219.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232300.jpg' width='260' style='float:left'>
<img src='https://upload-images.jianshu.io/upload_images/8493227-414e4b97344b8b45.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1080/format/webp' width='260' style='float:left'>
<img src='https://upload-images.jianshu.io/upload_images/8493227-16caa37188a372fa.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1080/format/webp' width='260' style='float:left'>                                                                                  
<img src='./example/screen/微信图片_20191106232200.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232138.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232107.jpg' width='260' style='float:left'>
<img src='./example/screen/微信图片_20191106232150.jpg' width='260' style='float:left'>
                                                                                  
# 项目结构如下：<br/>
├── /components/ #自定义组件目录<br/>
│ ── ├── /loading.dart #一个自定义的loading加载组件<br/>
│ ── ├── /NavList.dart #首页导航组件<br/>
│ ── ├── /NavBottomItems.dart #界面底部导航组件<br/>
│ ── └── /ProductList.dart #首页商品列表组件<br/>
├── /config/ #配置文件目录<br/>
│ ── ├── /web.config.js #接口地址配置<br/>
├── /model/ #数据模型JSON目录（后缀为.g.dart文件自动生成的）<br/>
│ ── ├── /cart.dart #购物车列表<br/>
│ ── ├── /cart.g.dart #解析购物车列表json<br/>
│ ── ├── /classify.dart #商品分类<br/>
│ ── ├── /classify.g.dart #解析商品分类json<br/>
│ ── ├── /comment.dart #通用数据模型<br/>
│ ── ├── /comment.g.dart #解析通用数据json<br/>
│ ── ├── /detail.dart #商品详情<br/>
│ ── ├── /detail.g.dart #解析商品详情json<br/>
│ ── ├── /order_detail.dart #订单详情<br/>
│ ── ├── /order_detail.g.dart #解析订单详情json<br/>
│ ── ├── /order_list.dart #订单列表<br/>
│ ── ├── /order_list.g.dart #解析订单列表json<br/>
│ ── ├── /user_address.dart #用户收货地址<br/>
│ ── ├── /user_address.g.dart #解析用户收货地址json<br/>
│ ── ├── /user_coupon.dart #用户优惠券<br/>
│ ── ├── /user_coupon.g.dart #解析用户优惠券json<br/>
│ ── ├── /user_ifo.dart #用户资料<br/>
│ ── └── /user_ifo.g.dart #解析用户资料json<br/>
├── /router/ #路由配置目录<br/>
│ ── ├── /application.dart #初始化路由变量<br/>
│ ── ├── /router_handler.dart #路由方法处理<br/>
│ ── └── /routes.dart #定义路由<br/>
├── /utils/ #utils工具目录<br/>
├── /view/ #项目界面目录<br/>
│ ── ├── /classify/ #分类模块<br/>
│ ── │ ── ├── /index.dart #分类界面<br/>
│ ── │ ── └── /list.dart #分类商品界面<br/>
│ ── ├── /find/ #发现模块<br/>
│ ── │ ── ├── /list.dart #发现列表界面<br/>
│ ── │ ── └── /detail.dart #发现详情界面<br/>
│ ── ├── /home/ #首页模块<br/>
│ ── │ ── ├── /index.dart #首页界面<br/>
│ ── │ ── └── /detail.dart #商品详情界面<br/>
│ ── ├── /login/ #登录模块<br/>
│ ── │ ── ├── /login.dart #登录界面<br/>
│ ── │ ── ├── /register.dart #注册界面<br/>
│ ── │ ── └── /setPassword.dart #设置密码界面<br/>
│ ── ├── /user/ #用户模块<br/>
│ ── │ ── ├── /addMap #添加收货地址界面<br/>
│ ── │ ── ├── /cart #购物车界面<br/>
│ ── │ ── ├── /confirmOrder #确认订单界面<br/>
│ ── │ ── ├── /coupon #优惠券列表<br/>
│ ── │ ── ├── /index #个人中心首页<br/>
│ ── │ ── ├── /mapList #收货地址列表界面<br/>
│ ── │ ── ├── /orderDetail #订单详情界面<br/>
│ ── │ ── ├── /orderList #订单列表界面<br/>
│ ── │ ── ├── /orderMap #收货地址列表界面<br/>
│ ── │ ── └── /server #客服中心界面<br/>
└── main.dart #项目入口文件<br/>
