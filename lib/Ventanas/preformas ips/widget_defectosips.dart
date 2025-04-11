import 'package:control_de_calidad/Providers/BDpreformasIPS.dart';
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
  List<String> defectosOptions = ['B', 'CN', 'PC','VTE','MM','CB','R','RS','ACE','Co','RO	','MT','Db','ACI','AP','CPI','CI','CIL','HZ','CS','PP','Dc','DC','DEP','DPI','DTb','FT','H','HE','II','LDR','Gb',
  'LC','MA','MH','MP','MS','PA','PDA','PN','PT','RF','RO','VTI','AII','PIA','CoA'];
  List<String> criticidadOptions = ['A', 'M', 'B'];
  String? selectedCriticidad;

  Map<String, Map<String, String>> defectosImages = {
  'B': {
    'name': 'Burbuja',
    'image': 'images/d1.jpg',
  },
  'CN': {
    'name': 'Cascara de naranja',
    'image': 'images/d2.jpg',
  },
  'PC': {
    'name': 'Punto Contaminantes',
    'image': 'images/d3.png',
  },
  'VTE': {
    'name': 'Variación de tonalidad por exceso de tinte',
    'image': 'images/nohayfoto.avif',
  },
  'MM': {
    'name': 'Marca de molde',
    'image': 'images/nohayfoto.avif',
  },
  'CB': {
    'name': 'Cristalizacion en la Base',
    'image': 'images/nohayfoto.avif',
  },
  'R': {
    'name': 'Rebaba',
    'image': 'images/nohayfoto.avif',
  },
  'RS': {
    'name': 'Rasgaduras -Raspaduras en la superficie',
    'image': 'images/nohayfoto.avif',
  },
  'ACE': {
    'name': 'Arrastre de cola de inyección en la superficie exterior de la pref.',
    'image': 'images/nohayfoto.avif',
  },
  'Co': {
    'name': 'Cometa',
    'image': 'images/nohayfoto.avif',
  },
  'RO	': {
    'name': 'Rosca Ovalada',
    'image': 'images/nohayfoto.avif',
  },
  'MT': {
    'name': 'Manchas de tinte',
    'image': 'images/nohayfoto.avif',
  },
  'Db': {
    'name': 'Depresión en la base',
    'image': 'images/nohayfoto.avif',
  },
  'ACI': {
    'name': 'Arrastre de cola de inyección en la superficie interior de la pref.',
    'image': 'images/nohayfoto.avif',
  },
  'AP': {
    'name': 'Aro Picado',
    'image': 'images/nohayfoto.avif',
  },
  'CPI': {
    'name': 'Cristalización en el ingreso de cavidad o punto de Inyección',
    'image': 'images/nohayfoto.avif',
  },
  'CI': {
    'name': 'Contaminación interna por grasa u otro tipo de suciedad',
    'image': 'images/nohayfoto.avif',
  },
  'CIL': {
    'name': 'Cola de Inyección Larga',
    'image': 'images/nohayfoto.avif',
  },'HZ': {
    'name': 'Haze, Cristalización de preforma',
    'image': 'images/nohayfoto.avif',
  },'CS': {
    'name': 'Cavidad Sucia',
    'image': 'images/nohayfoto.avif',
  },'PP': {
    'name': 'Preforma Precolapsada, Deformación en el cuello',
    'image': 'images/nohayfoto.avif',
  },'Dc': {
    'name': 'Depresión en el Cuello',
    'image': 'images/nohayfoto.avif',
  },'DC': {
    'name': 'Depresión en el cuerpo',
    'image': 'images/nohayfoto.avif',
  },'DEP': {
    'name': 'Diferencia de espesor de Pared, Concentricidad',
    'image': 'images/nohayfoto.avif',
  },'DPI': {
    'name': 'Depresión en el punto de inyección',
    'image': 'images/nohayfoto.avif',
  },'DTb': {
    'name': 'Degradación Térmica en la base de la preforma',
    'image': 'images/nohayfoto.avif',
  },'FT': {
    'name': 'Flujo turbulento',
    'image': 'images/nohayfoto.avif',
  },'H': {
    'name': 'Hilo en la entrada o ingreso de cavidad',
    'image': 'images/nohayfoto.avif',
  },'HE': {
    'name': 'Hueco ingreso de cavidad o punto de Inyeccion',
    'image': 'images/nohayfoto.avif',
  },'II': {
    'name': 'Inyección con llenado incompleto / Short shot',
    'image': 'images/nohayfoto.avif',
  },'LDR': {
    'name': 'Líneas de depresión radial',
    'image': 'images/nohayfoto.avif',
  },'Gb': {
    'name': 'Grietas en la base',
    'image': 'images/nohayfoto.avif',
  },'LC': {
    'name': 'Líneas de condensación por agua',
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
  'PA': {
    'name': 'Preforma arrugada o colapsada',
    'image': 'images/nohayfoto.avif',
  },
  'PDA': {
    'name': 'Preformas degradadas amarillas (degradación térmica)',
    'image': 'images/nohayfoto.avif',
  },'PN': {
    'name': 'Puntos negros',
    'image': 'images/nohayfoto.avif',
  },'PT': {
    'name': 'Preforma Torcida',
    'image': 'images/nohayfoto.avif',
  },'RF': {
    'name': 'Resina no fundida',
    'image': 'images/nohayfoto.avif',
  },'RO': {
    'name': 'Rosca Ovalada',
    'image': 'images/nohayfoto.avif',
  },'VTI': {
    'name': 'Variación de Tonalidad por tinte insuficiente',
    'image': 'images/nohayfoto.avif',
  },'AII': {
    'name': 'Aro Inyección Incompleta',
    'image': 'images/nohayfoto.avif',
  },'PIA': {
    'name': 'Punto de Inyección Arrugado',
    'image': 'images/nohayfoto.avif',
  },'CoA': {
    'name': 'Cometa de tono amarillo, degradación térmica en la base',
    'image': 'images/nohayfoto.avif',
  },
};


  @override
  Widget build(BuildContext context) {
  final datosProvider = Provider.of<DatosProviderPrefIPS>(context);
  final dato = datosProvider.datosdefipsList.firstWhere(
    (dato) => dato.id == widget.id,
  );

  // Filtrar defectos por búsqueda
  final filteredDefectos = defectosOptions.where((defecto) {
    return defecto.toLowerCase().contains(_searchController.text.toLowerCase());
  }).toList();

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Buscador de defectos
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Buscar defecto',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            setState(() {}); // Refresca la galería
          },
        ),

        const SizedBox(height: 10),

        // Galería de defectos
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filteredDefectos.map((defecto) {
              final imagePath = defectosImages[defecto]?['image'];
              final defectoName = defectosImages[defecto]?['name'] ?? defecto;              
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Seleccionar criticidad para $defectoName'),
                        content: DropdownButtonFormField<String>(
                          value: selectedCriticidad,
                          hint: const Text("Selecciona criticidad"),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCriticidad = newValue;
                            });
                          },
                          items: criticidadOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        actions: [
                          TextButton(                            
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (selectedCriticidad != null) {
                                // Buscar el índice del defecto existente
                                final existingIndex =
                                    dato.Defectos.indexOf(defecto);

                                if (existingIndex != -1) {
                                  // Si ya existe, actualizar criticidad en la posición correspondiente
                                  setState(() {
                                    dato.Criticidad[existingIndex] =
                                        selectedCriticidad!;
                                  });
                                } else {
                                  // Si no existe, añadir el nuevo defecto y su criticidad
                                  setState(() {
                                    dato.Defectos.add(defecto);
                                    dato.Criticidad.add(selectedCriticidad!);
                                  });
                                }

                                // Actualizar datos en el proveedor y cerrar el diálogo
                                datosProvider.updateDatosDEFIPS(
                                  dato.id!,
                                  dato.copyWith(
                                    Defectos: dato.Defectos,
                                    Criticidad: dato.Criticidad,
                                  ),
                                );

                                selectedCriticidad = null;
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Guardar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 300,
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Imagen como fondo
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            imagePath ?? 'assets/images/default.png', // Imagen predeterminada
                            fit: BoxFit.cover, // La imagen ocupa todo el espacio
                          ),
                        ),
                      ),
                      // Texto flotante
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6), // Fondo semitransparente
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            defectoName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 20),

        // Chips para mostrar defectos seleccionados
        Wrap(
          spacing: 8.0,
          children: List.generate(dato.Defectos.length, (index) {
            return Chip(
              backgroundColor: Colors.blueAccent.withOpacity(0.6),
              label: Text(
                style: TextStyle(fontSize: 14),
                  '${dato.Defectos[index]} - ${dato.Criticidad[index]}'),
              onDeleted: () {
                setState(() {
                  dato.Defectos.removeAt(index);
                  dato.Criticidad.removeAt(index);
                });
                datosProvider.updateDatosDEFIPS(
                  dato.id!,
                  dato.copyWith(
                    Defectos: dato.Defectos,
                    Criticidad: dato.Criticidad,
                  ),
                );
              },
            );
          }),
        ),
      ],
    ),
  );
}
}
