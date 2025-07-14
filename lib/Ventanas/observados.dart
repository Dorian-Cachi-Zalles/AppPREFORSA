import 'dart:convert';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Modelo de Persona
class Persona {
  final String id;
  String nombre;
  int edad;
  double peso;
  String f1;
  String f2;
  String f3;
  bool f4;

  Persona({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.peso,
    required this.f1,
    required this.f2,
    required this.f3,
    required this.f4,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['id'].toString(),
      nombre: json['nombre'],
      edad: int.tryParse(json['edad'].toString()) ?? 0,
      peso: double.tryParse(json['peso'].toString()) ?? 0.0,
      f1: json['f1'] ?? '',
      f2: json['f2'] ?? '',
      f3: json['f3'] ?? '',
      f4: json['f4'] == true || json['f4'] == 'true',
    );
  }

  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'edad': edad,
        'peso': peso,
        'f1': f1,
        'f2': f2,
        'f3': f3,
        'f4': f4,
      };
}

// Widget principal
class TablaEditablePersonas extends StatefulWidget {
  const TablaEditablePersonas({super.key});

  @override
  State<TablaEditablePersonas> createState() => _TablaEditablePersonasState();
}

class _TablaEditablePersonasState extends State<TablaEditablePersonas> {
  List<Persona> personas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  // Obtener datos desde la API
  Future<void> cargarDatos() async {
    final response = await http.get(
      Uri.parse('https://67e2b8f197fc65f535374ee2.mockapi.io/api/pruebita/prueba'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      setState(() {
        personas = data.map((e) => Persona.fromJson(e)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  // Actualizar una persona en la API
  Future<void> actualizarPersona(Persona persona) async {
    final url = Uri.parse(
      'https://67e2b8f197fc65f535374ee2.mockapi.io/api/pruebita/prueba/${persona.id}',
    );
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(persona.toJson()),
    );

    if (response.statusCode == 200) {
      debugPrint('Persona ${persona.id} actualizada con éxito');
    } else {
      debugPrint('Error al actualizar persona ${persona.id}');
    }
  }

  void _mostrarFormularioEdicion(Persona persona) {
    final _nombreCtrl = TextEditingController(text: persona.nombre);
    final _edadCtrl = TextEditingController(text: persona.edad.toString());
    final _f1Ctrl = TextEditingController(text: persona.f1);
    final _f2Ctrl = TextEditingController(text: persona.f2);
    final _f3Ctrl = TextEditingController(text: persona.f3);
    bool _f4Value = persona.f4;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Persona'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                    controller: _nombreCtrl,
                    decoration: const InputDecoration(labelText: 'Nombre')),
                TextFormField(
                    controller: _edadCtrl,
                    decoration: const InputDecoration(labelText: 'Edad'),
                    keyboardType: TextInputType.number),
                TextFormField(
                    controller: _f1Ctrl, decoration: const InputDecoration(labelText: 'F1')),
                TextFormField(
                    controller: _f2Ctrl, decoration: const InputDecoration(labelText: 'F2')),
                TextFormField(
                    controller: _f3Ctrl, decoration: const InputDecoration(labelText: 'F3')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('F4 (activo)'),
                    Switch(
                      value: _f4Value,
                      onChanged: (val) => setState(() => _f4Value = val),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text('Peso: ${persona.peso.toStringAsFixed(2)} (no editable)'),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () async {
                persona.nombre = _nombreCtrl.text;
                persona.edad = int.tryParse(_edadCtrl.text) ?? persona.edad;
                persona.f1 = _f1Ctrl.text;
                persona.f2 = _f2Ctrl.text;
                persona.f3 = _f3Ctrl.text;
                persona.f4 = _f4Value;

                await actualizarPersona(persona);
                if (context.mounted) Navigator.pop(context);
                setState(() {}); // refresca la tabla
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tabla Editable'),
          backgroundColor: Colors.blueGrey,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : DataTable2(
                columnSpacing: 12,
                horizontalMargin: 10,
                minWidth: 1200,
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Edad')),
                  DataColumn(label: Text('Peso')),
                  DataColumn(label: Text('F1')),
                  DataColumn(label: Text('F2')),
                  DataColumn(label: Text('F3')),
                  DataColumn(label: Text('F4')),
                ],
                rows: personas.map((persona) {
                  return DataRow(
                    onSelectChanged: (_) => _mostrarFormularioEdicion(persona),
                    cells: [
                      DataCell(Text(persona.nombre)),
                      DataCell(Text('${persona.edad}')),
                      DataCell(Text('${persona.peso.toStringAsFixed(2)}')),
                      DataCell(Text(persona.f1)),
                      DataCell(Text(persona.f2)),
                      DataCell(Text(persona.f3)),
                      DataCell(Icon(
                        persona.f4 ? Icons.check_circle : Icons.cancel,
                        color: persona.f4 ? Colors.green : Colors.red,
                      )),
                    ],
                  );
                }).toList(),
              ));
  }
}
