import 'package:flutter/material.dart';
import 'package:lokthienwestern/view/admin/adminhomescreen.dart';
import 'package:lokthienwestern/view/admin/newproduct.dart';
import 'package:lokthienwestern/view/user/settingscreen.dart';
import 'package:lokthienwestern/widget/appbar.dart';

class AdminMainScreen extends StatefulWidget {
  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  
  static const List<Widget> _pages = <Widget>[
    AdminHomeScreen(),
    NewProduct(),
    SettingScreen(),
  ];

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: adminHomeAppBar(context),
      body: Container(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 35),
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
        ),
        child: FloatingActionButton(
            onPressed: () {
              _onItemTapped(1);
            },
            backgroundColor: Colors.black,
            tooltip: 'Add Product',
            child: Icon(
              Icons.add,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
