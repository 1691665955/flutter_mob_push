import 'package:flutter/material.dart';
import 'package:mobpush_plugin/mobpush_plugin.dart';
import 'common/Storage.dart';

class SetupPage extends StatefulWidget {
  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initInputController();
  }

  Future<void> _initInputController() async {
    String text = await Storage.getString("alias");
    _controller.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "请输入推送账号别名",
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            child: Text("确认"),
            onPressed: () {
              //设置别名
              print(_controller.text);
              MobpushPlugin.setAlias(_controller.text);
              Storage.setString("alias", _controller.text);
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
