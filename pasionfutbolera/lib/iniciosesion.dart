//Importamos los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'arbitraje.dart'; // Ajusta la importación según la ubicación de arbitraje.dart en tu proyecto

class InicioSesionPage extends StatefulWidget {
  const InicioSesionPage({Key? key}) : super(key: key);

  @override
  _InicioSesionPageState createState() => _InicioSesionPageState();
}

class _InicioSesionPageState extends State<InicioSesionPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  //Almacenar el estado de inicio de sesion
  late SharedPreferences _prefs;
  //Indica si el usuario esta logueado
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }
  //Iniciación de sharedpreferences para manejar el inicio de sesión
  Future<void> _initPrefs() async {
    //Obtenemos la instancia de sharedpreferences
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      //Verificamos si el usuario esta registrado
      _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
      if (_isLoggedIn) {
        //Si esta registrado vamos a la pagina
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ArbitrajePage()), 
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Inicio de Sesión'),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: _buildLoginWidget(),
      ),
    );
  }
  //Widget que construye el formulario de inicio de sesión
  Widget _buildLoginWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX-qpWv8_xMBydH97MP-M5mnYLe_d5rHj4cw&s', // Reemplaza con la URL de la imagen que quieras usar
          height: 100,
        ),
        const SizedBox(height: 20),
        const Text(
          'Inicio de Sesión',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Si te interesa el mundo del arbitraje, inicia sesión aquí y podrás ver los distintos niveles de árbitros y cómo acceder a ese nivel de arbitraje.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 40),
        TextField(
          controller: _userController,
          decoration: const InputDecoration(
            labelText: 'Usuario',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _claveController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Clave',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: const Text('Iniciar Sesión'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _register,
          child: const Text('Registrarse'),
        ),
      ],
    );
  }
  //Funcion para el inicio de sesión
  void _login() {
    final String usuario = _userController.text.trim();
    final String clave = _claveController.text.trim();
    //Obtenemos el usuario y la contraseña guardados en sharepreferences
    String? storedUsuario = _prefs.getString('usuario');
    String? storedClave = _prefs.getString('clave');
    //Si los datos son correctos iniciamos sesion si no sale un mensaje de que estan mal
    if (usuario == storedUsuario && clave == storedClave) {
      _prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ArbitrajePage()),
      );
    } else {
      _showErrorDialog('Usuario o clave incorrectos.');
    }
  }
  //Función para el registro de usuario
  void _register() {
    final String usuario = _userController.text.trim();
    final String clave = _claveController.text.trim();
    //Guardamos los datos de usuario y contraseña en sharepreference
    if (usuario.isNotEmpty && clave.isNotEmpty) {
      _prefs.setString('usuario', usuario);
      _prefs.setString('clave', clave);
      _showSuccessDialog('Usuario registrado exitosamente.');

      // Vaciar los campos después de registrar
      _userController.clear();
      _claveController.clear();
    } else {
      _showErrorDialog('Por favor, completa todos los campos.');
    }
  }
  //Función para mostrar un dialogo de fallo
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  //Función para mostrar un dialogo de exito
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Éxito'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}










