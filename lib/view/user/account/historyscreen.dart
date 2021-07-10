import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/widget/loading.dart';

class HistoryScreen extends StatefulWidget {
  final User user;

  const HistoryScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _titlecenter = "";
  List _historyList = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Purchased History',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: Center(
        child: Column(
          children: [
            if (_historyList.isEmpty)
              Flexible(
                  child: Center(
                child: _titlecenter == ""
                    ? Loading()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/purchasehistory.png",
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(height: 10),
                          Text('Purchased History Is Empty!',
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
                  decoration: BoxDecoration(),
                  child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2 / 1,
                      children: List.generate(_historyList.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(3),
                            child: Card(
                                child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                    _historyList[index]
                                                            ['orderid']
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  "(" +
                                                      titleSub(_historyList[
                                                              index]
                                                          ['date_created']) +
                                                      ")",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Status :",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                      _historyList[index]['status']
                                                          .toUpperCase(),
                                                      style: _historyList[index]['status']
                                                                      .toUpperCase() ==
                                                                  "PAID" ||
                                                              _historyList[index]['status']
                                                                      .toUpperCase() ==
                                                                  "DONE"
                                                          ? TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)
                                                          : TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .red[500],
                                                              fontWeight:
                                                                  FontWeight.bold)),
                                                ),
                                              ],
                                            ),
                                          ])),
                                  Expanded(
                                    flex: 7,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                  imageUrl:
                                                      "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_historyList[index]['product_id']}.png",
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover),
                                            ],
                                          ),
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
                                                      _historyList[index]
                                                          ['product_name'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                      _historyList[index]
                                                          ['product_categ'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .normal)),
                                                ),
                                                SizedBox(height: 15),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "RM " +
                                                          (int.parse(_historyList[
                                                                          index]
                                                                      [
                                                                      'history_qty']) *
                                                                  double.parse(
                                                                      _historyList[
                                                                              index]
                                                                          [
                                                                          'product_price']))
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      "Qty: " +
                                                          (int.parse(_historyList[
                                                                      index][
                                                                  'history_qty']))
                                                              .toStringAsFixed(
                                                                  0),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Subtotal: RM " +
                                                          double.parse(_historyList[
                                                                      index][
                                                                  'product_price'])
                                                              .toStringAsFixed(
                                                                  2),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )));
                      })),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String titleSub(String title) {
    if (title.length > 19) {
      return title.substring(0, 19);
    } else {
      return title;
    }
  }

  _loadHistory() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_history.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _historyList = [];
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _historyList = jsondata["history"];
      }
      setState(() {});
    });
  }
}
