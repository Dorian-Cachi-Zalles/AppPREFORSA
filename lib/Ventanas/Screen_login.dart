import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/Ventanas/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? auxiliarSeleccionado;
  String? turnoSeleccionado;

  final List<String> auxiliares = ['Jorge Machaca', 'Ruben Yanarico', 'Pablo Macuchapi', 'Linder Bozo','Ruben Ordoñez(Supervisor)'];
  final List<String> turnos = ['1', '2', '3', '1L', '2L'];

  void _login() async {
    if (auxiliarSeleccionado != null && turnoSeleccionado != null) {
      Provider.of<IdsProvider>(context, listen: false)
          .setDatos(auxiliarSeleccionado!, turnoSeleccionado!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, selecciona todos los campos"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/LABO.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.darken),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'images/logopre.png',
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
    color: Colors.white70.withOpacity(0.5), // ✅ Color dentro de BoxDecoration
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(color: Colors.black26, blurRadius: 5),
    ],
  ),                    
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          "Ingresa tus datos para continuar",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        DropdownButtonFormField<String>(
  value: auxiliarSeleccionado,
  items: auxiliares.map((String auxiliar) {
    return DropdownMenuItem(
      value: auxiliar,
      child: Text(
        auxiliar,
        style: TextStyle(color: Colors.black), // ✅ Texto blanco en opciones
      ),
    );
  }).toList(),
  onChanged: (value) {
    setState(() {
      auxiliarSeleccionado = value;
    });
  },
  style: const TextStyle(color: Colors.black), // ✅ Texto blanco en el seleccionado
  decoration: const InputDecoration(
    labelText: "Auxiliar",
    labelStyle: TextStyle(color: Colors.black), // ✅ Texto blanco en etiqueta
    border: UnderlineInputBorder(),
  ),
),
                        const SizedBox(height: 15),
                        DropdownButtonFormField<String>(
                          value: turnoSeleccionado,
                          items: turnos.map((String turno) {
                            return DropdownMenuItem(
                              value: turno,
                              child: Text(
        turno,
        style: const TextStyle(color: Colors.black), // ✅ Texto blanco en opciones
      ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              turnoSeleccionado = value;
                            });
                          },
                           style: const TextStyle(color: Colors.black), // ✅ Texto blanco en el seleccionado
  decoration: const InputDecoration(
    labelText: "Turno",
    labelStyle: TextStyle(color: Colors.black), // ✅ Texto blanco en etiqueta
    border: UnderlineInputBorder(),
  ),
                        ),
                        const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "INGRESAR",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
