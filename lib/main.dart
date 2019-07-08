import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativeTestPage(title: 'Native Code'),
    );
  }
}

class NativeTestPage extends StatefulWidget {
  NativeTestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NativeTestPageState createState() => _NativeTestPageState();
}

class _NativeTestPageState extends State<NativeTestPage> {
  static const platform = const MethodChannel('com.example/value');
  String _value = 'null';

  Future<void> _getNativeValue() async {
    String value;
    try {
      value = await platform.invokeMethod('getValue');
    } on PlatformException catch (e) {
      value = 'Native code runtime error : ${e.message}';
    }
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'get native value :',
            ),
            Text(
              '$_value',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getNativeValue,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
