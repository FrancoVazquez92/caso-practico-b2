import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:productos/services/fire_base_api.dart';
import 'package:productos/services/fire_base_storage.dart';
import 'firebase_options.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Productos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> addProducto() async {
    // Navegar a la pantalla de agregar producto cuando se presiona el botón
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AgregarProductoScreen(),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
  future: getProductos(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error al cargar datos');
    } else {
      // Muestra la lista de productos utilizando DataTable
      return DataTable(
        columns: [
          DataColumn(label: Text('Descripcion')),
          DataColumn(label: Text('Precio')),
          DataColumn(label: Text('Codigo')),
          DataColumn(label: Text('Imagen')),
        ],
        rows: (snapshot.data as List?)?.map((producto) {
          return DataRow(cells: [
            DataCell(Text(producto['Descripcion'] ?? '')),
            DataCell(Text(producto['Precio'].toString() ?? '')),
            DataCell(Text(producto['Codigo'] ?? '')),
            DataCell(
              FutureBuilder(
                future: cargarImagen(producto['Imagen'].toString()),
                builder: (context, snapshotImagen) {
                  if (snapshotImagen.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshotImagen.hasError) {
                    return Icon(Icons.error);
                  } else {
                    // Mostrar la imagen con cached_network_image
                    return CachedNetworkImage(
                      imageUrl: snapshotImagen.data as String,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      // Tamaño de la imagen
                      width: 80,
                      height: 80,
                    );
                  }
                },
              ),
            ),
          ]);
        }).toList() ?? [],
      );
    }
  },
),

      floatingActionButton: FloatingActionButton(
        onPressed: addProducto,
        tooltip: 'Agregar Producto',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AgregarProductoScreen extends StatefulWidget {
  @override
  _AgregarProductoScreenState createState() => _AgregarProductoScreenState();
}

class _AgregarProductoScreenState extends State<AgregarProductoScreen> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: codigoController,
              decoration: InputDecoration(labelText: 'Código'),
            ),
            TextFormField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            TextFormField(
              controller: precioController,
              decoration: InputDecoration(labelText: 'Precio'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String codigo = codigoController.text;
                String descripcion = descripcionController.text;
                String precio = precioController.text;
                await agregarProducto(codigo, descripcion, precio);

                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
