part of 'productos_bloc.dart';

@immutable
abstract class ProductosEvent {}

class Fetch extends ProductosEvent {}

class Add extends ProductosEvent {
  final ProductoModel nuevoProducto;

  Add({@required this.nuevoProducto});
}

class Update extends ProductosEvent {}

class DeleteAll extends ProductosEvent {}
