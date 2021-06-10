import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lokthienwestern/view/user/detailscreen.dart';
import 'package:lokthienwestern/widget/food_categ.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:lokthienwestern/view/user/searchscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _productList;

  @override
  void initState() {
    super.initState();
    _loadProducts("all");
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
          body: SafeArea(
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content) => Search()));
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: IgnorePointer(
                        child: TextField(
                          // controller: _srcController,
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
          _productList == null
              ? Flexible(
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Loading()],
                  ),
                ))
              : Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 15.0),
                        CarouselSlider.builder(
                          itemCount: _productList.length,
                          options: CarouselOptions(
                            height: screenWidth * 9 / 16,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 500),
                            viewportFraction: 0.8,
                          ),
                          itemBuilder:
                              (BuildContext context, int index, realindex) =>
                                  GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => DetailsScreen(
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
                                          )))
                            },
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Positioned.fill(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Loading(),
                                )),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20.0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 5.0,
                                            spreadRadius: 1.0)
                                      ]),
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_productList[index]['product_id']}.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20.0)),
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black
                                          ])),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        titleSub(
                                            _productList[index]['product_name']),
                                        style: TextStyle(
                                            fontSize: 25.0, color: Colors.white),
                                      ),
                                      Text(
                                        "Price: RM" +
                                            _productList[index]['product_price'],
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.white),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Categories",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Burger & Hotdog",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          productcateg: "BurgerHotdog",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Rice",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          productcateg: "Rice",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Main Course",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          productcateg: "Main Course",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Spaghetti",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          productcateg: "Spaghetti",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Snacks",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          productcateg: "Snacks",
                        ),
                      ],
                    ),
                  ),
                )
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
}
