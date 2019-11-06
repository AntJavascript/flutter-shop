import 'package:flutter/material.dart';

class NavList extends StatelessWidget {
  final img;
  final name;
  final id;
  NavList({this.img, this.name, this.id});
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              Image.network(img, width: 50.0, height: 50.0),
              Container(height: 5.0),
              Text(name)
            ],
          )
        ],
      ),
    );
  }
}
