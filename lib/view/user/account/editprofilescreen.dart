import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _fullnameController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      buildTextField(
                          "Username", widget.user.username, "username"),
                      buildTextField("E-mail", widget.user.email, "email"),
                      buildTextField(
                          "Full Name", widget.user.fullname, "fullname"),
                      GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _genderSimpleDialog(context);
                          },
                          child: buildTextField(
                              "Gender", widget.user.gender, "gender")),
                      buildTextField("Contact", widget.user.contact, "contact"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () {
                          _updateprofile();
                        },
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, String textField) {
    if (textField == "fullname") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
          controller: _fullnameController,
        ),
      );
    } else if (textField == "contact") {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
          controller: _contactController,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              )),
        ),
      );
    }
  }

  _genderSimpleDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select Gender'),
            children: <Widget>[
              SizedBox(height: 5),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    widget.user.gender = "Male";
                  });
                  Navigator.pop(context, "Male");
                },
                child: Text('Male'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setState(() {
                    widget.user.gender = "Female";
                  });
                  Navigator.pop(context, "Male");
                },
                child: Text('Female'),
              ),
            ],
          );
        });
  }

  _updateprofile() {
    String _fullname = _fullnameController.text.toString();
    String _contact = _contactController.text.toString();

    if (_fullname.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>~]'))) {
      Fluttertoast.showToast(
        msg: "Full name should not contain special character",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_fullname.contains(RegExp(r'[0-9]'))) {
      Fluttertoast.showToast(
        msg: "Full name should not contain number",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if ((_contact.length < 10 || _contact.length > 13) &&
        _contact != "") {
      Fluttertoast.showToast(
        msg: "Invalid phone length",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else {
      if (_contact == "" &&
          _fullname != "") //fullname change and contact unchange
      {
        http.post(
            Uri.parse(
                "https://hubbuddies.com/269509/lokthienwestern/php/update_profile.php"),
            body: {
              "email": widget.user.email,
              "fullname": _fullname.toUpperCase(),
              "contact": widget.user.contact,
              "gender": widget.user.gender,
            }).then((response) {
          if (response.body == "Success") {
            FocusScope.of(context).unfocus();
            Fluttertoast.showToast(
                msg: "Success.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {
              widget.user.fullname = _fullname.toUpperCase();
            });
            return;
          } else {
            Fluttertoast.showToast(
                msg: "Please Try Again.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {});
          }
        });
      } else if (_fullname == "" &&
          _contact != "") //fullname unchange and contact change
      {
        http.post(
            Uri.parse(
                "https://hubbuddies.com/269509/lokthienwestern/php/update_profile.php"),
            body: {
              "email": widget.user.email,
              "fullname": widget.user.fullname,
              "contact": _contact,
              "gender": widget.user.gender,
            }).then((response) {
          if (response.body == "Success") {
            FocusScope.of(context).unfocus();
            Fluttertoast.showToast(
                msg: "Success.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {
              widget.user.contact = _contact;
            });
            return;
          } else {
            Fluttertoast.showToast(
                msg: "Please Try Again.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {});
          }
        });
      } else if (_contact != "" &&
          _fullname != "") //contact and fullname change
      {
        http.post(
            Uri.parse(
                "https://hubbuddies.com/269509/lokthienwestern/php/update_profile.php"),
            body: {
              "email": widget.user.email,
              "fullname": _fullname.toUpperCase(),
              "contact": _contact,
              "gender": widget.user.gender,
            }).then((response) {
          if (response.body == "Success") {
            FocusScope.of(context).unfocus();
            Fluttertoast.showToast(
                msg: "Success.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {
              widget.user.contact = _contact;
              widget.user.fullname = _fullname.toUpperCase();
            });
            return;
          } else {
            Fluttertoast.showToast(
                msg: "Please Try Again.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {});
          }
        });
        return;
      } else {
        http.post(
            Uri.parse(
                "https://hubbuddies.com/269509/lokthienwestern/php/update_profile.php"),
            body: {
              "email": widget.user.email,
              "fullname": widget.user.fullname,
              "contact": widget.user.contact,
              "gender": widget.user.gender,
            }).then((response) {
          if (response.body == "Success") {
            FocusScope.of(context).unfocus();
            Fluttertoast.showToast(
                msg: "Success.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {});
            return;
          } else {
            Fluttertoast.showToast(
                msg: "Please Try Again.",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 16.0);
            setState(() {});
          }
        });
      }
    }
  }
}
