import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lokthienwestern/view/user/detailscreen.dart';
import 'package:lokthienwestern/view/user/food_cate_screen.dart';
import 'package:lokthienwestern/widget/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class FoodCateg extends StatefulWidget {
  final productcateg;

  const FoodCateg({Key key, this.productcateg}) : super(key: key);

  @override
  _FoodCategState createState() => _FoodCategState();
}

class _FoodCategState extends State<FoodCateg> {
  List _categoryList;

  @override
  void initState() {
    super.initState();
    _loadCateg(widget.productcateg);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    if (_categoryList == null) {
      return Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      ));
    } else if (_categoryList?.length == 1) {
      return Container(
        height: 100,
        child: Row(
          children: [
            SizedBox(width: 35),
            Expanded(
              child: GridView.count(
                  primary: false,
                  crossAxisCount: 2,
                  childAspectRatio: (screenWidth / screenHeight) / 0.2,
                  children: [
                    ...List.generate(1, (index) {
                      return _gestureDetector1(index);
                    }),
                    _moreButton1(),
                  ]),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 100,
        child: GridView.count(
            primary: false,
            crossAxisCount: 3,
            childAspectRatio: (screenWidth / screenHeight) / 0.3,
            children: [
              ...List.generate(2, (index) {
                return _gestureDetector2(index);
              }),
              _moreButton2(),
            ]),
      );
    }
  }

  Widget _moreButton1() {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) =>
                      FoodCategScreen(productcateg: widget.productcateg)))
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: 130,
              height: 160,
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
                        child: Image.asset("assets/images/more.png"),
                      )
                    ],
                  )),
            ),
            Positioned.fill(
              left: 2,
              right: 48,
              child: Container(
                width: 140,
                height: 150,
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
            ),
            Positioned.fill(
                top: 21,
                left: 35,
                child: Text(
                  "More...",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                )),
          ],
        ),
      ),
    );
  }

  Widget _gestureDetector1(index) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => DetailsScreen(
                      productimage: CachedNetworkImage(
                        imageUrl:
                            "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[index]['product_id']}.png",
                        fit: BoxFit.cover,
                      ),
                      productname: _categoryList[index]['product_name'],
                      productprice: _categoryList[index]['product_price'],
                      productdesc: _categoryList[index]['product_desc'],
                      productrating: _categoryList[index]['product_rating'],
                    )))
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            width: 130,
            height: 160,
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
                            "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[index]['product_id']}.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                )),
          ),
          Positioned.fill(
            left: 2,
            right: 50,
            child: Container(
              width: 140,
              height: 150,
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
          ),
          Positioned.fill(
              top: 21,
              left: 35,
              child: Text(
                titleSub(_categoryList[index]['product_name']),
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              )),
        ],
      ),
    );
  }

  Widget _moreButton2() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) =>
                      FoodCategScreen(productcateg: widget.productcateg)))
        },
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: 140,
              height: 160,
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
                        child: Image.asset("assets/images/more.png"),
                      )
                    ],
                  )),
            ),
            Container(
              width: 140,
              height: 150,
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
                      "More...",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget _gestureDetector2(index) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (content) => DetailsScreen(
                      productimage: CachedNetworkImage(
                        imageUrl:
                            "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[index]['product_id']}.png",
                        fit: BoxFit.cover,
                      ),
                      productname: _categoryList[index]['product_name'],
                      productprice: _categoryList[index]['product_price'],
                      productdesc: _categoryList[index]['product_desc'],
                      productrating: _categoryList[index]['product_rating'],
                    )))
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              width: 140,
              height: 160,
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
                              "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_categoryList[index]['product_id']}.png",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              width: 140,
              height: 150,
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
                      titleSub(_categoryList[index]['product_name']),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ))),
          ],
        ),
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
    if (title.length > 6) {
      return title.substring(0, 6) + "...";
    } else {
      return title;
    }
  }
}
