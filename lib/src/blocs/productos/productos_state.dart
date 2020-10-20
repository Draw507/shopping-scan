part of 'productos_bloc.dart';

@immutable
abstract class ProductosState {}

class Initial extends ProductosState {}

class Loading extends ProductosState {}

class Loaded extends ProductosState {
  final List<ProductoModel> productos;

  Loaded({@required this.productos});
}
