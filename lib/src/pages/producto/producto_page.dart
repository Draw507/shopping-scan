import 'package:barcode/src/blocs/productos/productos_bloc.dart';
import 'package:barcode/src/models/producto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductoPage extends StatefulWidget {
  ProductoPage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductoModel productoModel = new ProductoModel();
  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final ProductoModel productoArgsData =
        ModalRoute.of(context).settings.arguments;
    if (productoArgsData != null) {
      productoModel = productoArgsData;
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
      initialValue: productoModel.valor,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Código'),
      onSaved: (value) => productoModel.valor = value,
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
      initialValue: productoModel.establecimiento,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Establecimiento'),
      onSaved: (value) => productoModel.establecimiento = value,
    );
  }

  Widget _crearProducto() {
    return TextFormField(
      initialValue: productoModel.producto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Producto'),
      onSaved: (value) => productoModel.producto = value,
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue:
          productoModel.precio == null ? '' : productoModel.precio.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Precio'),
      keyboardType: TextInputType.number,
      onSaved: (value) => productoModel.precio = double.parse(value),
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

    if (productoModel.id == null) {
      //scansBloc.agregarScan(productoModel);
      BlocProvider.of<ProductosBloc>(context)
          .add(Add(nuevoProducto: productoModel));
    } else {
      //scansBloc.updateScan(productoModel);
    }

    Navigator.pop(context);
  }
}
