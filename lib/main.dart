import 'package:barcode/src/pages/home_page.dart';
import 'package:barcode/src/pages/producto_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barcode Scan',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'producto': (BuildContext context) => ProductoPage()
      },
      theme: ThemeData(primaryColor: Colors.blueAccent),
    );
  }
}
