import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lokthienwestern/model/detail.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/user/checkout/cartscreen.dart';
import 'package:lokthienwestern/widget/foodcateg.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:lokthienwestern/view/user/home/searchscreen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _bannerList;
  Detail detail;
  int cartitem;

  @override
  void initState() {
    super.initState();
    _loadCart();
    _loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
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
          _bannerList == null
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
                          itemCount: _bannerList.length,
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
                                  Stack(
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
                                      "https://hubbuddies.com/269509/lokthienwestern/images/banner_pictures/${_bannerList[index]['banner_id']}.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Burger & Hotdog",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          user: widget.user,
                          productcateg: "BurgerHotdog",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Rice",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          user: widget.user,
                          productcateg: "Rice",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Main Course",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          user: widget.user,
                          productcateg: "Main Course",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Spaghetti",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          user: widget.user,
                          productcateg: "Spaghetti",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Snacks",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                        FoodCateg(
                          user: widget.user,
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

  void _loadBanner() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_banner.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _bannerList = jsondata["banner"];
        setState(() {});
      }
    });
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
