import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobpush_plugin/mobpush_custom_message.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'One.dart';
import 'Two.dart';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MobPushPage(),
    );
  }
}

class MobPushPage extends StatefulWidget {
  @override
  _MobPushPageState createState() => _MobPushPageState();
}

class _MobPushPageState extends State<MobPushPage> {

  String _content = "MobPush";
  String _content1 = "";

  @override
  void initState() {
    super.initState();
    _initMZMobPush();
    _initMobPush();
  }

  _initMZMobPush() {
    const eventChannelName = "MZMobPush_EventChannel";
    const EventChannel eventChannel = EventChannel(eventChannelName);
    const methodChannelName = "MZMobPush_MethodChannel";
    MethodChannel methodChannel = MethodChannel(methodChannelName);
    eventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        _content = event;
      });
      var data = json.decode(event);
      if (data.length > 0) {
        String page = data[0]["page"];
        switch(page) {
          case "One":
            Navigator.push(context, MaterialPageRoute(builder: (context) => OnePage()));
            break;
          case "Two":
            Navigator.push(context, MaterialPageRoute(builder: (context) => TwoPage()));
            break;
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      methodChannel.invokeMethod("InitSuccess");
    });
  }

  _initMobPush() {
    //更新隐私权限状态
    MobpushPlugin.updatePrivacyPermissionStatus(true);
    if (Platform.isIOS) {
      MobpushPlugin.setCustomNotification();
      MobpushPlugin.setAPNsForProduction(false);
    }
    MobpushPlugin.setClickNotificationToLaunchMainActivity(true);
    //Android应用处于前台时隐藏通知
    // MobpushPlugin.setAppForegroundHiddenNotification(true);
    //推送监听
    MobpushPlugin.addPushReceiver((event) {
      print(event);
      Map<String, dynamic> eventMap = json.decode(event);
      Map<String, dynamic> result = eventMap['result']["extrasMap"];
      String page = result["page"];
      switch(page) {
        case "One":
          Navigator.push(context, MaterialPageRoute(builder: (context) => OnePage()));
          break;
        case "Two":
          Navigator.push(context, MaterialPageRoute(builder: (context) => TwoPage()));
          break;
      }
    }, (event) {
      print(event);
    });
    //设置别名
    MobpushPlugin.setAlias("12345678");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MobPush"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_content,style: TextStyle(fontSize: 18),),
            Text(_content1,style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}

