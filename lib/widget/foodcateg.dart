import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lokthienwestern/model/detail.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/user/home/food_cate_screen.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class FoodCateg extends StatefulWidget {
  final User user;
  final productcateg;

  const FoodCateg({
    Key key,
    this.productcateg,
    this.user,
  }) : super(key: key);

  @override
  _FoodCategState createState() => _FoodCategState();
}

class _FoodCategState extends State<FoodCateg> {
  List _categoryList;
  Detail detail;
  @override
  void initState() {
    super.initState();
    _loadCateg(widget.productcateg);
  }

  @override
  Widget build(BuildContext context) {
    if (_categoryList == null) {
      return Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      ));
    } else {
      return Container(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => FoodCategScreen(
                          user: widget.user,
                          productcateg: widget.productcateg)));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 280,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                          Center(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[0]['product_id']}.png",
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.025),
                        ],
                      )),
                ),
                Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.productcateg,
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Samantha"),
                        ))),
              ],
            ),
          ),
        ),
      );
    }
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
}
