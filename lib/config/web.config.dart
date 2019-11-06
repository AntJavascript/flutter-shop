var base ='http://47.107.101.76';
var webApi = {
  'productList': base + '/product/list',
  'categoryList': base + '/classify/list',
  'classifyIdFindListData': base + '/classifyIdFindListData',
  'detail':base + '/product/detail',
  'comment':base + '/comment/list',
  'addCart': base + '/Cart/add',
  'login': base + '/AppLogin',
  'cart': base + '/Cart/list',
  'CartStatus': base + '/CartStatus',
  'AddressList': base + '/User/GetUserAddressList',
  'CartSelectList': base + '/Cart/selectList', // 获取购物车选中状态
  'AddUserAddress': base + '/User/AddUserAddress', // 添加个人收货地址
  'GetUserInfo': base + '/user/getUserInfo', // 获取用户信息
  'UserOrderList': base + '/User/Order/List', // 个人订单列表
  'GetUserOrderDetail': base + '/User/Order/Detail', // 订单详情
  'UserCouponList': base + '/User/UserCouponList', // 个人优惠券列表
  'ArticleList': base + '/Article/list', // 文章列表
  'UserAddressDetail': base + '/User/UserAddressDetail', // 地址详情
  'DelCart': base + '/Cart/DelCart', // 删除购物车
};