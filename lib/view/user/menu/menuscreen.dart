import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/model/detail.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/user/checkout/cartscreen.dart';
import 'package:lokthienwestern/view/user/menu/detailscreen.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:lokthienwestern/view/user/home/searchscreen.dart';

class MenuScreen extends StatefulWidget {
  final User user;

  const MenuScreen({
    Key key,
    this.user,
  }) : super(key: key);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List _productList;
  double screenHeight, screenWidth;
  Detail detail;
  int cartitem;
  @override
  void initState() {
    super.initState();
    _loadProducts("all");
    _loadCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => CartScreen(
                                user: widget.user,
                              ))).then((_) => setState(() {
                        _loadCart();
                      }));
                },
              ),
              Positioned(
                left: 25,
                child: Container(
                    width: 19,
                    height: 19,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.black,
                        shape: BoxShape.circle),
                    child: Center(
                      child: cartitem == null
                          ? Text(
                              "...",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              cartitem.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    )),
              )
            ],
          ),
        ],
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
                                  builder: (content) =>
                                      Search(user: widget.user)))
                          .then((_) => setState(() {
                                _loadCart();
                              }));
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
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio:
                                  (screenWidth / screenHeight) / 0.6),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_productList[index]['product_id']}.png",
                                        height: 100,
                                        width: 150,
                                      )
                                    ]),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 5, 0),
                                      child: Text(
                                          titleSub(_productList[index]
                                              ['product_name']),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 5, 0),
                                      child: Text(
                                        "Price: RM " +
                                            _productList[index]
                                                ['product_price'],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                    onPressed: () => {
                                      detail = Detail(
                                        productid: _productList[index]
                                            ['product_id'],
                                        productimage: CachedNetworkImage(
                                          imageUrl:
                                              "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_productList[index]['product_id']}.png",
                                          fit: BoxFit.cover,
                                        ),
                                        productname: _productList[index]
                                            ['product_name'],
                                        productprice: _productList[index]
                                            ['product_price'],
                                        productdesc: _productList[index]
                                            ['product_desc'],
                                        productrating: _productList[index]
                                            ['product_rating'],
                                      ),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (content) =>
                                                  DetailsScreen(
                                                    user: widget.user,
                                                    detail: detail,
                                                  ))).then((_) => setState(() {
                                            _loadCart();
                                          }))
                                    },
                                    child: Text("View More"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
        ]),
      ),
    );
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

  String titleSub(String title) {
    if (title.length > 14) {
      return title.substring(0, 14) + "...";
    } else {
      return title;
    }
  }

  void _loadCart() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_cartqty.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        cartitem = int.parse(response.body);
      });
    });
  }
}
