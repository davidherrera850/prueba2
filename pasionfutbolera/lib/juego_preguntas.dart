//Importamos los paquetes flutter necesarios
import 'package:flutter/material.dart';

class JuegoPreguntasPage extends StatefulWidget {
  const JuegoPreguntasPage({Key? key}) : super(key: key);

  @override
  _JuegoPreguntasPageState createState() => _JuegoPreguntasPageState();
}

class _JuegoPreguntasPageState extends State<JuegoPreguntasPage> {
  //Lista de preguntas con respuestas y con una clave para indicar si la respuesta es correcta
  final List<Map<String, Object>> _questions = [
    {
      'question': '¿Quién ha ganado más Copas del Mundo?',
      'answers': [
        {'text': 'Brasil', 'correct': true},
        {'text': 'Alemania', 'correct': false},
        {'text': 'Italia', 'correct': false},
        {'text': 'Argentina', 'correct': false},
      ],
    },
    {
      'question': '¿Quién es conocido como "El Pibe de Oro"?',
      'answers': [
        {'text': 'Pelé', 'correct': false},
        {'text': 'Diego Maradona', 'correct': true},
        {'text': 'Lionel Messi', 'correct': false},
        {'text': 'Cristiano Ronaldo', 'correct': false},
      ],
    },
    {
      'question': '¿Quién es conocido como "La pulga"?',
      'answers': [
        {'text': 'Lionel Messi', 'correct': true},
        {'text': 'Cristiano Ronaldo', 'correct': false},
        {'text': 'Neymar Junior', 'correct': false},
        {'text': 'Vinicius Junior', 'correct': false},
      ],
    },
    {
      'question': '¿Cada cuanto tiempo se celebran los mundiales de selecciones?',
      'answers': [
        {'text': 'Cada 2 años', 'correct': false},
        {'text': 'Cada 4 años', 'correct': true},
        {'text': 'Cada año', 'correct': false},
        {'text': 'Cada 5 años', 'correct': false},
      ],
    },
    {
      'question': '¿Cuántos balones de oro tiene Lionel Messi y Cristiano Ronaldo?',
      'answers': [
        {'text': 'Cristiano Ronaldo 2, Lionel Messi 3', 'correct': false},
        {'text': 'Cristiano Ronaldo 4, Lionel Messi 8', 'correct': false},
        {'text': 'Cristiano Ronaldo 5, Lionel Messi 6', 'correct': false},
        {'text': 'Cristiano Ronaldo 5, Lionel Messi 8', 'correct': true},
      ],
    },
    {
      'question': '¿Quienes son los únicos 2 equipos que tienen en sus vitrinas un sextete?',
      'answers': [
        {'text': 'Real Madrid y Manchester City', 'correct': false},
        {'text': 'Barcelona y Real Madrid', 'correct': false},
        {'text': 'Barcelona y Bayern', 'correct': true},
        {'text': 'Real Madrid y PSG', 'correct': false},
      ],
    },
    // Agrega más preguntas aquí
  ];
  //Variables para controlar la pregunta actual, si se muestra la respuesta y si es correcta
  int _currentQuestionIndex = 0;
  bool _showAnswer = false;
  bool _isCorrect = false;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  //Función para manejar la respuesta a una pregunta
  void _answerQuestion(bool isCorrect) {
    if (!_showAnswer) {
      setState(() {
        _showAnswer = true;
        _isCorrect = isCorrect;
        if (isCorrect) {
          _correctAnswers++;
        } else {
          _incorrectAnswers++;
        }
      });
    }
  }
  //Funcion para ir a la siguiente pregunta
  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _showAnswer = false;
        _isCorrect = false;
      } else {
        _showEndDialog();
      }
    });
  }
  //Función que muestra el dialogo al finalizar el juego
  void _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fin del juego'),
          content: Text(
              'Has terminado el juego, gracias por jugar.\n\nRespuestas correctas: $_correctAnswers\nRespuestas incorrectas: $_incorrectAnswers'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentQuestionIndex = 0;
                  _showAnswer = false;
                  _isCorrect = false;
                  _correctAnswers = 0;
                  _incorrectAnswers = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Juego de Preguntas',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              //Mostrar la pregunta actual
              currentQuestion['question'] as String,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            //Muestra las opciones
            ...(currentQuestion['answers'] as List<Map<String, Object>>).map((answer) {
              return GestureDetector(
                onTap: _showAnswer ? null : () => _answerQuestion(answer['correct'] as bool),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    answer['text'] as String,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            }).toList(),
            if (_showAnswer)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    //Muestra si has acertado o fallado
                    _isCorrect ? '¡Correcto!' : 'Incorrecto',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _isCorrect ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 20),
                  //Botón para ir a la siguiente pregunta
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Siguiente Pregunta'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

