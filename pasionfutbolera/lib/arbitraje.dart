//Importamos los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArbitrajePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Normativa de Árbitros'),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
            //Icono de cerrar sesión
            icon: const Icon(Icons.exit_to_app),
            //Llamamos a la función cerrar sesión
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSection(
              'Árbitro de Primera División',
              [
                'Debe poseer al menos 5 años de experiencia como árbitro.',
                'Capacidad para dirigir partidos de alta competición con VAR.',
                'Cumplir con los estándares físicos y técnicos establecidos por la federación.',
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Árbitro de Segunda División',
              [
                'Al menos 3 años de experiencia en ligas menores.',
                'Habilidad para aplicar las reglas del juego de manera consistente.',
                'Capacidad para trabajar bajo presión y tomar decisiones rápidas.',
              ],
            ),
            const SizedBox(height: 16),
            _buildSection(
              'Árbitro de Categorías Juveniles',
              [
                'Conocimiento profundo de las reglas del fútbol para menores.',
                'Capacidad para educar a los jugadores jóvenes sobre las reglas del juego.',
                'Actitud ejemplar y capacidad para manejar situaciones conflictivas de manera diplomática.',
              ],
            ),
          ],
        ),
      ),
    );
  }
  //Funcion que hace los determinados apartados de la pagina
  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '• $item',
                      style: const TextStyle(fontSize: 18), 
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
  //Funcion de cerrar sesión
  void _handleLogout(BuildContext context) async {
    //Obtiene una instacia de sharepreferences para acceder y modificar datos persistentes
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Pone al usuario como no conectado
    prefs.setBool('isLoggedIn', false); 

    //Vuelve a la pagina de inicio de sesión
    Navigator.pushReplacementNamed(context, '/iniciosesion');
  }
}








