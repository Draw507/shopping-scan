import 'package:barcode/src/blocs/productos/productos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: () async {
      BlocProvider.of<ProductosBloc>(context).add(Fetch());
    }, child: BlocBuilder<ProductosBloc, ProductosState>(
      builder: (context, state) {
        if (state is Initial) {
          BlocProvider.of<ProductosBloc>(context).add(Fetch());
        } else if (state is Loaded) {
          if (state.productos.isEmpty) {
            return Center(child: Text('No hay información'));
          } else {
            return ListView(
              children: [
                ...state.productos.map((producto) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.shopping_basket,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(
                              '${producto.producto} - ${NumberFormat.simpleCurrency().format(producto.precio)}'),
                          subtitle: Text(
                              '${producto.establecimiento} \n${producto.valor}'),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                          ),
                          isThreeLine: true,
                          onTap: () => Navigator.pushNamed(context, 'producto',
                              arguments: producto),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

// class ProductosList extends StatelessWidget {
//   final scansBloc = new ScansBloc();

//   @override
//   Widget build(BuildContext context) {
//     scansBloc.obtenerScans();
//     return StreamBuilder(
//       stream: scansBloc.scansStream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData)
//           return Center(child: CircularProgressIndicator());

//         final scans = snapshot.data;

//         if (scans.length == 0) return Center(child: Text('No hay información'));

//         return ListView.builder(
//           itemCount: scans.length,
//           itemBuilder: (context, i) => Dismissible(
//               key: UniqueKey(),
//               background: Container(
//                 color: Colors.red,
//               ),
//               onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
//               child: Card(
//                 child: Column(
//                   children: <Widget>[
//                     ListTile(
//                       leading: Icon(
//                         Icons.shopping_basket,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                       title: Text(
//                           '${scans[i].producto} - ${NumberFormat.simpleCurrency().format(scans[i].precio)}'),
//                       subtitle: Text(
//                           '${scans[i].establecimiento} \n${scans[i].valor}'),
//                       trailing: Icon(
//                         Icons.keyboard_arrow_right,
//                         color: Colors.grey,
//                       ),
//                       isThreeLine: true,
//                       onTap: () => Navigator.pushNamed(context, 'producto',
//                           arguments: scans[i]),
//                     ),
//                   ],
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
