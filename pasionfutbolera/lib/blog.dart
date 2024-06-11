//Importamos los paquetes necesarios de flutter
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Esta es la lista de contenido del blog donde cada entrada tiene su título y contenido
    final List<Map<String, String>> blogEntries = [
      {
        'title': 'Bienvenidos al blog de David el Mango',
        'content': 'Aquí hablaremos sobre todo lo relacionado a la tienda, de las mejoras de la app y de las convocatorias que saque la RFEF para ser arbitros.',
      },
      {
        'title': 'Deportes el Mango',
        'content': 'Nuestra tienda ya cuenta con equipaciones, chandal y bufandas de nuestros equipos de la Liga Española',
      },
      {
        'title': 'Deportes el Mango',
        'content': 'Nuestra tienda ya cuenta con pedido por correo no dude en contactar con nosotros a través del email o teléfono solo pedidos nacionales',
      },
      {
        'title': 'Deportes el Mango',
        'content': 'Nuestra tienda pronto tendrá para hacer pedidos online',
      },
      {
        'title': 'Mejora app',
        'content': 'Pronto tendremos un nuevo apartado en nuestra app estate atento al blog',
      },
      // Puedes agregar más entradas aquí
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Blog',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      //Crea una lista desplazable para ver las entradas del blog
      body: ListView.builder(
        itemCount: blogEntries.length,
        itemBuilder: (context, index) {
          final entry = blogEntries[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['title']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    entry['content']!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
