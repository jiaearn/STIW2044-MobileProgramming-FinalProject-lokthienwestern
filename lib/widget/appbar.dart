import 'package:flutter/material.dart';
import 'package:lokthienwestern/view/user/cartscreen.dart';

AppBar homeAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.5,
    backgroundColor: Colors.black,
    title: Text('Lok Thien Western',
        style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontFamily: "Samantha")),
    actions: <Widget>[
      Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (content) => CartScreen()));
            },
          ),
        ],
      ),
    ],
  );
}

AppBar adminHomeAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0.5,
    backgroundColor: Colors.black,
    title: Text('Lok Thien Western',
        style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontFamily: "Samantha")),
  );
}

AppBar detailsAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.black,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
