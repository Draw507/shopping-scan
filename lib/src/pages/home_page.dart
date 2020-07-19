import 'package:barcode/src/bloc/scans_bloc.dart';
import 'package:barcode/src/models/scan_model.dart';
import 'package:barcode/src/pages/blank_page.dart';
import 'package:barcode/src/pages/productos_pages.dart';
import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();

  ScanResult scanResult;
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Scan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScans,
          )
        ],
      ),
      body: _callPage(currentIndex),
      //bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () => _scan(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scan(BuildContext context) async {
    try {
      var result = await BarcodeScanner.scan();

      if (result != null) {
        final type = result.type?.toString() ?? "";
        final rawContent = result.rawContent ?? "";

        final format = result.format?.toString() ?? "";
        final formatNote = result.formatNote ?? "";

        var uuid = Uuid();
        final scan = ScanModel(
            uuid: uuid.v4(),
            valor: rawContent,
            tipo: type,
            formato: format,
            formatoNota: formatNote,
            establecimiento: '',
            producto: '',
            precio: 0,
            estado: 'INCOMPLETO');
        // scansBloc.agregarScan(scan);
        await Navigator.pushNamed(context, 'producto', arguments: scan);
      }
    } on PlatformException catch (e) {
      var result = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
      );
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        // setState(() {
        //   result.rawContent = 'The user did not grant the camera permission!';
        // });
      } else {
        result.rawContent = 'Unknown error: $e';
      }
      // setState(() {
      //   scanResult = result;
      // });
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return BlankPage();
      case 1:
        return ProductosPage();
      default:
        return BlankPage();
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Blank')),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text('Productos')),
      ],
    );
  }
}
