import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class IdsRegistro {
  final int? id;
  final String? nombre;
  final int? numero;
  final bool estado;

  const IdsRegistro({
    this.id,
    this.nombre,
    this.numero,
    required this.estado,
  });

  // Factory para crear una instancia desde un Map
  factory IdsRegistro.fromMap(Map<String, dynamic> map) {
    return IdsRegistro(
      id: map['id'] as int?,
      nombre: map['nombre'] as String?,
      numero: map['numero'] as int?,
      estado: (map['estado'] as int) == 1, // Convertir 1 a true y 0 a false
    );
  }

  // Método para convertir la instancia a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nombre': nombre,
      'numero': numero,
      'estado': estado ? 1 : 0, // Convertir true a 1 y false a 0
    };
  }

  // Método copyWith
  IdsRegistro copyWith({
    int? id,
    String? nombre,
    int? numero,
    bool? estado,
  }) {
    return IdsRegistro(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      numero: numero ?? this.numero,
      estado: estado ?? this.estado,
    );
  }
}


class IdsProvider with ChangeNotifier {
  late Database _db;
  final String tableRegistros = 'IdsRegistros';
  List<IdsRegistro> _idsRegistrosList = [];

  String _auxiliar = " ";
  String _turno = '1';
  bool _acceso = false;

  String get auxiliar => _auxiliar;
  String get turno => _turno;
  bool get acceso => _acceso;

  List<IdsRegistro> get idsRegistrosList =>
      List.unmodifiable(_idsRegistrosList);

  IdsProvider() {
    _initDatabase();
    _cargarPreferencias();
  }


  Future<void> _initDatabase() async {
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'IdsRegistros.db'),
      version: 2,
      onCreate: (db, version) => createTable(db),
    );
    await _loadData();
  }  

  Future<void> createTable(Database db) async {
  await db.execute('''
    CREATE TABLE $tableRegistros (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nombre TEXT NOT NULL,
      numero INTEGER NOT NULL,
      estado INTEGER NOT NULL
    )
  ''');

  // Insertar datos predeterminados después de crear la tabla
  await db.execute('''
    INSERT INTO $tableRegistros (id, nombre, numero, estado) VALUES
    (1, 'I6', 1, 0),
    (2, 'I9', 2, 0),
    (3, 'COLORACAP', 3, 0),
    (4, 'CCM', 4, 0),
    (5, 'SOPLADO', 5, 0),
    (6, 'I5', 6, 0),    
    (7, 'IT 2 HX-258', 7, 0),
    (8, 'YUTZUMI', 8, 0)
  ''');
}

Future<void> _loadData() async {
  final maps = await _db.query(tableRegistros);
  _idsRegistrosList = maps.map((map) => IdsRegistro.fromMap(map)).take(8).toList();
  notifyListeners();
}
  
  Future<void> updateDatito(int id, IdsRegistro updatedDato) async {
  final index = _idsRegistrosList.indexWhere((d) => d.id == id);
  if (index != -1) {
    await _db.update(
      tableRegistros,
      updatedDato.copyWith(id: id).toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    _idsRegistrosList[index] = updatedDato.copyWith(id: id);
    notifyListeners();
  }
}

Future<void> _cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _auxiliar = prefs.getString('auxiliar') ?? "";
    _turno = prefs.getString('turno') ?? "";
    _acceso = prefs.getBool('acceso') ?? false;
    notifyListeners();
  }

  Future<void> setDatos(String auxiliar, String turno) async {
    final prefs = await SharedPreferences.getInstance();
    _auxiliar = auxiliar;
    _turno = turno;
    _acceso = true;
    await prefs.setString('auxiliar', auxiliar);
    await prefs.setString('turno', turno);
    await prefs.setBool('acceso', true);
    notifyListeners();
  }

  Future<void> cerrarSesion() async {
    final prefs = await SharedPreferences.getInstance();
    _auxiliar = "";
    _turno = '1';
    _acceso = false;
    await prefs.remove('auxiliar');
    await prefs.remove('turno');
    await prefs.remove('acceso');
    notifyListeners();
  }

Future<int> createRegistro() async {
  try {
    final response = await http
        .post(
          Uri.parse('${Config.baseUrl}/prueba/'),
          body: json.encode({
               
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        )
        .timeout(const Duration(seconds: 5)); // Tiempo límite de espera

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final int messageId = data['id'];
     
      return messageId;  
    } else {
      throw Exception('Error en la respuesta del servidor: ${response.statusCode}');
    }
  } on TimeoutException {
    throw Exception('Tiempo de espera agotado al conectar con el servidor');
  } on SocketException {
    throw Exception('Error de conexión con el servidor');
  } catch (e) {
    throw Exception('Error inesperado: $e');
  }
}

Future<int> createRegistroIPS() async {
  try {
    final response = await http
        .post(
          Uri.parse('${Config.baseUrl}/RegistroIPS'),
          body: json.encode({
            "Auxiliar": _auxiliar,
            "Turno":_turno           
          }),
          headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",  // Asegura que reciba JSON en vez de HTML
        },
        )
        .timeout(const Duration(seconds: 5)); // Tiempo límite de espera

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      final int messageId = data['id'];
     
      return messageId;  
    } else {
      throw Exception('Error en la respuesta del servidor: ${response.statusCode}');
    }
  } on TimeoutException {
    throw Exception('Tiempo de espera agotado al conectar con el servidor');
  } on SocketException {
    throw Exception('Error de conexión con el servidor');
  } catch (e) {
    throw Exception('Error inesperado: $e');
  }
}


Future<int?> getNumeroById(int id) async {
  final List<Map<String, dynamic>> result = await _db.query(
    tableRegistros,
    columns: ['numero'],
    where: 'id = ?',
    whereArgs: [id],
  );

  if (result.isNotEmpty) {
    return result.first['numero'] as int;
  }
  return null; // Retorna null si no encuentra el ID
}

}