import 'package:barcode/src/blocs/productos/productos_bloc.dart';
import 'package:barcode/src/pages/home/home_page.dart';
import 'package:barcode/src/pages/producto/producto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => new ProductosBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Barcode Scan',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage()
        },
        theme: ThemeData(primaryColor: Colors.blueAccent),
      ),
    );
  }
}
