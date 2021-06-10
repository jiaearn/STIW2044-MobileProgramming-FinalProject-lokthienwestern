import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lokthienwestern/view/admin/adminmainscreen.dart';
import 'package:lokthienwestern/view/user/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'registrationscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailnameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _otpController = new TextEditingController();
  TextEditingController _rpasswordController = new TextEditingController();
  TextEditingController _cpasswordController = new TextEditingController();
  SharedPreferences prefs;

  @override
  void initState() {
    loadPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(70, 70, 70, 10),
              height: 250,
              width: 250,
              child: Image.asset("assets/images/logo.jpg"),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(30, 35, 30, 15),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Column(children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextField(
                      controller: _emailnameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email / Username',
                          icon: Icon(Icons.email)),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'Password', icon: Icon(Icons.lock)),
                      obscureText: true,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                            value: _rememberMe,
                            onChanged: (bool value) {
                              _onChange(value);
                            }),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // ignore: missing_required_param
                    MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minWidth: 200,
                        height: 50,
                        child: Text("Login",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                        onPressed: _onLogin,
                        color: Colors.grey[700]),
                    SizedBox(height: 10),
                  ]),
                )),
            GestureDetector(
              child: Text("Register New Account",
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
              onTap: _registerNewAccount,
            ),
            SizedBox(height: 5),
            GestureDetector(
              child: Text("Forget Password",
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
              onTap: _forgetPassword,
            ),
          ],
        ),
      ),
    );
  }

  void _onLogin() {
    String _emailName = _emailnameController.text.toString();
    String _password = _passwordController.text.toString();
    FocusScope.of(context).unfocus();

    if (_emailName.isEmpty && _password.isNotEmpty) {
      Fluttertoast.showToast(
        msg: "Please insert your username/email.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_emailName.isNotEmpty && _password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please insert your password.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_emailName.isEmpty && _password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please insert your username/email and password.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else {
      http.post(
          Uri.parse(
              "https://hubbuddies.com/269509/lokthienwestern/php/login_user.php"),
          body: {
            "username": _emailName,
            "email": _emailName,
            "password": _password
          }).then((response) {
        if (response.body == "Success") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (content) => MainScreen()));
        } 
        else if(response.body == "AdminLogin"){        
            Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (content) => AdminMainScreen()));
        }
        else if (response.body ==
            "Please activate your account via email first.") {
          Fluttertoast.showToast(
            msg: "Please activate your account via email first.",
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      });
    }
  }

  void _registerNewAccount() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (content) => RegistrationScreen()));
  }

  void _forgetPassword() {
    TextEditingController _recoveryemaillcontroller = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Forgot Your Pasword?"),
              content: new Container(
                height: 85,
                child: Column(
                  children: [
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: TextFormField(
                        controller: _recoveryemaillcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email', icon: Icon(Icons.email)),
                        validator: (value) => EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email",
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_recoveryemaillcontroller.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Please insert your recovery email.",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else if (EmailValidator.validate(
                            _recoveryemaillcontroller.text.toString()) ==
                        false) {
                      Fluttertoast.showToast(
                        msg: "Please insert a valid email address",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                      return;
                    } else {
                      _checkOTP(_recoveryemaillcontroller.text);
                    }
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

  void _onChange(bool value) {
    String _emailName = _emailnameController.text.toString();
    String _password = _passwordController.text.toString();

    if (_emailName.isEmpty && _password.isNotEmpty) {
      Fluttertoast.showToast(
        msg: "Please insert your email/username.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_emailName.isNotEmpty && _password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please insert your password.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else if (_emailName.isEmpty && _password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please insert your email/username and password.",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }
    setState(() {
      _rememberMe = value;
      storePref(value, _emailName, _password);
    });
  }

  Future<void> storePref(bool value, String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString("email", email);
      await prefs.setString("password", password);
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
        msg: "Preferences stored",
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    } else {
      await prefs.setString("email", '');
      await prefs.setString("password", '');
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
        msg: "Preferences removed",
        toastLength: Toast.LENGTH_SHORT,
      );
      setState(() {
        _rememberMe = false;
      });
      return;
    }
  }

  Future<void> loadPref() async {
    prefs = await SharedPreferences.getInstance();
    String _email = prefs.getString("email") ?? '';
    String _password = prefs.getString("password") ?? '';
    _rememberMe = prefs.getBool("rememberme") ?? false;

    setState(() {
      _emailnameController.text = _email;
      _passwordController.text = _password;
    });
  }

  void _checkOTP(String emailreset) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/forget_password.php"),
        body: {"email": emailreset}).then((response) {
      if (response.body == "OTP has been successfully sent to the mail.") {
        Fluttertoast.showToast(
          msg: "Please check your email.",
          toastLength: Toast.LENGTH_SHORT,
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Forgot Your Pasword?"),
                  content: new Container(
                    height: 175,
                    child: Column(
                      children: [
                        Text("Insert OTP code that had send to your email."),
                        TextField(
                          maxLength: 6,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _otpController,
                          decoration: InputDecoration(
                              labelText: 'OTP', icon: Icon(Icons.lock)),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (_otpController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please do not leave text fields blank.",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          return;
                        } else if (_otpController.text.toString().length < 6) {
                          Fluttertoast.showToast(
                            msg: "Your otp should be 6 number",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          return;
                        }
                        _resetPassword(_otpController.text);
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
      } else if (response.body ==
          "Please activate your account via email first.") {
        Fluttertoast.showToast(
          msg: "Please activate your account via email first.",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Email not found.",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    });
  }

  void _resetPassword(String otp) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269509/lokthienwestern/php/check_otp.php"),
        body: {"otp": otp}).then((response) {
      if (response.body == "Reset new Password") {
        Fluttertoast.showToast(
          msg: "OTP Correct. Please reset new Password.",
          toastLength: Toast.LENGTH_SHORT,
        );
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text("Reset Pasword"),
                  content: new Container(
                    height: 175,
                    width: 175,
                    child: Column(
                      children: [
                        Text("Reset New password"),
                        TextFormField(
                          controller: _rpasswordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'New Password',
                          ),
                        ),
                        TextFormField(
                          controller: _cpasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            icon: Icon(Icons.lock),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (_rpasswordController.text.isEmpty ||
                            _cpasswordController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please do not leave any text fields blank.",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          return;
                        } else if (_rpasswordController.text !=
                            _cpasswordController.text) {
                          Fluttertoast.showToast(
                            msg:
                                "Your Passwords and Confirm Password do not match.",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          return;
                        } else if (_rpasswordController.text.toString().length <
                            6) {
                          Fluttertoast.showToast(
                            msg:
                                "Your password should be at least 6 characters",
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
                            msg:
                                "Your password should contain at least one number",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                          return;
                        }
                        http.post(
                            Uri.parse(
                                "https://hubbuddies.com/269509/lokthienwestern/php/reset_newpassword.php"),
                            body: {
                              "npassword": _rpasswordController.text.toString(),
                              "otp": otp,
                            }).then((response) {
                          if (response.body == "Reset Sucess") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => LoginScreen()));
                            Fluttertoast.showToast(
                              msg: "Reset Success. Please login again.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Reset Failed",
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
      } else {
        Fluttertoast.showToast(
          msg: "OTP Not Correct, Failed.",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    });
  }
}
