import 'package:flutter/material.dart';

class TProductos extends StatelessWidget {
  
  const TProductos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Codigo')),
          DataColumn(label: Text('Descripcion')),
          DataColumn(label: Text('Precio')),
          DataColumn(label: Text('Imagen')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('Juan')),
            DataCell(Text('25')),
            DataCell(Text('Ciudad A')),
          ]),
          DataRow(cells: [
            DataCell(Text('Ana')),
            DataCell(Text('30')),
            DataCell(Text('Ciudad B')),
          ]),
          DataRow(cells: [
            DataCell(Text('Pedro')),
            DataCell(Text('22')),
            DataCell(Text('Ciudad C')),
          ]),
        ],
      ),
    );
  }
}