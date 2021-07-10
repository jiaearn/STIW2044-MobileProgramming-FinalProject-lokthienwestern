import 'package:flutter/material.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lokthienwestern/view/loginscreen.dart';
import 'package:lokthienwestern/view/user/account/addressscreen.dart';
import 'package:lokthienwestern/view/user/account/editprofilescreen.dart';
import 'package:lokthienwestern/view/user/account/historyscreen.dart';

class AccountScreen extends StatefulWidget {
  final User user;
  const AccountScreen({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController _curpasswordController = new TextEditingController();
  TextEditingController _rpasswordController = new TextEditingController();
  TextEditingController _conpasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.black,
        title: Text('Lok Thien Western',
            style: TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontFamily: "Samantha")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 0.0, top: 20.0, bottom: 10.0),
                    child: Text("Account",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black)),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Edit Profile"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          _editProfile(widget.user);
                        }),
                    ListTile(
                        leading: Icon(Icons.lock),
                        title: Text("Change password"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          _changePassword();
                        }),
                    ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text("My Address"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (content) => AddressScreen(
                                          user: widget.user,
                                          chooseAddress: false)))
                              .then((_) => setState(() {}));
                        }),
                    ListTile(
                        leading: Icon(Icons.history),
                        title: Text("Purchase History"),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (content) => HistoryScreen(
                                        user: widget.user,
                                      ))).then((_) => setState(() {}));
                        }),
                  ])),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: <Widget>[
                    ListTile(
                        leading: Text(""),
                        title: Text("Log Out"),
                        trailing: Icon(Icons.logout, color: Colors.red),
                        onTap: () {
                          _logOut();
                        }),
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _editProfile(User user) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to edit profile?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) =>
                                EditProfileScreen(user: user)));
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(),
                  )),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _changePassword() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to change password?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _resetPassword();
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(),
                  )),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> _logOut() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to log out?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (content) => LoginScreen()));
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(),
                  )),
            ],
          ),
        ) ??
        false;
  }

  void _resetPassword() {
    _curpasswordController.clear();
    _rpasswordController.clear();
    _conpasswordController.clear();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Change Pasword"),
              content: new Container(
                height: 200,
                width: 175,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _curpasswordController,
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                      ),
                    ),
                    TextFormField(
                      controller: _rpasswordController,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                      ),
                    ),
                    TextFormField(
                      controller: _conpasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_curpasswordController.text.isEmpty ||
                        _rpasswordController.text.isEmpty ||
                        _conpasswordController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please do not leave any text fields blank.",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else if (_rpasswordController.text !=
                        _conpasswordController.text) {
                      Fluttertoast.showToast(
                        msg:
                            "Your Passwords and Confirm Password do not match.",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else if (_rpasswordController.text.toString().length <
                        6) {
                      Fluttertoast.showToast(
                        msg: "Your password should be at least 6 characters",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else if (_rpasswordController.text
                            .toString()
                            .contains(RegExp(r'[a-z]')) ==
                        false) {
                      Fluttertoast.showToast(
                        msg:
                            "Your password should contain at least one lower case",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else if (_rpasswordController.text
                            .toString()
                            .contains(RegExp(r'[0-9]')) ==
                        false) {
                      Fluttertoast.showToast(
                        msg: "Your password should contain at least one number",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else if (_rpasswordController.text
                        .toString()
                        .contains(RegExp(r'[ ]'))) {
                      Fluttertoast.showToast(
                        msg: "Your password should not contain space",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    }
                    http.post(
                        Uri.parse(
                            "https://hubbuddies.com/269509/lokthienwestern/php/reset_newpassword.php"),
                        body: {
                          "email": widget.user.email,
                          "npassword": _rpasswordController.text.toString(),
                          "curpassword": _curpasswordController.text.toString(),
                          "status": "update",
                        }).then((response) {
                      if (response.body == "Update Success") {
                        Fluttertoast.showToast(
                          msg: "Update Success",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                        Navigator.pop(context);
                      } else {
                        Fluttertoast.showToast(
                          msg: "Update Failed",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      }
                    });
                  },
                ),
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}
