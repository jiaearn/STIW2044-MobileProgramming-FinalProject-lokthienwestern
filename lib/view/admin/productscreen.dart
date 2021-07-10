import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/model/product.dart';
import 'package:lokthienwestern/view/admin/adminsearchscreen.dart';
import 'package:lokthienwestern/view/admin/editproduct.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:ndialog/ndialog.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key key,
  }) : super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List _productList;
  double screenHeight, screenWidth;
  Product product;

  @override
  void initState() {
    super.initState();
    _loadProducts("all");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                  ),
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => AdminSearchScreen()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: IgnorePointer(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: "Search Here",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _productList?.length == null
              ? Flexible(
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Loading()],
                  ),
                ))
              : Flexible(
                  child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: _productList.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1.5 / 1),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Card(
                              child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[800],
                                    offset: Offset(5.0, 8.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.white),
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
                                              "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_productList[index]['product_id']}.png",
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
                                              _productList[index]
                                                  ['product_name'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Category: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                  _productList[index]
                                                      ['product_categ'],
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Price:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "RM " +
                                                  double.parse(
                                                          _productList[index]
                                                              ['product_price'])
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Rating: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              _productList[index]
                                                  ['product_rating'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Description :",
                                          style: TextStyle(
                                              height: 1.5,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          titleSub(_productList[index]
                                              ['product_desc']),
                                          style: TextStyle(
                                            height: 1.5,
                                            fontSize: 15,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          _editProductDialog(index);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _deleteProductDialog(index);
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                )),
        ]),
      ),
    );
  }

  String titleSub(String title) {
    if (title.length > 40) {
      return title.substring(0, 40) + "...";
    } else {
      return title;
    }
  }

  void _loadProducts(String _productname) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_products.php"),
        body: {"product_name": _productname}).then((response) {
      if (response.body == "nodata") {
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        setState(() {});
      }
    });
  }

  void _deleteProductDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete this product?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteProduct(index);
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

  Future<void> _deleteProduct(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Delete product"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/delete_product.php"),
        body: {
          "product_id": _productList[index]['product_id']
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadProducts("all");
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }

  void _editProductDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Edit this product?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      product = Product(
                        productid: _productList[index]['product_id'],
                        productimage: CachedNetworkImage(
                          imageUrl:
                              "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_productList[index]['product_id']}.png",
                          fit: BoxFit.cover,
                        ),
                        productname: _productList[index]['product_name'],
                        productprice: _productList[index]['product_price'],
                        productcateg: _productList[index]['product_categ'],
                        productdesc: _productList[index]['product_desc'],
                        productrating: _productList[index]['product_rating'],
                      );
                      Navigator.pop(context);
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) =>
                                      EditProduct(product: product)))
                          .then((_) => setState(() {
                                _loadProducts("all");
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
