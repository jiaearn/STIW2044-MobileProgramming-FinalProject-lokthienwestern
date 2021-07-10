import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/user/checkout/checkoutscreen.dart';
import 'package:ndialog/ndialog.dart';
import 'package:lokthienwestern/widget/loading.dart';

class CartScreen extends StatefulWidget {
  final User user;

  const CartScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _titlecenter = "";
  List _cartList = [];
  double _totalprice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Your Cart',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: Center(
        child: Column(
          children: [
            if (_cartList.isEmpty)
              Flexible(
                  child: Center(
                child: _titlecenter == ""
                    ? Loading()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/emptycart.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(height: 10),
                          Text('Cart Is Empty!',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 20),
                        ],
                      ),
              ))
            else
              Flexible(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 2.5 / 1,
                    children: List.generate(_cartList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(3),
                          child: Card(
                              child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.yellow,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                          imageUrl:
                                              "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_cartList[index]['product_id']}.png",
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover),
                                    ],
                                  )),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                              _cartList[index]['product_name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          "RM " +
                                              (int.parse(_cartList[index]
                                                          ['cartqty']) *
                                                      double.parse(_cartList[
                                                              index]
                                                          ['product_price']))
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                    height: 30.0,
                                                    width: 20.0,
                                                    child: IconButton(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      icon: new Icon(
                                                          Icons.remove,
                                                          size: 20),
                                                      onPressed: () {
                                                        _modQty(index,
                                                            "removecart");
                                                      },
                                                    ))),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: 30.0,
                                                  width: 100.0,
                                                  child: Center(
                                                    child: Text(_cartList[index]
                                                        ['cartqty']),
                                                  ),
                                                )),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                  ),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: SizedBox(
                                                    height: 30.0,
                                                    width: 20.0,
                                                    child: IconButton(
                                                      padding:
                                                          new EdgeInsets.all(
                                                              0.0),
                                                      icon: new Icon(Icons.add,
                                                          size: 20),
                                                      onPressed: () {
                                                        _modQty(
                                                            index, "addcart");
                                                      },
                                                    ))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteCartDialog(index);
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )));
                    })),
              )),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TOTAL",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "RM " + _totalprice.toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    // SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        _payDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: Text("CHECKOUT"),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _loadMyCart() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_cart.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _cartList = [];
        _totalprice = 0.0;
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _cartList = jsondata["cart"];
        _totalprice = 0.0;
        for (int i = 0; i < _cartList.length; i++) {
          _totalprice = _totalprice +
              double.parse(_cartList[i]['product_price']) *
                  int.parse(_cartList[i]['cartqty']);
        }
      }
      setState(() {});
    });
  }

  Future<void> _modQty(int index, String s) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Update cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/update_cart.php"),
        body: {
          "email": widget.user.email,
          "op": s,
          "product_id": _cartList[index]['product_id'],
          "qty": _cartList[index]['cartqty']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  Future<void> _deleteCart(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Delete from cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/delete_cart.php"),
        body: {
          "email": widget.user.email,
          "product_id": _cartList[index]['product_id']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete from your cart?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _payDialog() {
    if (_totalprice == 0.0) {
      Fluttertoast.showToast(
          msg: "Cart Is Empty.",
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Proceed with checkout?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) => CheckOutScreen(
                                    user: widget.user, total: _totalprice),
                              ),
                            )
                            .then((_) => setState(() {
                                  _loadMyCart();
                                }));
                      },
                    ),
                    TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
          context: context);
    }
  }
}
