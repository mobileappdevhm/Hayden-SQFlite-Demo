import 'package:flutter/material.dart';
import 'package:sqflite_demo/DatabaseHelper.dart';

class data extends StatefulWidget {
  data({Key key, this.title}) : super(key: key);

  static const String routeName = "/data";
  final String title;

  @override
  _dataState createState() => new _dataState();
}

class _dataState extends State<data> {
  DatabaseHelper dbh = new DatabaseHelper();
  List<Widget> TextList = <Widget>[];

  @override
  void initState() {
    MakeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Column(
                children: TextList
            )
          ],
        ),
      ),
    );
  }

  void MakeList() async {
    List<Map<String, dynamic>> ListMap = await dbh.selectNote();
    List<Widget> LT = <Widget>[];
    if(ListMap != null) {
      for (int i = 0; i < ListMap.length; i++) {
        LT.add(new Text('Class: '+ListMap[i]["classname"]+"     Note: "+ListMap[i]["note"]));
      }
      TextList = LT;
      print("Got ListMap");
    }
    setState((){});
  }

}