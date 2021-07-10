import 'package:flutter/material.dart';
import 'package:lokthienwestern/model/user.dart';
import 'package:lokthienwestern/view/loginscreen.dart';
import 'package:lokthienwestern/view/user/menu/menuscreen.dart';
import 'package:lokthienwestern/view/user/home/homescreen.dart';
import 'package:lokthienwestern/view/user/account/accountscreen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key key, this.user}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages;
  int cartitem;
  @override
  void initState() {
    _pages = <Widget>[
      HomeScreen(user: widget.user),
      MenuScreen(user: widget.user),
      AccountScreen(user: widget.user),
    ];
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _logOut,
      child: Scaffold(
        body: Container(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Menu"),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity), label: "Account"),
          ],
          currentIndex: _selectedIndex,
          selectedFontSize: 15,
          selectedIconTheme: IconThemeData(color: Colors.black, size: 35),
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          onTap: _onItemTapped,
        ),
      ),
    );
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
}
