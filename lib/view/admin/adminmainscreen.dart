import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lokthienwestern/view/admin/newproduct.dart';
import 'package:lokthienwestern/view/admin/newbanner.dart';
import 'package:lokthienwestern/view/admin/orderreceived.dart';
import 'package:lokthienwestern/view/admin/productscreen.dart';
import 'package:lokthienwestern/view/admin/viewbanner.dart';
import 'package:lokthienwestern/view/loginscreen.dart';

class AdminMainScreen extends StatefulWidget {
  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _logOut,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            IconButton(
              icon: Icon(Icons.logout, color: Colors.red),
              onPressed: () {
                _logOut();
              },
            ),
          ],
        ),
        body: Center(
          child: StaggeredGridView.count(
            crossAxisCount: 4,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            padding: EdgeInsets.all(8.0),
            staggeredTiles: [
              StaggeredTile.count(2, 0.5),
              StaggeredTile.count(4, 2),
              StaggeredTile.count(2, 2),
              StaggeredTile.count(2, 2),
              StaggeredTile.count(2, 2),
              StaggeredTile.count(2, 2),
            ],
            children: <Widget>[
              SizedBox(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (content) => OrderReceived()));
                },
                child: Material(
                  color: Colors.white,
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 150,
                            width: 150,
                            child: Column(children: [
                              Image.asset("assets/images/orderreceived.png"),
                              SizedBox(height: 5),
                              Text("Order Received",
                                  style: TextStyle(fontSize: 20))
                            ])),
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (content) => NewProduct()));
                },
                child: Material(
                  color: Colors.white,
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: Column(children: [
                              Image.asset("assets/images/addproduct.png")
                            ])),
                        Text("Add Product", style: TextStyle(fontSize: 20))
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (content) => ProductScreen()));
                },
                child: Material(
                  color: Colors.white,
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child:
                                Image.asset("assets/images/viewproduct.png")),
                        Text("View Product", style: TextStyle(fontSize: 20))
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (content) => NewBanner()));
                },
                child: Material(
                  color: Colors.white,
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: Image.asset("assets/images/addbanner.png")),
                        Text("Add Banner", style: TextStyle(fontSize: 20))
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (content) => ViewBanner()));
                },
                child: Material(
                  color: Colors.white,
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            child: Image.asset("assets/images/viewbanner.png")),
                        Text("View Banner", style: TextStyle(fontSize: 20))
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _logOut() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to log out?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (content) => LoginScreen()));
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(),
                  )),
            ],
          ),
        ) ??
        false;
  }
}
