import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokthienwestern/model/product.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/admin/editproduct.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:ndialog/ndialog.dart';

class AdminSearchScreen extends StatefulWidget {
  final User user;

  const AdminSearchScreen({Key key, this.user}) : super(key: key);
  @override
  _AdminSearchScreenState createState() => _AdminSearchScreenState();
}

class _AdminSearchScreenState extends State<AdminSearchScreen> {
  List _productList;
  Product product;
  String _titlecenter = "Search by Product Name.";
  String _imagecenter = "assets/images/search.png";

  TextEditingController _searchController = TextEditingController();
  double screenHeight, screenWidth;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }),
        title: _searchTextField(),
        actions: _buildActions(),
      ),
      body: SafeArea(
        child: Column(children: [
          _productList == null
              ? Flexible(
                  child: Center(
                  child: _titlecenter == ""
                      ? Loading()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              _imagecenter,
                              height: 150,
                              width: 150,
                            ),
                            SizedBox(height: 10),
                            Text(_titlecenter,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 20),
                          ],
                        ),
                ))
              : Flexible(
                  child: Center(
                    child: Column(children: [
                      _productList?.length == null
                          ? Flexible(
                              child: Center(
                                  child: Text(
                                      "This food not available in Lok Thien Western.",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))))
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                  child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Category: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: Text(
                                                              _productList[
                                                                      index][
                                                                  'product_categ'],
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Price:",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          "RM " +
                                                              double.parse(_productList[
                                                                          index]
                                                                      [
                                                                      'product_price'])
                                                                  .toStringAsFixed(
                                                                      2),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Rating: ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                          _productList[index][
                                                              'product_rating'],
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      titleSub(
                                                          _productList[index]
                                                              ['product_desc']),
                                                      style: TextStyle(
                                                        height: 1.5,
                                                        fontSize: 15,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 7,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      _deleteProductDialog(
                                                          index);
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
                )
        ]),
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          if (_searchController.text.isEmpty) {
            _isSearching = false;
            _loadProducts("null");
            _productList = null;
          } else {
            _loadProducts(value);
            _isSearching = true;
          }
        });
      },
      decoration: InputDecoration(
        hintText: "Search Product Name...",
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 20, color: Colors.white54),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            FocusScope.of(context).unfocus();
            setState(() {
              _loadProducts("null");
              _imagecenter = "assets/images/search.png";
              _titlecenter = "Search by Product Name.";
              _productList = null;
              _searchController.clear();
              _isSearching = false;
            });
          },
        ),
      ];
    }
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => setState(() {
                if (_searchController.text.isNotEmpty) {
                  _loadProducts(_searchController.text);
                  _isSearching = true;
                }
              })),
    ];
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
            "https://hubbuddies.com/269509/lokthienwestern/php/load_products.php?"),
        body: {"product_name": _productname}).then((response) {
      if (response.body == "nodata") {
        _imagecenter = "assets/images/searchnotfound.png";
        _titlecenter = "Not available in Lok Thien Western.";
        _productList = null;
        setState(() {});
        return;
      } else if (response.body == "nullnodata") {
        _imagecenter = "assets/images/search.png";
        _titlecenter = "Search by Product Name.";
        _productList = null;
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
