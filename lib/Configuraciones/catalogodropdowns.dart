import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

final Map<String, Map<String, List<dynamic>>> catalogosPorDefecto = {
  //ESTO POSIBLEMENTE ESTE CON EL ARISOF 
  'DatosIniciales': {
    'Modalidad': ['Normal', 'Prueba'], //hacer
    'Maquinista': ['Agustin Fernadez', 'Roberto Condori','Limber Flores'], //ARISOF   
    'Producto': ['CRISTAL EC30', 'VERDE EC30', 'AZUL Z EC30','PLATEADO EC30','ECO CRISTAL EC30'], //HACER 
    'Gramaje': ['20.1 M5 R', '23.6 M5 R', '46.6 M5 R','54.6 M5 R'], // HACER
    'Empaque': ['Caja', 'Jaula Pequeña', 'Jaula Grande'],  //HACER
    'Cavhabilitadas': ['96', '95', '94','93','92','91','90']
  },
  //ESTO POSIBLEMENTE ESTE CON EL ARISOF 
  'MP': {
    'MateriaPrima': [ //ARISOF 
      'JADE CZ 328A',
      'EASTLON CB 612',
      'ECOPET',
      'RAMAPET',
      'OCTAL',
      'SKY PET',
      'CR-BRIGHT',
      'MOLIDO',
      'WANKAY',
    ],
    'CantidadEmapque': ['1100Kg'], //HACER
    'CantidadBolsones': [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
    ],
  },
  //No esta 
  'Colorante': {
    'Colorante': ['Microbatch Azul', 'Microbatch Verde'],//HACER
    'CantidadBolsone': [1,2,3,4,5],
  },
  'Defectos': {
    'Secciones': ['Al inicio', 'Medio', 'Final'],
    'Ffase': ['Fase 1', 'Fase 2', 'Fase 3','Fase 4'],
    'Desvio': ['Calidad', 'Inocuidad'],//HACER
    'NCAtributo': ['Contaminacion', 'Lote Incorrecto', 'Polvo','Empaque NC'],//HACER
    'EstadoProducto': ['Bloqueado', 'Reclasificado', 'Corregido','Liberado','Scrap'],//HACER
    'ArranqueLinea': ['Arranque', 'Linea', 'Pucho'],//HACER
    'EstadoProductoC': ['Bolsa Nueva', 'Caja Nueva', 'NA',' '],//HACER
    'NCEstadoProductoC': ['NA',' '],//HACER

  },  
  'Temperatura': {
    'fase': ['Fase 1', 'Fase 2', 'Fase 3','Fase 4'],
  },   
};


class CatalogosProvider with ChangeNotifier {
  Map<String, Map<String, List<dynamic>>> _todosLosCatalogos =
      Map.from(catalogosPorDefecto); // 👈 predeterminado al iniciar

  Map<String, List<dynamic>> getCatalogo(String nombre) {
    return _todosLosCatalogos[nombre] ?? {};
  }

  Future<void> cargarDesdeHive() async {
    final box = await Hive.openBox('catalogosBox');
    final data = box.get('catalogos');

    if (data != null) {
      _todosLosCatalogos = Map<String, dynamic>.from(data).map((clave, valor) {
        return MapEntry(
          clave,
          Map<String, List<dynamic>>.from(valor).map(
              (subClave, lista) => MapEntry(subClave, List<dynamic>.from(lista))),
        );
      });
      notifyListeners();
    } else {
      // Si no hay datos en Hive, usa el predeterminado
      _todosLosCatalogos = Map.from(catalogosPorDefecto);
      notifyListeners();
    }
  }

  Future<void> actualizarDesdeApi() async {
    try {
      final response = await http.get(Uri.parse('https://API'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final Map<String, Map<String, List<dynamic>>> nuevosDatos =
            jsonData.map((clave, valor) {
          return MapEntry(
            clave,
            Map<String, List<dynamic>>.from(valor).map(
                (k, v) => MapEntry(k, List<dynamic>.from(v))),
          );
        });

        _todosLosCatalogos = nuevosDatos;

        final box = await Hive.openBox('catalogosBox');
        await box.put('catalogos', _todosLosCatalogos);

        notifyListeners();
      } else {
        print('⚠️ API respondió con error: ${response.statusCode}');
      }
    } catch (e) {
      print('⚠️ Error de red o parsing: $e');
      // Si falla, mantener los datos actuales (Hive o predeterminado)
    }
  }
}
