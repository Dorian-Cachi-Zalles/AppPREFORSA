import 'package:control_de_calidad/Providers/ProviderI6.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefectosScreenWidget extends StatefulWidget {
  final int id; 
  const DefectosScreenWidget({required this.id, Key? key}) : super(key: key);

  @override
  _DefectosScreenState createState() => _DefectosScreenState();
}

class _DefectosScreenState extends State<DefectosScreenWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String> defectosOptions = ['PC', 'MM', 'CB', 'CN', 'R', 'RS', 'VT', 'B', 'II','FT',
  'ACE', 'ACI', 'AII', 'AP', 'CI', 'CIL', 'Co', 'CoA', 'CS', 'CPI',
  'DC', 'DEP', 'DPI', 'DTb', 'Db', 'Dc', 'Gb', 'HE', 'H', 'HZ',
  'LC', 'LDR', 'MA', 'MH','MP','MS', 'PA', 'PDA', 'PIA', 'PN', 'PP',
  'RF', 'RO','VTE','VTI'];
  List<String> criticidadOptions = ['A', 'M', 'B'];
  String? selectedCriticidad;

 Map<String, Map<String, String>> defectosImages = {
  'PC': {
    'name': 'Punto Contaminantes',
    'image': 'images/d3.png',
  },
  'MM': {
    'name': 'Marca de molde',
    'image': 'images/nohayfoto.avif',
  },
  'CB': {
    'name': 'Cristalizacion en la Base',
    'image': 'images/nohayfoto.avif',
  },
  'CN': {
    'name': 'Cascara de naranja',
    'image': 'images/d2.jpg',
  },
  'R': {
    'name': 'Rebaba',
    'image': 'images/nohayfoto.avif',
  },
  'RS': {
    'name': 'Rasgaduras -Raspaduras en la superficie',
    'image': 'images/nohayfoto.avif',
  },
  'VT': {
    'name': 'Variación de tonalidad',
    'image': 'images/nohayfoto.avif',
  },
  'B': {
    'name': 'Burbuja',
    'image': 'images/d1.jpg',
  },
  'II': {
    'name': 'Inyección con llenado incompleto / Short shot',
    'image': 'images/nohayfoto.avif',
  },  
  'FT': {
    'name': 'Flujo turbulento',
    'image': 'images/nohayfoto.avif',
  },

  // 🔤 Resto del mapa ordenado alfabéticamente por clave
  'ACE': {
    'name': 'Arrastre de cola de inyección en la superficie exterior de la pref.',
    'image': 'images/nohayfoto.avif',
  },
  'ACI': {
    'name': 'Arrastre de cola de inyección en la superficie interior de la pref.',
    'image': 'images/nohayfoto.avif',
  },
  'AII': {
    'name': 'Aro Inyección Incompleta',
    'image': 'images/nohayfoto.avif',
  },
  'AP': {
    'name': 'Aro Picado',
    'image': 'images/nohayfoto.avif',
  },
  'CI': {
    'name': 'Contaminación interna por grasa u otro tipo de suciedad',
    'image': 'images/nohayfoto.avif',
  },
  'CIL': {
    'name': 'Cola de Inyección Larga',
    'image': 'images/nohayfoto.avif',
  },
  'Co': {
    'name': 'Cometa',
    'image': 'images/nohayfoto.avif',
  },
  'CoA': {
    'name': 'Cometa de tono amarillo, degradación térmica en la base',
    'image': 'images/nohayfoto.avif',
  },
  'CPI': {
    'name': 'Cristalización en el ingreso de cavidad o punto de Inyección',
    'image': 'images/nohayfoto.avif',
  },
  'CS': {
    'name': 'Cavidad Sucia',
    'image': 'images/nohayfoto.avif',
  },
  'DC': {
    'name': 'Depresión en el cuerpo',
    'image': 'images/nohayfoto.avif',
  },
  'Db': {
    'name': 'Depresión en la base',
    'image': 'images/nohayfoto.avif',
  },
  'Dc': {
    'name': 'Depresión en el Cuello',
    'image': 'images/nohayfoto.avif',
  },
  'DEP': {
    'name': 'Diferencia de espesor de Pared, Concentricidad',
    'image': 'images/nohayfoto.avif',
  },
  'DPI': {
    'name': 'Depresión en el punto de inyección',
    'image': 'images/nohayfoto.avif',
  },
  'DTb': {
    'name': 'Degradación Térmica en la base de la preforma',
    'image': 'images/nohayfoto.avif',
  },
  'Gb': {
    'name': 'Grietas en la base',
    'image': 'images/nohayfoto.avif',
  },
  'H': {
    'name': 'Hilo en la entrada o ingreso de cavidad',
    'image': 'images/nohayfoto.avif',
  },
  'HE': {
    'name': 'Hueco ingreso de cavidad o punto de Inyeccion',
    'image': 'images/nohayfoto.avif',
  },
  'HZ': {
    'name': 'Haze, Cristalización de preforma',
    'image': 'images/nohayfoto.avif',
  },
  'LC': {
    'name': 'Líneas de condensación por agua',
    'image': 'images/nohayfoto.avif',
  },
  'LDR': {
    'name': 'Líneas de depresión radial',
    'image': 'images/nohayfoto.avif',
  },
  'MA': {
    'name': 'Marcas de Agua',
    'image': 'images/nohayfoto.avif',
  },
  'MH': {
    'name': 'Marcas de humedad',
    'image': 'images/nohayfoto.avif',
  },  
  'MP': {
    'name': 'Marcas plateadas debido a degradación / Espina de pescado',
    'image': 'images/nohayfoto.avif',
  },
  'MS': {
    'name': 'LMolde Sucio',
    'image': 'images/nohayfoto.avif',
  },
  'MT': {
    'name': 'Manchas de tinte',
    'image': 'images/nohayfoto.avif',
  },
  'PA': {
    'name': 'Preforma arrugada o colapsada',
    'image': 'images/nohayfoto.avif',
  },
  'PDA': {
    'name': 'Preformas degradadas amarillas (degradación térmica)',
    'image': 'images/nohayfoto.avif',
  },
  'PIA': {
    'name': 'Punto de Inyección Arrugado',
    'image': 'images/nohayfoto.avif',
  },
  'PN': {
    'name': 'Puntos negros',
    'image': 'images/nohayfoto.avif',
  },
  'PP': {
    'name': 'Preforma Precolapsada, Deformación en el cuello',
    'image': 'images/nohayfoto.avif',
  },
  'PT': {
    'name': 'Preforma Torcida',
    'image': 'images/nohayfoto.avif',
  },
  'RF': {
    'name': 'Resina no fundida',
    'image': 'images/nohayfoto.avif',
  },
  'RO': {
    'name': 'Rosca Ovalada',
    'image': 'images/nohayfoto.avif',
  },
  'VTE': {
    'name': 'Variación de tonalidad por exceso de tinte',
    'image': 'images/nohayfoto.avif',
  },
  'VTI': {
    'name': 'Variación de tonalidad por tinte insuficiente',
    'image': 'images/nohayfoto.avif',
  },
};

 
@override
Widget build(BuildContext context) {
  final datosProvider = Provider.of<DatosProviderPrefIPS>(context);
  final dato = datosProvider.datosdefipsList.firstWhere(
    (dato) => dato.id == widget.id,
  );

  // Filtrar por el nombre dentro del mapa
  final filteredDefectos = defectosImages.entries.where((entry) {
    final name = entry.value['name']?.toLowerCase() ?? '';
    return name.contains(_searchController.text.toLowerCase());
  }).toList();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Buscador de defectos
        TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            labelText: 'Buscar defecto',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),

        const SizedBox(height: 10),

        // Mostrar los códigos (ej. 'PC') en los Wraps
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: filteredDefectos.map((entry) {
            final codigo = entry.key;
            final isSelected = dato.Defectos.contains(codigo);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    dato.Defectos.remove(codigo);
                  } else {
                    dato.Defectos.add(codigo);
                  }
                });

                datosProvider.updateDatosDEFIPS(
                  dato.id!,
                  dato.copyWith(Defectos: dato.Defectos),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.orange[300] : Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  codigo, // 👈 Aquí se muestra la abreviatura
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          }).toList(),
        ),


       /* const SizedBox(height: 20),

        // Mostrar defectos seleccionados con opción para eliminar
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: dato.Defectos.map((defecto) {
            return Chip(
              backgroundColor: Colors.blueAccent.withOpacity(0.6),
              label: Text(
                defecto,
                style: const TextStyle(fontSize: 14),
              ),
              onDeleted: () {
                setState(() {
                  dato.Defectos.remove(defecto);
                });

                datosProvider.updateDatosDEFIPS(
                  dato.id!,
                  dato.copyWith(Defectos: dato.Defectos),
                );
              },
            );
          }).toList(),
        ), */
      ],
    ),
  );
}
}