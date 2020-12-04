import 'package:flutter/material.dart';

class OnePage extends StatefulWidget {
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OnePage"),
      ),
      body: Center(
        child: Text("OnePage",style: TextStyle(fontSize: 28),),
      ),
    );
  }
}
