import 'package:flutter/material.dart';
import 'package:lokthienwestern/model/detail.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/widget/appbar.dart';
import 'package:lokthienwestern/widget/details.dart';
import 'package:lokthienwestern/widget/orderbutton.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DetailsScreen extends StatefulWidget {
  final Detail detail;
  final User user;
  const DetailsScreen({
    Key key,
    this.user,
    this.detail,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: detailsAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: screenWidth,
              height: 1 / 3 * screenHeight,
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: '',
                  child: widget.detail.productimage,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 2 / 3 * screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Details(
                    name: widget.detail.productname,
                    rating: widget.detail.productrating,
                    price: double.parse(widget.detail.productprice),
                    onRatingChanged: (value) {},
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.detail.productdesc,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OrderButton(
        size: size,
        press: () {
          _addtocart();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _addtocart() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Add to cart"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/add_cart.php"),
        body: {
          "email": widget.user.email,
          "product_id": widget.detail.productid
        }).then((response) {
      if (response.body == "Failed") {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        Navigator.pop(context);
      }
    });
    progressDialog.dismiss();
  }
}
