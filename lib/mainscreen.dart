import 'package:flutter/material.dart';
 
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lok Thien Western'),
        ),
        body: Center(
          child: Container(
            child: Text('Welcome to Lok Thien Western.'),
          ),
        ),
      ),
    );
  }
}