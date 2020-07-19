import 'package:barcode/src/bloc/scans_bloc.dart';
import 'package:barcode/src/providers/db_provider.dart';
import 'package:flutter/material.dart';

class ProductoPage extends StatefulWidget {
  ProductoPage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scansBloc = new ScansBloc();

  ScanModel scanModel = new ScanModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final ScanModel scanData = ModalRoute.of(context).settings.arguments;
    if (scanData != null) {
      scanModel = scanData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Producto'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearCodigo(),
                _crearEstablecimiento(),
                _crearProducto(),
                _crearPrecio(),
                _crearBotonGuardar()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearCodigo() {
    return TextFormField(
      initialValue: scanModel.valor,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Código'),
      onSaved: (value) => scanModel.valor = value,
      // validator: (value) {
      //   if (value.length < 3) {
      //     return 'Ingrese el nombre del producto';
      //   } else {
      //     return null;
      //   }
      // },
    );
  }

  Widget _crearEstablecimiento() {
    return TextFormField(
      initialValue: scanModel.establecimiento,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Establecimiento'),
      onSaved: (value) => scanModel.establecimiento = value,
    );
  }

  Widget _crearProducto() {
    return TextFormField(
      initialValue: scanModel.producto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => scanModel.producto = value,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: scanModel.precio == null ? '' : scanModel.precio.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Precio'),
      keyboardType: TextInputType.number,
      onSaved: (value) => scanModel.precio = double.parse(value),
    );
  }

  Widget _crearBotonGuardar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blueAccent,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (scanModel.id == null) {
      scansBloc.agregarScan(scanModel);
    } else {
      scansBloc.updateScan(scanModel);
    }

    Navigator.pop(context);
  }
}
