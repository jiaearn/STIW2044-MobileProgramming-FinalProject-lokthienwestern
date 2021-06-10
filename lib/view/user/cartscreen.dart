import 'package:flutter/material.dart';
import 'package:lokthienwestern/widget/appbar.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: Center(
        child: Container(
          child: Text('Nothing inside the cart.'),
        ),
      ),
    );
  }
}
