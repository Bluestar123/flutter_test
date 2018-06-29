import 'package:flutter/material.dart';
import '../components/input.dart';

class SecondPage extends StatefulWidget{
  @override
  SecondPageState createState() => new SecondPageState();
}

class SecondPageState extends State<SecondPage>{
  TextEditingController controller;
  String active = 'test1111';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我是第二个'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: controller,
              onChanged: _onChanged,
            ),
            new Input(active: active)
          ],
        ),
      ),
    );
  }

  void _onChanged(String value){
    setState(() {
      active = value;
    });
  }
}