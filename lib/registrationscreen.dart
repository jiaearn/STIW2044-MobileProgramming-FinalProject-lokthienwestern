import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _cpasswordController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();
  double screenHeight, screenWidth;
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(70, 70, 70, 10),
              height: 250,
              width: 250,
              child: Image.asset("assets/images/logo.jpg"),
            ),
            Card(
              color: Colors.grey,
              margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: [
                    Text(
                      'Registration',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'No uppercase & special characters',
                          icon: Icon(Icons.person)),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(Icons.email)),
                        validator: (value) => EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email",
                      ),
                    ),
                    TextFormField(
                      obscureText: _isObscure,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '1 lowercase & 1 number',
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                    ),
                    TextFormField(
                      obscureText: _isObscure2,
                      controller: _cpasswordController,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: 'Match with Password',
                          icon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              })),
                    ),
                    TextFormField(
                      controller: _contactController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          labelText: 'Contact No.',
                          hintText: '10 <= Length <= 13',
                          icon: Icon(Icons.phone)),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minWidth: 200,
                        height: 50,
                        child: Text("Register",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                        onPressed: _onRegister,
                        color: Colors.grey[700]),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Text("Already Register?",
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              onTap: _alreadyRegister,
            ),
            SizedBox(height: 15),
          ],
        ),
      )),
    );
  }

  void _alreadyRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  void _onRegister() {
    String _username = _usernameController.text.toString();
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    String _cpassword = _cpasswordController.text.toString();
    String _contact = _contactController.text.toString();
    FocusScope.of(context).unfocus();

    if (_username.isEmpty ||
        _email.isEmpty ||
        _password.isEmpty ||
        _cpassword.isEmpty ||
        _contact.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please do not leave any text fields blank.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_username.contains(RegExp(r'[A-Z]'))) {
      Fluttertoast.showToast(
        msg: "Your username should not contain upper case",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_username.contains(RegExp(r'[a-z]')) == false) {
      Fluttertoast.showToast(
        msg: "Your username should contain at least one lower case",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_username.contains(RegExp(r'[!@#$%^&*(),.?":{}|<> ]'))) {
      Fluttertoast.showToast(
        msg: "Your username should not contain special character",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (EmailValidator.validate(_email) == false) {
      Fluttertoast.showToast(
        msg: "Please insert a valid email address.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_password != _cpassword) {
      Fluttertoast.showToast(
        msg: "Your Passwords and Confirm Password do not match.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_password.length < 6) {
      Fluttertoast.showToast(
        msg: "Your password should be at least 6 characters",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_password.contains(RegExp(r'[a-z]')) == false) {
      Fluttertoast.showToast(
        msg: "Your password should contain at least one lower case",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_password.contains(RegExp(r'[0-9]')) == false) {
      Fluttertoast.showToast(
        msg: "Your password should contain at least one number",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_password.contains(RegExp(r'[ ]'))) {
      Fluttertoast.showToast(
        msg: "Your password should not contain space",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_contact.length < 10 || _contact.length > 13) {
      Fluttertoast.showToast(
        msg: "Invalid phone length",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Register new user"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_username, _email, _password, _contact);
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

  void _registerUser(
      String username, String email, String password, String contact) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/register_user.php"),
        body: {
          "username": username,
          "email": email,
          "password": password,
          "contact": contact
        }).then((response) {
      if (response.body == "Success") {
        Fluttertoast.showToast(
          msg:
              "Registration Success. Please check your email for verification link.",
          toastLength: Toast.LENGTH_SHORT,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => LoginScreen()));
      } else if (response.body == "Email Already Exists.") {
        Fluttertoast.showToast(
          msg: "Email Already Exists. Please insert again.",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else if (response.body == "Username Already Exists.") {
        Fluttertoast.showToast(
          msg: "Username Already Exists. Please insert again.",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Registration Failed",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    });
  }
}
