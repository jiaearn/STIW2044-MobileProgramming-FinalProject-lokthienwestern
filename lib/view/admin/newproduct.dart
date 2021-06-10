import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({
    Key key,
  }) : super(key: key);
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  ProgressDialog pd;
  double screenHeight, screenWidth;
  File _image;
  String pathAsset = 'assets/images/uploadLogo.png';

  TextEditingController _prname = new TextEditingController();
  TextEditingController _prprice = new TextEditingController();
  TextEditingController _prcateg = new TextEditingController();
  TextEditingController _prdesc = new TextEditingController();
  TextEditingController _prrating = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Text("Add New Product",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () => {_onPictureSelectionDialog()},
                  child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image == null
                                ? AssetImage(pathAsset)
                                : FileImage(_image),
                            fit: BoxFit.scaleDown,
                          ),
                          border: Border.all(
                            width: 3.0,
                            color: Colors.grey,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0)))),
                ),
                SizedBox(height: 10),
                Text("Click image to take/upload your product picture.",
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
                          ),
                        ),
                        TextFormField(
                          controller: _prcateg,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Product Category',
                          ),
                        ),
                        TextFormField(
                          controller: _prdesc,
                          minLines: 7,
                          maxLines: 7,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: 'Product Description',
                          ),
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
                          ),
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
                        child: Text("Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        onPressed: _submitProductDialog,
                        color: Colors.black),
                  ],
                )),
              ],
            ))),
      ),
    );
  }

  _onPictureSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: new Container(
              height: screenHeight / 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Take picture from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Camera',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.black,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseCamera()},
                      )),
                      SizedBox(width: 10),
                      Flexible(
                          child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Text('Gallery',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        color: Colors.black,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseGallery()},
                      )),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }

    _cropImage();
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    _cropImage();
  }

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.blueAccent[400],
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _submitProductDialog() {
    String prname = _prname.text.toString();
    String prcateg = _prcateg.text.toString();
    String prprice = _prprice.text.toString();
    String prdesc = _prdesc.text.toString();
    String prrating = _prrating.text.toString();
    if (_image == null ||
        prname == "" ||
        prcateg == "" ||
        prprice == "" ||
        prdesc == "" ||
        prrating == "") {
      Fluttertoast.showToast(
        msg: "Image OR Textfield is empty!",
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
            title: Text("Add your product?"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _postProduct();
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

  Future<void> _postProduct() async {
    pd = ProgressDialog(context);
    pd.style(
      message: 'Posting...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    pd = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pd.show();
    String base64Image = base64Encode(_image.readAsBytesSync());
    String prname = _prname.text.toString();
    String prcateg = _prcateg.text.toString();
    String prprice = _prprice.text.toString();
    String prdesc = _prdesc.text.toString();
    String prrating = _prrating.text.toString();
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/new_product.php"),
        body: {
          "product_name": prname,
          "product_price": prprice,
          "product_categ": prcateg,
          "product_desc": prdesc,
          "product_rating": prrating,
          "encoded_string": base64Image
        }).then((response) {
      pd.hide().then((isHidden) {});
      if (response.body == "Success") {
        Fluttertoast.showToast(
          msg: "Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    });
  }
}
