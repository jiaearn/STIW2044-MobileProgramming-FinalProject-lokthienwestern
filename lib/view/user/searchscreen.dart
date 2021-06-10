import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokthienwestern/view/user/detailscreen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List _productList;
  String _titlecenter = "Search by Product Name.";
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
        leading: BackButton(),
        title: _searchTextField(),
        actions: _buildActions(),
      ),
      body: SafeArea(
        child: Column(children: [
          _productList == null
              ? Flexible(
                  child: Center(
                      child: Text(_titlecenter,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.normal))),
                )
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
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                          childAspectRatio:
                                              (screenWidth / screenHeight) /
                                                  0.6),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            width: 1.5,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 5, 0),
                                                  child: Text(
                                                      titleSub(
                                                          _productList[index]
                                                              ['product_name']),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 10, 5, 0),
                                                  child: Text(
                                                    "Price: RM " +
                                                        _productList[index]
                                                            ['product_price'],
                                                    style:
                                                        TextStyle(fontSize: 16),
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
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (content) =>
                                                                  DetailsScreen(
                                                                    productimage:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_productList[index]['product_id']}.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                    productname:
                                                                        _productList[index]
                                                                            [
                                                                            'product_name'],
                                                                    productprice:
                                                                        _productList[index]
                                                                            [
                                                                            'product_price'],
                                                                    productdesc:
                                                                        _productList[index]
                                                                            [
                                                                            'product_desc'],
                                                                    productrating:
                                                                        _productList[index]
                                                                            [
                                                                            'product_rating'],
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
            _titlecenter = "Search by Product Name.";
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
            setState(() {
              _loadProducts("null");
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

  void _loadProducts(String _productname) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_products.php?"),
        body: {"product_name": _productname}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Not available in Lok Thien Western.";
        _productList = null;
        setState(() {});
        return;
      } 
      else if(response.body == "nullnodata"){
        _titlecenter = "Search by Product Name.";
        _productList = null;
        setState(() {});
        return;
      }
      else {
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
