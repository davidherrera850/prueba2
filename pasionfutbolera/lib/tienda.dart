//Importamos los paquetes flutter necesarios
import 'package:flutter/material.dart';

class TiendaPage extends StatelessWidget {
  const TiendaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Tienda',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Mostrar imagen que tenemos guardada en la carpeta assets
            Image.asset(
              'assets/deportes_mango.png',
              height: 600,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                //Llamamos a la funcion cuando se pulsa el boton
                _showTable(context);
              },
              child: Text('Ver articulos'),
            ),
          ],
        ),
      ),
    );
  }
  //Muestra un dialogo con una tabla con los articulos
  void _showTable(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  _buildTableRow(
                    //Fila de la tabla con el nombre de los articulos y el precio
                    'Equipaciones equipos españoles',
                    '20€',
                  ),
                  _buildTableRow(
                    'Chandal equipos españoles',
                    '40€',
                  ),
                  _buildTableRow(
                    'Bufandas equipos españoles',
                    '15€',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  //Construimos una fila de la tabla con 2 columnas
  TableRow _buildTableRow(String itemName, String price) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(itemName, style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(price, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}








