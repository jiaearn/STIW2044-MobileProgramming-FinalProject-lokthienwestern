import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lokthienwestern/model/address.dart';
import 'package:lokthienwestern/model/payment.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/user/account/addressscreen.dart';
import 'package:lokthienwestern/view/user/checkout/payment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lokthienwestern/widget/loading.dart';

class CheckOutScreen extends StatefulWidget {
  final double total;
  final User user;

  const CheckOutScreen({
    Key key,
    this.total,
    this.user,
  }) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int data = 0;
  int _radioValue = 0;
  bool _statusdel = false;
  bool _statuspickup = true;
  String _selectedtime = "09:00 A.M";
  String _curtime = "";
  double screenHeight, screenWidth;
  String _titlecenter = "";
  List _cartList;
  List _addressList;
  String receiverName = "";
  int radio = 0;

  @override
  void initState() {
    super.initState();
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    _loadAddress();
    _loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String today = DateFormat('hh:mm a').format(now);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text('Payment Checkout',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.only(top: 5),
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Text(
                          "DELIVERY METHOD",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Pickup"),
                            new Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              value: 0,
                              groupValue: _radioValue,
                              onChanged: (int value) {
                                _handleRadioValueChange(value);
                              },
                            ),
                            Text("Delivery"),
                            new Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.black),
                              value: 1,
                              groupValue: _radioValue,
                              onChanged: (int value) {
                                _handleRadioValueChange(value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                Visibility(
                  visible: _statuspickup,
                  child: Container(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            "PICKUP TIME",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            width: 300,
                            child: Text(
                                "Pickup time daily from 9.00 A.M to 7.00 P.M from our store. Please allow 15-30 minutes to prepare your order before pickup time"),
                          ),
                          Row(
                            children: [
                              Expanded(flex: 3, child: Text("Current Time: ")),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 7,
                                child: Text(today),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 3, child: Text("Set Pickup Time: ")),
                              Container(
                                  height: 20,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        _selectedtime,
                                      ),
                                      Container(
                                          child: IconButton(
                                              iconSize: 32,
                                              icon: Icon(Icons.timer),
                                              onPressed: () =>
                                                  {_selectTime(context)})),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _statusdel,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            "DELIVERY ADDRESS",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Column(
                            children: [
                              if (_addressList == null || _addressList.isEmpty)
                                GestureDetector(
                                  onTap: () async {
                                    Address address = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (content) => AddressScreen(
                                                user: widget.user,
                                                chooseAddress: true)));
                                    setState(() {
                                      _loadAddress();
                                      if (_addressList == null ||
                                          _addressList.isEmpty) {
                                        Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              "assets/images/addressnull.png",
                                              height: 150,
                                              width: 150,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                                'Address Is Empty! Tap To Insert!',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            SizedBox(height: 20),
                                          ],
                                        ));
                                        return;
                                      }
                                      address == null
                                          ? data = 0
                                          : data = address.data;
                                    });
                                  },
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/addressnull.png",
                                          height: 150,
                                          width: 150,
                                        ),
                                        SizedBox(height: 10),
                                        Text('Address Is Empty! Tap To Insert!',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                )
                              else
                                data >= _addressList.length
                                    ? Loading()
                                    : Container(
                                        decoration: BoxDecoration(),
                                        child: GridView.count(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            crossAxisCount: 1,
                                            childAspectRatio: 2 / 1,
                                            children: List.generate(1, (index) {
                                              return GestureDetector(
                                                  onTap: () async {
                                                    Address address = await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (content) =>
                                                                AddressScreen(
                                                                    user: widget
                                                                        .user,
                                                                    chooseAddress:
                                                                        true)));
                                                    setState(() {
                                                      _loadAddress();
                                                      if (_addressList ==
                                                              null ||
                                                          _addressList
                                                              .isEmpty) {
                                                        Center(
                                                            child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/addressnull.png",
                                                              height: 150,
                                                              width: 150,
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                                'Address Is Empty! Tap To Insert!',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            SizedBox(
                                                                height: 20),
                                                          ],
                                                        ));
                                                        return;
                                                      }
                                                      address == null
                                                          ? data = 0
                                                          : data = address.data;
                                                    });
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      child: Card(
                                                          child: Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey[800],
                                                                offset: Offset(
                                                                    5.0, 8.0),
                                                                blurRadius: 6.0,
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            color:
                                                                Colors.white),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 9,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: Text(
                                                                          data == null
                                                                              ? _addressList[0][
                                                                                  'name']
                                                                              : _addressList[data][
                                                                                  "name"],
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Text(
                                                                        data == null
                                                                            ? _addressList[0]['phone']
                                                                            : _addressList[data]["phone"],
                                                                        style:
                                                                            TextStyle(
                                                                          height:
                                                                              1.5,
                                                                          fontSize:
                                                                              15,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 3,
                                                                      child:
                                                                          Text(
                                                                        data == null
                                                                            ? titleSub(_addressList[0]['address'])
                                                                            : titleSub(_addressList[data]['address']),
                                                                        style:
                                                                            TextStyle(
                                                                          height:
                                                                              1.5,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ))));
                                            })),
                                      ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "TAP TO CHANGE",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                  height: 2,
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _cartList == null
                        ? Center(
                            child: Container(
                            height: 20.0,
                            child: Text(_titlecenter),
                          ))
                        : GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            childAspectRatio: 2.5 / 1,
                            children: List.generate(_cartList.length, (index) {
                              return Padding(
                                  padding: EdgeInsets.all(3),
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
                                                      "https://hubbuddies.com/269509/lokthienwestern/images/product_pictures/${_cartList[index]['product_id']}.png",
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover),
                                            ],
                                          )),
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
                                                      _cartList[index]
                                                          ['product_name'],
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.fitWidth,
                                                  child: Text(
                                                      _cartList[index]
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
                                                          (int.parse(_cartList[
                                                                          index]
                                                                      [
                                                                      'cartqty']) *
                                                                  double.parse(
                                                                      _cartList[
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
                                                          (int.parse(_cartList[
                                                                      index]
                                                                  ['cartqty']))
                                                              .toStringAsFixed(
                                                                  2),
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
                                                          double.parse(_cartList[
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
                                  )));
                            }),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "TOTAL AMOUNT PAYABLE",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "RM " + widget.total.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      Container(
                        width: screenWidth / 2.5,
                        child: ElevatedButton(
                          onPressed: () {
                            if (radio == 1 && _addressList.length == 0) {
                              Fluttertoast.showToast(
                                  msg: "Please choose an address.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  fontSize: 16.0);
                              return;
                            } else {
                              _paynowDialog();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          child: Text("PAY NOW"),
                        ),
                      )
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          radio = 0;
          _statusdel = false;
          _statuspickup = true;
          setPickupExt();
          print(_statusdel);
          break;
        case 1:
          radio = 1;
          _statusdel = true;
          _statuspickup = false;
          print(_statusdel);
          break;
      }
    });
  }

  void setPickupExt() {
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    setState(() {});
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    final now = new DateTime.now();
    print("NOW: " + now.toString());
    String year = DateFormat('y').format(now);
    String month = DateFormat('M').format(now);
    String day = DateFormat('d').format(now);

    String _hour, _minute, _time = "";
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _selectedtime = _time;
        _curtime = DateFormat("Hm").format(now);

        _selectedtime = formatDate(
            DateTime(int.parse(year), int.parse(month), int.parse(day),
                selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        int ct = _convMin(_curtime);
        int st = _convMin(_time);
        int diff = st - ct;
        if (diff < 30) {
          Fluttertoast.showToast(
              msg: "Invalid time selection",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: 16.0);
          _selectedtime = _minToTime(ct);
          setState(() {});
          return;
        }
      });
  }

  int _convMin(String c) {
    var val = c.split(":");
    int h = int.parse(val[0]);
    int m = int.parse(val[1]);
    int tmin = (h * 60) + m;
    return tmin;
  }

  String _minToTime(int min) {
    var m = min + 30;
    var d = Duration(minutes: m);
    List<String> parts = d.toString().split(':');
    String tm = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    return DateFormat.jm().format(DateFormat("hh:mm").parse(tm));
  }

  void _paynowDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Pay RM ' + widget.total.toStringAsFixed(2) + "?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Payment payment = new Payment(
                          widget.user.email,
                          widget.user.contact,
                          widget.user.fullname,
                          widget.total.toString());
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                              payment: payment, user: widget.user),
                        ),
                      );
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

  _loadAddress() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_address.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No Address";
        _addressList = [];
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _addressList = jsondata["address"];
      }
      setState(() {});
    });
  }

  String titleSub(String title) {
    if (title.length > 120) {
      return title.substring(0, 120) + "...";
    } else {
      return title;
    }
  }

  void _loadcart() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_cart.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "No item";
        _cartList = [];
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _cartList = jsondata["cart"];
      }
      setState(() {});
    });
  }
}
