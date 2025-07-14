import 'package:control_de_calidad/Providers/ProviderI6.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_datosiniciales.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ScreenEstadoRegistros extends StatelessWidget {
  const ScreenEstadoRegistros({super.key});

  @override
  Widget build(BuildContext context) {
    final providerregistro = Provider.of<IdsProvider>(context);
    final providerIPS = Provider.of<DatosProviderPrefIPS>(context);
    final providerdatosips = Provider.of<RegistroIPSProvider>(context);
    DateTime? _ultimoEnvio;

    final List<Map<String, dynamic>> LineasDescripcion = [
                    {
                      'title': 'I6',
                      'description': 'Preformas I6(Pequeñas)',
                      'color': Colors.teal,
                      'Foto': 'images/I6.png',
                      'Foto2': 'images/I62.png',
                    },
                    {
                      'title': 'I9',
                      'description': 'Preformas I6(Pequeñas)',
                      'color': Colors.redAccent[700],
                      'Foto': 'images/I9.png',
                      'Foto2': 'images/I92.png',
                    },
                    {
                      'title': 'COLORACAP',
                      'description': 'Impresion de Tapas',
                      'color': Colors.lime[800]!,
                      'Foto': 'images/coloracap.png',
                      'Foto2': 'images/coloracap2.png',
                    },
                    {
                      'title': 'CCM',
                      'description': 'Tapas 2,5 cm',
                      'color': Colors.deepPurple,
                      'Foto': 'images/CCM.png',
                      'Foto2': 'images/CCM2.png',
                    },
                    {
                      'title': 'SOPLADO',
                      'description': 'Botellas',
                      'color': Colors.blueGrey,
                      'Foto': 'images/soplado.png',
                      'Foto2': 'images/soplado2.png',
                    },
                    {
                      'title': 'I5',
                      'description': 'Preformas I5(Grandes)',
                      'color': Colors.indigo,
                      'Foto': 'images/I5.png',
                      'Foto2': 'images/I52.png',
                    },                           
                    {
                      'title': 'IT 2 HX-258',
                      'description': 'Tapas 6 cm y Azas',
                      'color': Colors.green,
                      'Foto': 'images/IT.png',
                      'Foto2': 'images/IT2.png',
                    },
                    {
                      'title': 'YUTZUMI',
                      'description': 'Tapas Bidon',
                      'color': Colors.deepOrange,
                      'Foto': 'images/I6.png',
                      'Foto2': 'images/I62.png',
                    }                  
                  ];

    return Scaffold(      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF486581), // Color gris azulado
                    Color(0xFF8E9AB0), // Color lavanda
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(                
                children: [
                  const SizedBox(height: 35,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 5),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              color: Colors.black,
                              icon: const Icon(Icons.arrow_back, size: 32.0),
                              onPressed: () {
                                Navigator.pop(context);                   
                              },
                            ),
                          ),
                          const SizedBox(width: 30,),
                          const Text(
                          'Estado de Registros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Color gris azulado
                          ),
                        ),
                        const Spacer(),
                        ],
                      ),
                    ),
                  ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                              'En esta sección se supervisa y controla el estado de los registros, permitiendo su apertura y cierre según el proceso',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70, // Color gris azulado
                              ),
                            ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: providerregistro.idsRegistrosList.length,
    itemBuilder: (context, index) {
      final datos = providerregistro.idsRegistrosList[index];
      final Linea = LineasDescripcion[index];

      return Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📷 Imagen a la izquierda
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                datos.estado ? Linea['Foto'] : Linea['Foto2'],
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),

            // 📄 Contenido a la derecha
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Linea['color'].withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Linea['title'],
                      style: TextStyle(
                        fontSize: 18,
                        color: datos.estado
                                      ? Colors.black
                                      : Colors.black26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      Linea['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color:  datos.estado
                                      ? Colors.black
                                      : Colors.black26,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () async {                            
                    // Verificar si ya se hizo clic recientemente
                    if (_ultimoEnvio != null &&
                          DateTime.now().difference(_ultimoEnvio!) < Duration(seconds: 2)) {
                      return;
                    }
                    
                    // Actualizar momento del último clic válido
                    _ultimoEnvio = DateTime.now();
                              if (!datos.estado) {
                                // Estado es false, intentamos abrir y obtener un ID con el método adecuado
                                try {
                                  int messageId;                    
                                  // Seleccionamos el método adecuado según el índice
                                  switch (index) {
                                    case 0:
                                      messageId =
                                          await providerregistro.createRegistroIPS();                                          
                                      break;
                                    case 1:
                                      messageId = 20;                                      
                                      break;
                                    case 2:
                                      messageId = 60;                                      
                                      break;
                                    case 3:
                                      messageId = 40;                                      
                                      break;
                                    case 4:
                                      messageId = 50;                                      
                                      break;
                                    case 5:
                                      messageId = 60;                                      
                                      break;
                                    case 6:
                                      messageId = 70;                                      
                                      break;
                                    case 7:
                                      messageId = 70;                                      
                                      break;
                                    default:
                                      throw Exception("Índice fuera de rango");
                                  }
                    
                                  if (context.mounted) {
                                    final updatedDatito = datos.copyWith(
                                      numero: messageId, // Guarda el ID obtenido
                                      estado:
                                          true, // Cambia el estado a "abierto"
                                    );
                    
                                    providerregistro.updateDatito(
                                        datos.id!, updatedDatito);
                                  }
                                } catch (e) {
                                                                if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Error al abrir: $e')),
                                    );
                                  }
                                }
                              } else {
                                // Estado es true, mostramos una alerta de confirmación antes de cerrar
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirmación"),
                                      content: const Text(
                                          "¿Está seguro de que desea cerrar este registro?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cerrar el diálogo sin hacer nada
                                          },
                                          child: const Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Llamar un método diferente de providerIPS según el índice
                                            switch (index) {
                                              case 0:
                                                providerIPS.finishProcess();                                          
                                                providerdatosips.clearData();                                              break;
                                              case 1:
                                                providerIPS.finishProcess();                                          
                                                providerdatosips.clearData(); 
                                                break;
                                              case 2:
                                                //providerIPS.finishProcessCCM();
                                                break;
                                              case 3:
                                                //providerIPS.finishProcessColoracap();
                                                break;
                                              case 4:
                                                //providerIPS.finishProcessYutzumi();
                                                break;
                                              case 5:
                                                //providerIPS.finishProcessIT2HX258();
                                                break;
                                              case 6:
                                                //providerIPS.finishProcessSoplado();
                                                break;
                                              case 7:
                                                //providerIPS.finishProcessSoplado();
                                                break;
                                              default:
                                                //providerIPS.finishProcess();
                                                break;
                                            }
                                            Navigator.of(context).pop();
                                            final updatedDatito = datos.copyWith(
                                              estado: false, // Cambia a "cerrado"
                                            );
                                            providerregistro.updateDatito(
                                                datos.id!, updatedDatito);
                                          },
                                          child: const Text("Cerrar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Linea['color'],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(datos.estado ? 'Cerrar' : 'Abrir'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
),
              ]),
          );
 
  }
}
