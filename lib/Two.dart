import 'package:flutter/material.dart';

class TwoPage extends StatefulWidget {
  @override
  _TwoPageState createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TwoPage"),
      ),
      body: Center(
        child: Text("TwoPage",style: TextStyle(fontSize: 28),),
      ),
    );
  }
}
