import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<dynamic>> getProductos() async {

  List productos = [];

  CollectionReference cr = db.collection("producto");

  QuerySnapshot queryProducto = await cr.get();

  queryProducto.docs.forEach((element) {
    productos.add(element.data());
  });

  return productos;
}

  Future<void> agregarProducto(String codigo, String descripcion, String precio) async {
    CollectionReference cr = db.collection("producto");

    // Crea un documento con un ID automático
    await cr.add({
      'Codigo': codigo,
      'Descripcion': descripcion,
      'Precio': precio,
      'Imagen': 'lampara.jpeg'
    });
  }
