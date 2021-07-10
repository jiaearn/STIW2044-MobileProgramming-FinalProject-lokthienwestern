import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/model/detail.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/user/menu/detailscreen.dart';
import 'package:lokthienwestern/view/user/mainscreen.dart';
import 'package:lokthienwestern/widget/loading.dart';

class FoodCategScreen extends StatefulWidget {
  final User user;
  final productcateg;

  const FoodCategScreen({
    Key key,
    this.productcateg,
    this.user,
  }) : super(key: key);
  @override
  _FoodCategScreenState createState() => _FoodCategScreenState();
}

class _FoodCategScreenState extends State<FoodCategScreen> {
  List _categoryList;
  double screenHeight, screenWidth;
  Detail detail;
  int cartitem;

  @override
  void initState() {
    super.initState();
    _loadCateg(widget.productcateg);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(user: widget.user)));
            }),
        centerTitle: true,
        title: Text(widget.productcateg,
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(children: [
          _categoryList?.length == null
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
                      itemCount: _categoryList.length,
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
                                            "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[index]['product_id']}.png",
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
                                          titleSub(_categoryList[index]
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
                                            _categoryList[index]
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
                                        productid: _categoryList[index]
                                            ['product_id'],
                                        productimage: CachedNetworkImage(
                                          imageUrl:
                                              "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[index]['product_id']}.png",
                                          fit: BoxFit.cover,
                                        ),
                                        productname: _categoryList[index]
                                            ['product_name'],
                                        productprice: _categoryList[index]
                                            ['product_price'],
                                        productdesc: _categoryList[index]
                                            ['product_desc'],
                                        productrating: _categoryList[index]
                                            ['product_rating'],
                                      ),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (content) =>
                                                  DetailsScreen(
                                                    detail: detail,
                                                    user: widget.user,
                                                  )))
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

  void _loadCateg(String _productcateg) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_categ.php"),
        body: {"product_categ": _productcateg}).then((response) {
      if (response.body == "nodata") {
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _categoryList = jsondata["products"];
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
