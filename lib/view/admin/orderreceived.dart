import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/widget/loading.dart';
import 'package:ndialog/ndialog.dart';

class OrderReceived extends StatefulWidget {
  const OrderReceived({
    Key key,
  }) : super(key: key);

  @override
  _OrderReceivedState createState() => _OrderReceivedState();
}

class _OrderReceivedState extends State<OrderReceived> {
  String _titlecenter = "";
  List _historyList = [];
  String status;

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
        title: Text('Order Received',
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
                          Text('Order Is Empty!',
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
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _statusSimpleDialog(
                                                          index, context);
                                                    },
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
                                                                color: Colors
                                                                    .green,
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
        body: {"email": "admin"}).then((response) {
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

  _statusSimpleDialog(int index, BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select Status'),
            children: <Widget>[
              SizedBox(height: 5),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  status = "DONE";
                  _updateStatusDialog(index, status);
                },
                child: Text('DONE'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    status = "CANCEL";
                    _updateStatusDialog(index, status);
                  });
                },
                child: Text('CANCEL'),
              ),
            ],
          );
        });
  }

  void _updateStatusDialog(int index, String status) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Update status?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _updateStatus(index, status);
                },
              ),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  Future<void> _updateStatus(int index, String status) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Update Status"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/update_status.php"),
        body: {
          "order_id": _historyList[index]['orderid'],
          "status": status,
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadHistory();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }
}
