import 'package:barcode/src/bloc/scans_bloc.dart';
import 'package:flutter/material.dart';

class ProductosPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();
    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        final scans = snapshot.data;

        if (scans.length == 0) return Center(child: Text('No hay información'));

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
            child: ListTile(
              leading: Icon(
                Icons.cloud_queue,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[i].valor),
              subtitle: Text('ID: ${scans[i].id}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
