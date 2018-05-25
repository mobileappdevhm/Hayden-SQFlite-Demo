import 'package:flutter/material.dart';
import 'package:sqflite_demo/DatabaseHelper.dart';
import 'package:sqflite_demo/Note.dart';
import 'package:sqflite_demo/data.dart';

Note myNote = new Note("class1", "note1");

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
        routes: <String, WidgetBuilder>{
           data.routeName: (BuildContext context) => new data(title: "data"),
         },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final formKey = new GlobalKey<FormState>();

  String Class = '';
  String NoteInfo = '';
  DatabaseHelper dbh = new DatabaseHelper();


  void _addClass() async {
    final form = formKey.currentState;
    setState(() {
      form.save();
    });
    Note note = new Note(Class, NoteInfo);
    await dbh.saveNote(note);
    print("Button add Hit");
  }

  void _removeClass() async {
    final form = formKey.currentState;
    setState(() {
      form.save();
    });
    Note note = new Note(Class, NoteInfo);
    await dbh.deleteNote(note);
    print("Button remove Hit");
  }

  void _deleteClass() async {
    final form = formKey.currentState;
    setState(() {
      form.save();
    });
    await dbh.eraseNote();
    print("Button delete Hit");
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
              new Form(
                key: formKey,
                child: new Column(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.all(20.0),
                      child: new TextFormField(
                        onSaved: (val) => Class = val,
                        decoration: new InputDecoration(labelText: "Class", labelStyle: new TextStyle(fontSize: 30.0)),
                      ),
                    ),
                    new Padding(
                      padding: new EdgeInsets.all(20.0),
                      child: new TextFormField(
                        onSaved: (val) => NoteInfo = val,
                        decoration: new InputDecoration(labelText: "Note", labelStyle: new TextStyle(fontSize: 30.0)),
                      ),
                    )
                  ],
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FloatingActionButton(
                    onPressed: _addClass,
                    child: new Icon(Icons.add),
                    heroTag: 2,
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0)),
                  new FloatingActionButton(
                    onPressed: _removeClass,
                    child: new Icon(Icons.remove),
                    heroTag: 3,
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0)),
                  new FloatingActionButton(
                    onPressed: () => Navigator.pushNamed(context, data.routeName),
                    child: new Icon(Icons.list),
                    heroTag: 1,
                  ),
                  new Padding(padding: new EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0, left: 10.0)),
                  new FloatingActionButton(
                    onPressed: _deleteClass,
                    child: new Icon(Icons.cancel),
                    heroTag: 4,
                  ),
                ],
              ),


            ],
        ),
      ),
    );
  }
}
