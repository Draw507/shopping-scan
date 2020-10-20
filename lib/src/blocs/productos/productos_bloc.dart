import 'dart:async';

import 'package:barcode/src/models/producto_model.dart';
import 'package:barcode/src/providers/database_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'productos_event.dart';
part 'productos_state.dart';

class ProductosBloc extends Bloc<ProductosEvent, ProductosState> {
  ProductosBloc() : super(Initial());

  @override
  Stream<ProductosState> mapEventToState(
    ProductosEvent event,
  ) async* {
    if (event is Fetch) {
      yield Loading();
      final productos = await DatabaseProvider.db.getTodosProductos();
      yield Loaded(productos: productos);
    } else if (event is Add) {
      yield Loading();
      await DatabaseProvider.db.nuevoScan(event.nuevoProducto);
      final productos = await DatabaseProvider.db.getTodosProductos();
      yield Loaded(productos: productos);
    } else if (event is DeleteAll) {
      yield Loading();
      await DatabaseProvider.db.deleteTodos();
      yield Loaded(productos: List<ProductoModel>());
    }
  }
}
