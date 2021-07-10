import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/model/product.dart';
import 'package:ndialog/ndialog.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  double screenHeight, screenWidth;

  TextEditingController _prname = new TextEditingController();
  TextEditingController _prprice = new TextEditingController();
  TextEditingController _prcateg = new TextEditingController();
  TextEditingController _prdesc = new TextEditingController();
  TextEditingController _prrating = new TextEditingController();

  @override
  void initState() {
    _prname.text = widget.product.productname;
    _prprice.text = widget.product.productprice;
    _prcateg.text = widget.product.productcateg;
    _prdesc.text = widget.product.productdesc;
    _prrating.text = widget.product.productrating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.black,
        title: Text('Edit Product',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: Container(
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 3.0,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Hero(
                        tag: '',
                        child: widget.product.productimage,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Cannot edit your product picture.",
                    style: TextStyle(fontSize: 12.0, color: Colors.black)),
                SizedBox(height: 25),
                Card(
                  color: Colors.grey[250],
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _prname,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextFormField(
                          controller: _prprice,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                          ],
                          decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        TextFormField(
                          controller: _prcateg,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Product Category',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        TextFormField(
                          controller: _prdesc,
                          minLines: 7,
                          maxLines: 7,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              labelText: 'Product Description',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        TextFormField(
                          controller: _prrating,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              labelText: 'Product Rating',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minWidth: 200,
                        height: 50,
                        child: Text("Update",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        onPressed: _updateProductDialog,
                        color: Colors.black),
                  ],
                )),
              ],
            ))),
      ),
    );
  }

  void _updateProductDialog() {
    String prname = _prname.text.toString();
    String prcateg = _prcateg.text.toString();
    String prprice = _prprice.text.toString();
    String prdesc = _prdesc.text.toString();
    String prrating = _prrating.text.toString();
    if (prname == "" ||
        prcateg == "" ||
        prprice == "" ||
        prdesc == "" ||
        prrating == "") {
      Fluttertoast.showToast(
        msg: "Textfield is empty!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      return;
    } else if (prname.contains(RegExp(r'[0-9]'))) {
      Fluttertoast.showToast(
        msg: "Your product name should not contain number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      return;
    } else if (prname.contains(RegExp(r'[!@#$%^&*(),.?":{}|<> ]'))) {
      Fluttertoast.showToast(
        msg: "Your product name should not contain special character",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      return;
    } else if (prcateg.contains(RegExp(r'[!@#$%^&*(),.?":{}|<> ]'))) {
      Fluttertoast.showToast(
        msg: "Your product catogory should not contain special character",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      return;
    } else if (double.parse(prrating) > 5 || double.parse(prrating) < 1) {
      Fluttertoast.showToast(
        msg: "Your product rating should between 1 to 5",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Update your product?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _editProduct();
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

  Future<void> _editProduct() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Edit product"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    String prname = _prname.text.toString();
    String prcateg = _prcateg.text.toString();
    String prprice = _prprice.text.toString();
    String prdesc = _prdesc.text.toString();

    String prrating = _prrating.text.toString();
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/update_product.php"),
        body: {
          "product_id": widget.product.productid,
          "product_name": prname,
          "product_price": prprice,
          "product_categ": prcateg,
          "product_desc": prdesc,
          "product_rating": prrating,
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }
}
