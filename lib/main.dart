import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Api Call'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Api Example"),
      ),
      body: Center(
        child: getList(),
      ),
    );
  }

  Widget getList() {
    if (data == null || data.length < 1) {
      return Container(
        child: Center(
          child: Text("Please wait..."),
        ),
      );
    }
    return ListView.separated(
      itemCount: data?.length,
      itemBuilder: (BuildContext context, int index) {
        return getListItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget getListItem(int i) {
    if (data == null || data.length < 1) return null;
    if (i == 0) {
      return Container(
        margin: EdgeInsets.all(4),
        child: Center(
          child: Text(
            "Titles",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            data[i]['title'].toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
