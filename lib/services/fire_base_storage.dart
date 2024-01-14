import 'package:firebase_storage/firebase_storage.dart';

final storageRef = FirebaseStorage.instance.ref();

Future<String> cargarImagen(String nombreImagen) async {
  try {
    final Reference ref = storageRef.child(nombreImagen);

    final String url = await ref.getDownloadURL();

    print(url);

    return url;
  } catch (e) {
    print('Error al cargar la imagen: $e');
    return '';
  }
}
