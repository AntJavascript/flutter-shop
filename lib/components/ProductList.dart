import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductList extends StatelessWidget {
  final String url;
  final String name;
  final dynamic price;
  final dynamic market;
  final int id;
  ProductList({this.url, this.name, this.price, this.market, this.id});
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => new Icon(
                Icons.image,
                color: Colors.grey[300],
                size: MediaQuery.of(context).size.width / 2 - 10,
              ),
              errorWidget: (context, url, error) => new Icon(
                Icons.image,
                color: Colors.grey[300],
                size: MediaQuery.of(context).size.width / 2 - 10,
              ),
            ),
            Container(height: 5.0),
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16.0),
            ),
            Row(
              children: <Widget>[
                Text(
                  "￥" + price.toString(),
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                ),
                Text(
                  "￥" + market.toString(),
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                )
              ],
            )
          ],
        ));
  }
}
