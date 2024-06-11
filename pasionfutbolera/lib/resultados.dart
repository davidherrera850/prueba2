//Importamos los paquetes necesarios de flutter y http
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultadosPage extends StatefulWidget {
  const ResultadosPage({Key? key}) : super(key: key);

  @override
  _ResultadosPageState createState() => _ResultadosPageState();
}

class _ResultadosPageState extends State<ResultadosPage> {
  //Lista para almacenar los partidos
  List _matches = []; 
  //Iconito de carga
  bool _isLoading = true;

  // Inserta tu clave de API de Football-Data.org aquí
  final String apiKey = '8ed7c6f91cdf4630935eaea26718f7ba';

  @override
  void initState() {
    super.initState();
    //Llamar a la función para obtener los partidos
    _fetchMatches();
  }
  //Función para obtener los partidos de la API
  Future<void> _fetchMatches() async {
    final response = await http.get(
      Uri.parse('https://api.football-data.org/v2/competitions/2014/matches'), // La ID '2014' es para La Liga Española.
      headers: {
        'X-Auth-Token': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        //Ponemos los partidos en la lista
        _matches = data['matches'];
        _isLoading = false;
      });
    } else {
      //Lanzamos una excepción si falla la carga
      throw Exception('Fallo al cargar los partidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text("Liga Española Resultados"),
        ),
      ),
      backgroundColor: Colors.yellow, // Fondo amarillo
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _matches.length,
              itemBuilder: (context, index) {
                final match = _matches[index];
                final homeTeam = match['homeTeam']['name'];
                final awayTeam = match['awayTeam']['name'];
                final homeScore = match['score']['fullTime']['homeTeam'];
                final awayScore = match['score']['fullTime']['awayTeam'];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$homeTeam vs $awayTeam',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Resultado: $homeScore - $awayScore',
                          style: const TextStyle(fontSize: 18),
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








