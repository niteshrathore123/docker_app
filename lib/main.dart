import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Myweb());

String cmd;
var result;

class Myweb extends StatefulWidget {
  @override
  _MywebState createState() => _MywebState();
}

class _MywebState extends State<Myweb> {
  web(cmd) async {
    var url = "http://192.168.43.125/cgi-bin/web.py?x=$cmd";
    var response = await http.get(url);
    setState(() {
      result = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("My command app"),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20.0),
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(width: 5.0, color: Colors.red),
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.red,
                  ),
                  child: Image.asset(
                    "images/redhat.jpg",
                    scale: 1.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    autocorrect: false,
                    onChanged: (value) {
                      cmd = value;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      hintStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: 'Enter command here',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    web(cmd);
                  },
                  child: Text("Submit"),
                  color: Colors.red.shade400,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 190,
                  width: double.infinity,
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                      child: Text(
                    result ?? " ",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
