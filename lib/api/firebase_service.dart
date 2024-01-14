import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getProductos() async {
  List productos = [];

  CollectionReference cr = db.collection("producto");

  QuerySnapshot queryProducto = await cr.get();

  queryProducto.docs.forEach((element) {
    productos.add(element.data());
  });

  return productos;
}
