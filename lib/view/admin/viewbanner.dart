import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/widget/loading.dart';
import 'package:ndialog/ndialog.dart';

class ViewBanner extends StatefulWidget {
  const ViewBanner({
    Key key,
  }) : super(key: key);
  @override
  _ViewBannerState createState() => _ViewBannerState();
}

class _ViewBannerState extends State<ViewBanner> {
  double screenHeight, screenWidth;
  List _bannerList;

  @override
  void initState() {
    _loadBanner();
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
        title: Text('View Banner',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: Center(
        child: Column(children: [
          _bannerList?.length == null
              ? Flexible(
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Loading()],
                  ),
                ))
              : Flexible(
                  child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      itemCount: _bannerList.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1.5 / 1),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteBannerDialog(index);
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl:
                                            "https://hubbuddies.com/269509/lokthienwestern/images/banner_pictures/${_bannerList[index]['banner_id']}.png",
                                        height: 150,
                                        width: 250,
                                        fit: BoxFit.cover),
                                    SizedBox(height: 5),
                                    Text(
                                      _bannerList[index]['banner_name'],
                                      style: TextStyle(
                                        height: 1.5,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                )),
        ]),
      ),
    );
  }

  void _loadBanner() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/load_banner.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        setState(() {});
        return;
      } else {
        var jsondata = json.decode(response.body);
        _bannerList = jsondata["banner"];
        setState(() {});
      }
    });
  }

  void _deleteBannerDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete this banner?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteBanner(index);
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

  Future<void> _deleteBanner(int index) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Delete banner"), title: Text("Progress..."));
    progressDialog.show();
    await Future.delayed(Duration(seconds: 1));
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/delete_banner.php"),
        body: {"banner_id": _bannerList[index]['banner_id']}).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
            msg: "Success", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        _loadBanner();
      } else {
        Fluttertoast.showToast(
            msg: "Failed", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
      }
      progressDialog.dismiss();
    });
  }
}
