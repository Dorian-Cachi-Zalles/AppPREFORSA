
import 'dart:convert';
import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:control_de_calidad/modelo_de_datos/ProduccionObservada/ProduccionObservada.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DatosProviderPrefProduccionObservada with ChangeNotifier {
  late Database _db;
  final String tableDatosProduccionObervada = 'tablaProduccionObservada';
  

  List<DatosProduccionObervada> _datosproduccionobervadaList = [];
  

  List<DatosProduccionObervada> get datosproduccionobervadaList => List.unmodifiable(_datosproduccionobervadaList);
  

  DatosProviderPrefProduccionObservada() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'TablaProduccionObservada.db'),
      version: 1,
      onCreate: (db, version) => createTable(db),
    );
    await _loadData();
  }

  Future<void> createTable(Database db) async {
    
    await db.execute('''
      CREATE TABLE $tableDatosProduccionObervada (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hasErrors INTEGER NOT NULL,
        hasSend INTEGER NOT NULL,
        idregistro INTEGER NOT NULL,
        Desvio TEXT NOT NULL,
        cantidadRetenida INTEGER NOT NULL,
        AtributodeProductoNC TEXT NOT NULL,
        EstadodelProducto TEXT NOT NULL,
        ArranqueLinea TEXT NOT NULL,
        ReprocesoConforme INTEGER NOT NULL,
        ReprocesoNoConforme INTEGER NOT NULL,
        EstadodelProductoC TEXT,
        EstadodelProductoNC TEXT
      )
    ''');
        
  }

  Future<void> _loadData() async {
    
    final maps_datosproduccionobervada = await _db.query(tableDatosProduccionObervada);
    _datosproduccionobervadaList = maps_datosproduccionobervada.map((map) => DatosProduccionObervada.fromMap(map)).toList();
        
    notifyListeners();
  }

  
  Future<bool> addDatosProduccionObervada(DatosProduccionObervada nuevoDato) async {
    final id = await _db.insert(tableDatosProduccionObervada, nuevoDato.toMap());
    _datosproduccionobervadaList.add(nuevoDato.copyWith(id: id));
    notifyListeners();
    return true;
  } 
        

  
  Future<void> updateDatosProduccionObervada(int id, DatosProduccionObervada updatedDato) async {
    final index = _datosproduccionobervadaList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosProduccionObervada,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosproduccionobervadaList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }
        

  
  Future<void> removePeso(int id, void Function(VoidCallback onUndo) showUndoSnackBar) async {
    final index = _datosproduccionobervadaList.indexWhere((d) => d.id == id);
    if (index != -1) {
      final deletedData = _datosproduccionobervadaList[index];
      await _db.delete(
        tableDatosProduccionObervada,
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosproduccionobervadaList.removeAt(index);
      notifyListeners();
       showUndoSnackBar(() async {
      final newId = await _db.insert(tableDatosProduccionObervada, deletedData.toMap());
       _datosproduccionobervadaList.insert(index, deletedData.copyWith(id: newId));
       notifyListeners();
       });      
    }
  }    
  Future<bool> enviarDatosAPIDatosProduccionObervada(int id) async {
    final url = Uri.parse("${Config.baseUrl}/API");

    final index = _datosproduccionobervadaList.indexWhere((d) => d.id == id);
    if (index == -1) {
      return false;
    }

    final DatosProduccionObervada dato = _datosproduccionobervadaList[index];

    final Map<String, dynamic> datosJson = {
      "ID_regis": dato.idregistro,
      "Desvio": dato.Desvio,
      "cantidadRetenida": dato.cantidadRetenida,
      "AtributodeProductoNC": dato.AtributodeProductoNC,
      "EstadodelProducto": dato.EstadodelProducto,
      "ArranqueLinea": dato.ArranqueLinea,
      "ReprocesoConforme": dato.ReprocesoConforme,
      "ReprocesoNoConforme": dato.ReprocesoNoConforme,
      "EstadodelProductoC": dato.EstadodelProductoC,
      "EstadodelProductoNC": dato.EstadodelProductoNC
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
          "Accept": "application/json",         
      },
        body: jsonEncode(datosJson),
      );
      if (response.statusCode == 201) {
        return true;
      } else {     
        return false;
      }
    } catch (e) {    
      return false;
    }
  }
        
}
