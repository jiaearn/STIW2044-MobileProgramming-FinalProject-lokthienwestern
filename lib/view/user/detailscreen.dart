import 'package:flutter/material.dart';
import 'package:lokthienwestern/widget/appbar.dart';
import 'package:lokthienwestern/widget/details.dart';
import 'package:lokthienwestern/widget/orderbutton.dart';

class DetailsScreen extends StatelessWidget {
  final productimage;
  final productname;
  final productprice;
  final productdesc;
  final productrating;

  const DetailsScreen(
      {Key key,
      this.productimage,
      this.productname,
      this.productprice,
      this.productdesc,
      this.productrating})
      : super(key: key);

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
                  child: productimage,
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
                children: <Widget>[
                  TitlePriceRating(
                    name: productname,
                    rating: productrating,
                    price: double.parse(productprice),
                    onRatingChanged: (value) {},
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(  
                              productdesc,
                              style: TextStyle(
                                height: 1.5,
                                fontSize: 15,
                              ),
                              maxLines:5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OrderButton(
        size: size,
        press: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
