// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_ctrl_pesos.dart';
import 'package:control_de_calidad/widgets/Alertas.dart';
import 'package:control_de_calidad/widgets/checkboxformulario.dart';
import 'package:http/http.dart' as http;
import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroIPSProvider with ChangeNotifier {
  final String baseUrl = '${Config.baseUrl}/RegistroIPS';
  SharedPreferences? _prefs;
  bool isLoading = true;

  String Modalidad = " ";
  String Lote = " ";
  String Maquinista = " ";
  int Parte = 0;
  String Producto = " ";
  String Gramaje = " ";
  String Empaque = " ";
  String Cavhabilitadas = " ";
  double Ciclo = 0.0;
  double PesoProm = 0.0;
  int PAinicial = 0;
  int PAfinal = 0;
  int Cantidad = 0;
  double Pesopromneto = 0.0;
  double Totalcajascont = 0.0;
  double Saldos = 0.0;
  double Totalprodu = 0.0;
  int Cantidadtotaldepiezas = 0;
  double CantidadtotalKg = 0.0;
  bool Conformidad = false;

  RegistroIPSProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();
    isLoading = false;
    notifyListeners();
  }

  void _loadData() {
    if (_prefs == null) return;
    Modalidad = _prefs!.getString("Modalidad") ?? " ";
    Lote = _prefs!.getString("Lote") ?? " ";
    Maquinista = _prefs!.getString("Maquinista") ?? " ";
    Parte = _prefs!.getInt("Parte") ?? 0;
    Producto = _prefs!.getString("Producto") ?? " ";
    Gramaje = _prefs!.getString("Gramaje") ?? " ";
    Empaque = _prefs!.getString("Empaque") ?? " ";
    Cavhabilitadas = _prefs!.getString("Cavhabilitadas") ?? " ";
    Ciclo = _prefs!.getDouble("Ciclo") ?? 0.0;
    PesoProm = _prefs!.getDouble("PesoProm") ?? 0.0;
    PAinicial = _prefs!.getInt("PAinicial") ?? 0;
    PAfinal = _prefs!.getInt("PAfinal") ?? 0;
    Cantidad = _prefs!.getInt("Cantidad") ?? 0;
    Pesopromneto = _prefs!.getDouble("Pesopromneto") ?? 0.0;
    Totalcajascont = _prefs!.getDouble("Totalcajascont") ?? 0.0;
    Saldos = _prefs!.getDouble("Saldos") ?? 0.0;
    Totalprodu = _prefs!.getDouble("Totalprodu") ?? 0.0;
    Cantidadtotaldepiezas = _prefs!.getInt("Cantidadtotaldepiezas") ?? 0;
    CantidadtotalKg = _prefs!.getDouble("CantidadtotalKg") ?? 0.0;
    Conformidad = _prefs!.getBool("Conformidad") ?? false;
  }

  Future<void> updateData({
    String? Modalidad,
    String? Lote,
    String? Maquinista,
    int? Parte,
    String? Producto,
    String? Gramaje,
    String? Empaque,
    String? Cavhabilitadas,
    double? Ciclo,
    double? PesoProm,
    int? PAinicial,
    int? PAfinal,
    int? Cantidad,
    double? Pesopromneto,
    double? Totalcajascont,
    double? Saldos,
    double? Totalprodu,
    int? Cantidadtotaldepiezas,
    double? CantidadtotalKg,
    bool? Conformidad
  }) async {
    if (_prefs == null) return;

    if (Modalidad != null) {
      await _prefs!.setString("Modalidad", Modalidad);
      this.Modalidad = Modalidad;
    }
    if (Lote != null) {
      await _prefs!.setString("Lote", Lote);
      this.Lote = Lote;
    }
    if (Maquinista != null) {
      await _prefs!.setString("Maquinista", Maquinista);
      this.Maquinista = Maquinista;
    }
    if (Parte != null) {
      await _prefs!.setInt("Parte", Parte);
      this.Parte = Parte;
    }
    if (Producto != null) {
      await _prefs!.setString("Producto", Producto);
      this.Producto = Producto;
    }
    if (Gramaje != null) {
      await _prefs!.setString("Gramaje", Gramaje);
      this.Gramaje = Gramaje;
    }
    if (Empaque != null) {
      await _prefs!.setString("Empaque", Empaque);
      this.Empaque = Empaque;
    }
    if (Cavhabilitadas != null) {
      await _prefs!.setString("Cavhabilitadas", Cavhabilitadas);
      this.Cavhabilitadas = Cavhabilitadas;
    }
    if (Ciclo != null) {
      await _prefs!.setDouble("Ciclo", Ciclo);
      this.Ciclo = Ciclo;
    }
    if (PesoProm != null) {
      await _prefs!.setDouble("PesoProm", PesoProm);
      this.PesoProm = PesoProm;
    }
    if (PAinicial != null) {
      await _prefs!.setInt("PAinicial", PAinicial);
      this.PAinicial = PAinicial;
    }
    if (PAfinal != null) {
      await _prefs!.setInt("PAfinal", PAfinal);
      this.PAfinal = PAfinal;
    }
    if (Cantidad != null) {
      await _prefs!.setInt("Cantidad", Cantidad);
      this.Cantidad = Cantidad;
    }
    if (Pesopromneto != null) {
      await _prefs!.setDouble("Pesopromneto", Pesopromneto);
      this.Pesopromneto = Pesopromneto;
    }
    if (Totalcajascont != null) {
      await _prefs!.setDouble("Totalcajascont", Totalcajascont);
      this.Totalcajascont = Totalcajascont;
    }
    if (Saldos != null) {
      await _prefs!.setDouble("Saldos", Saldos);
      this.Saldos = Saldos;
    }
    if (Totalprodu != null) {
      await _prefs!.setDouble("Totalprodu", Totalprodu);
      this.Totalprodu = Totalprodu;
    }
    if (Cantidadtotaldepiezas != null) {
      await _prefs!.setInt("Cantidadtotaldepiezas", Cantidadtotaldepiezas);
      this.Cantidadtotaldepiezas = Cantidadtotaldepiezas;
    }
    if (CantidadtotalKg != null) {
      await _prefs!.setDouble("CantidadtotalKg", CantidadtotalKg);
      this.CantidadtotalKg = CantidadtotalKg;
    }
    if (Conformidad != null) {
      await _prefs!.setBool("Conformidad", Conformidad);
      this.Conformidad = Conformidad;
    }

    notifyListeners();
  }

  Future<void> updateDatabase() async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "Modalidad": Modalidad,
          "Lote": Lote,
          "Maquinista": Maquinista,
          "Parte": Parte,
          "Producto": Producto,
          "Gramaje": Gramaje,
          "Empaque": Empaque,
          "Cavhabilitadas": Cavhabilitadas,
          "Ciclo": Ciclo,
          "PesoProm": PesoProm,
          "PAinicial": PAinicial,
          "PAfinal": PAfinal,
          "Cantidad": Cantidad,
          "Pesopromneto": Pesopromneto,
          "Totalcajascont": Totalcajascont,
          "Saldos": Saldos,
          "Totalprodu": Totalprodu,
          "Cantidadtotaldepiezas": Cantidadtotaldepiezas,
          "CantidadtotalKg": CantidadtotalKg,
          "Conformidad": Conformidad ? 1 : 0,
        }),
      );
      const EnviadoDialog(seEnvio: true,);       
      if (response.statusCode != 200) { 
        const EnviadoDialog(seEnvio: false,);      
      }
    } catch (e) {
      const EnviadoDialog(seEnvio: false,); 
    }
  }

  Future<void> clearData() async {
    if (_prefs == null) return;
    await _prefs!.clear();
    Modalidad = " ";
    Lote = " ";
    Maquinista = " ";
    Parte = 0;
    Producto = " ";
    Gramaje = " ";
    Empaque = " ";
    Cavhabilitadas = " ";
    Ciclo = 0.0;
    PesoProm = 0.0;
    PAinicial = 0;
    PAfinal = 0;
    Cantidad = 0;
    Pesopromneto = 0.0;
    Totalcajascont = 0.0;
    Saldos = 0.0;
    Totalprodu = 0.0;
    Cantidadtotaldepiezas = 0;
    CantidadtotalKg = 0.0;
    Conformidad = false;
    notifyListeners();
  }
}

/* Código generado para el formulario Flutter */
class FormularioRegistroIPS extends StatefulWidget {
  @override
  _FormularioRegistroIPSState createState() => _FormularioRegistroIPSState();
}

class _FormularioRegistroIPSState extends State<FormularioRegistroIPS> {
  final _formKey = GlobalKey<FormBuilderState>();

  // Mapa para las opciones de Dropdowns
  final Map<String, List<dynamic>> dropOptionsColorante = {
    'Modalidad': ['Normal', 'Prueba'],
    'Maquinista': ['Agustin Fernadez', 'Roberto Condori','Limber Flores'],    
    'Producto': ['CRISTAL EC30', 'VERDE EC30', 'AZUL Z EC30','PLATEADO EC30','ECO CRISTAL EC30'],
    'Gramaje': ['20.1 M5 R', '23.6 M5 R', '46.6 M5 R','54.6 M5 R'],
    'Empaque': ['Caja', 'Jaula Pequeña', 'Jaula Grande'], 
    'Cavhabilitadas': ['96', '95', '94','93','92','91','90'],

  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<RegistroIPSProvider>(context, listen: false)._initPrefs(),
      builder: (context, snapshot) {
        return Consumer<RegistroIPSProvider>(
          builder: (context, provider, child) {            

    void updateCantidad(BuildContext context) {
    final formState = _formKey.currentState;

    if (formState != null) {
      // Obtén los valores actuales de PesoTara y PesoNeto
    final String gramaje = formState.fields['Gramaje']?.value ?? '';
    final String empaque = formState.fields['Empaque']?.value ?? '';
    final Map<String, Map<String, int>> dataLookup = {
      'Caja': {
        '20.1 M5 R': 16032,
        '23.6 M5 R': 15840,
        '46.6 M5 R': 7584,
        '54.6 M5 R': 7488,
      },
      'Jaula Pequeña': {
        '20.1 M5 R': 14016,
        '23.6 M5 R': 13728,
        '46.6 M5 R': 6528,
        '54.6 M5 R': 6432,
      },
      'Jaula Grande': {
        '20.1 M5 R': 16032,
        '23.6 M5 R': 15840,
        '46.6 M5 R': 7584,
        '54.6 M5 R': 7488,
      }
    };
    int cantidad0 = dataLookup[empaque]?[gramaje] ?? 0; // Inicializamos con 0      

    // Actualiza el campo 'Cantidad'
    formState.fields['Cantidad']?.didChange(cantidad0.toString());
    }
  } 
  void updatepesopromeneto(BuildContext context) {
    final formState = _formKey.currentState;

    if (formState != null) {
      // Obtén los valores actuales de PesoTara y PesoNeto
      final cantidad1 =
          int.tryParse(formState.fields['Cantidad']?.value ?? '0') ?? 0.0;
      final pesoprom =
          double.tryParse(formState.fields['PesoProm']?.value ?? '0') ?? 0.0;

      // Calcula el PesoTotal
      final pesopromneto = (cantidad1 * pesoprom)/1000;

      // Actualiza el campo PesoTotal
      formState.fields['Pesopromneto']?.didChange(pesopromneto.toStringAsFixed(2));
    }
  } 
  void updatecantidpiz(BuildContext context) {
    final formState = _formKey.currentState;

    if (formState != null) {
      // Obtén los valores actuales de PesoTara y PesoNeto
      final cantidad =
          int.tryParse(formState.fields['Cantidad']?.value ?? '0') ?? 0.0;
      final cajasprodu =
          double.tryParse(formState.fields['Totalprodu']?.value ?? '0') ?? 0.0;

      // Calcula el PesoTotal
      final cantidapie = (cantidad  * cajasprodu).toInt();

      // Actualiza el campo PesoTotal
      formState.fields['Cantidadtotaldepiezas']?.didChange(cantidapie.toString());
    }
  }
  void updateKilostotal(BuildContext context) {
    final formState = _formKey.currentState;

    if (formState != null) {
      // Obtén los valores actuales de PesoTara y PesoNeto
      final pesopromnet =
          double.tryParse(formState.fields['Pesopromneto']?.value ?? '0') ?? 0.0;
      final cajasprodu =
          double.tryParse(formState.fields['Totalprodu']?.value ?? '0') ?? 0.0;

      // Calcula el PesoTotal
      final cantidapie = (pesopromnet * cajasprodu);

      // Actualiza el campo PesoTotal
      formState.fields['CantidadtotalKg']?.didChange(cantidapie.toStringAsFixed(2));
    }
  }

          List<Widget> fields = [
            DropdownSimple<String>(
  name: 'Modalidad',
  label: 'Modalidad',
  valorInicial: provider.Modalidad,
  textoError: 'Seleccione un valor para Modalidad',
  opciones: 'Modalidad', // Asegúrate de definir las opciones en un mapa de dropdowns
  dropOptions: dropOptionsColorante,
  onChanged: (value) {
    provider.updateData(Modalidad: value);
  },
),
CustomInputField(
  name: 'Lote',
  label: 'Lote',
  valorInicial: provider.Lote.toString(),
  isRequired: true,
  maxLength: 10,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Lote: value ?? ' ');
  },
),
DropdownSimple<String>(
  name: 'Maquinista',
  label: 'Maquinista',
  valorInicial: provider.Maquinista,
  textoError: 'Seleccione un valor para Maquinista',
  opciones: 'Maquinista', // Asegúrate de definir las opciones en un mapa de dropdowns
  dropOptions: dropOptionsColorante,
  onChanged: (value) {
    provider.updateData(Maquinista: value);
  },
),
CustomInputField(
  name: 'Parte',
  label: 'Parte',
  valorInicial: provider.Parte.toString(),
  isRequired: true,
  maxLength: 6,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Parte: int.tryParse(value!) ?? 0);
  },
),
DropdownSimple<String>(
  name: 'Producto',
  label: 'Producto',
  valorInicial: provider.Producto,
  textoError: 'Seleccione un valor para Producto',
  opciones: 'Producto', // Asegúrate de definir las opciones en un mapa de dropdowns
  dropOptions: dropOptionsColorante,
  onChanged: (value) {
    provider.updateData(Producto: value);
  },
),
DropdownSimple<String>(
  name: 'Gramaje',
  label: 'Gramaje',
  valorInicial: provider.Gramaje,
  textoError: 'Seleccione un valor para Gramaje',
  opciones: 'Gramaje', // Asegúrate de definir las opciones en un mapa de dropdowns
  dropOptions:dropOptionsColorante,
  onChanged: (value) {
    provider.updateData(Gramaje: value);
     updateCantidad(context);
  },
),
DropdownSimple<String>(
  name: 'Empaque',
  label: 'Empaque',
  valorInicial: provider.Empaque,
  textoError: 'Seleccione un valor para Empaque',
  opciones: 'Empaque', // Asegúrate de definir las opciones en un mapa de dropdowns
  dropOptions: dropOptionsColorante,
  onChanged: (value) {
    provider.updateData(Empaque: value);
    updateCantidad(context);
  },
),
DropdownSimple<String>(
  name: 'Cavhabilitadas',
  label: 'Cavidades habilitadas',
  valorInicial: provider.Cavhabilitadas,
  textoError: 'Seleccione un valor para Cavhabilitadas',
  opciones: 'Cavhabilitadas', // Asegúrate de definir las opciones en un mapa de dropdowns
  dropOptions: dropOptionsColorante,
  onChanged: (value) {
    provider.updateData(Cavhabilitadas: value);
  },
),
CustomInputField(
  name: 'Ciclo',
  label: 'Ciclo',
  valorInicial: provider.Ciclo.toString(),
  isNumeric: true,
  min: 0,
  max: 27,
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Ciclo: double.tryParse(value!) ?? 0.0);   
  },
),
CustomInputField(
  name: 'PesoProm',
  label: 'Peso Promedio [g]',
  valorInicial: provider.PesoProm.toString(),
  isRequired: true,
  isNumeric: true,
  min: 0,
  max: 60,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(PesoProm: double.tryParse(value!) ?? 0.0);
    updatepesopromeneto(context);
  },
),
CustomInputField(
  name: 'PAinicial',
  label: 'PA inicial',
  valorInicial: provider.PAinicial.toString(),
  isNumeric: true,
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(PAinicial: int.tryParse(value!) ?? 0);
  },
),
CustomInputField(
  name: 'PAfinal',
  label: 'PA final',
  isNumeric: true,
  valorInicial: provider.PAfinal.toString(),
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(PAfinal: int.tryParse(value!) ?? 0);
  },
),
CustomInputField(
  name: 'Cantidad',
  label: 'Cantidad',
  isNumeric: true,
  valorInicial: provider.Cantidad.toString(),
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Cantidad: int.tryParse(value!) ?? 0);
    updatepesopromeneto(context);
    updatecantidpiz(context);
  },
),
CustomInputField(
  name: 'Pesopromneto',
  label: 'Peso prom cont. neto [Kg]',
  valorInicial: provider.Pesopromneto.toString(),
  isNumeric: true,
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Pesopromneto: double.tryParse(value!) ?? 0.0);  
     updateKilostotal(context);
     double? newValue = double.tryParse(value);
  if (newValue != null) {
    context.read<EditProviderDatosPESOSIPS>().pesoNeto = newValue;
  }  
  },
),
CustomInputField(
  name: 'Totalcajascont',
  label: 'Total Cajas Controladas',
  valorInicial: provider.Totalcajascont.toString(),
  isNumeric: true,
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Totalcajascont: double.tryParse(value!) ?? 0.0);
  },
),
CustomInputField(
  name: 'Saldos',
  label: 'Cajas sin declarar',
  valorInicial: provider.Saldos.toString(),
  isNumeric: true,
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Saldos: double.tryParse(value!) ?? 0.0);
  },
),
CustomInputField(
  name: 'Totalprodu',
  label: 'Total Cajas Producidas',
  isNumeric: true,
  valorInicial: provider.Totalprodu.toString(),
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Totalprodu: double.tryParse(value!) ?? 0.0);
     updatecantidpiz(context);
     updateKilostotal(context);
  },
),
CustomInputField(
  name: 'Cantidadtotaldepiezas',
  label: 'Cantidad total de piezas',
  valorInicial: provider.Cantidadtotaldepiezas.toString(),
  isRequired: true,
  isNumeric: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(Cantidadtotaldepiezas: int.tryParse(value!) ?? 0);
  },
),
CustomInputField(
  name: 'CantidadtotalKg',
  label: 'Cantidad total Kg',
  valorInicial: provider.CantidadtotalKg.toString(),
  isNumeric: true,
  isRequired: true,
  onChanged: (value) {
    // Convertir el valor según el tipo de dato
    provider.updateData(CantidadtotalKg: double.tryParse(value!) ?? 0.0);
  },
),
CheckboxSimple(
  name: 'Conformidad',
  label: 'Conformidad',
  valorInicial: provider.Conformidad,
  onChanged: (value) {
    provider.updateData(Conformidad: value);
  },
),          ];
            return Scaffold(
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          const SizedBox(height: 10,),
                      if (provider.isLoading) // Mostrar solo si está cargando
                        Center(child: CircularProgressIndicator())
                      else ...[
                       ...buildFieldRows(fields),   
                      ],                     
                    ],                    
                  ),                                   
                ),                                
              ),
              bottomNavigationBar: _BotonGuardar(context,provider.updateDatabase)           
            );
          },
        );
        
      },
      
    );
  } 
Widget _BotonGuardar(BuildContext context, VoidCallback onPressed) {
  return Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
    child: SizedBox(
      height: 53,
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 187, 206, 243),
              Color.fromARGB(255, 117, 165, 247),
            ],
          ),
          borderRadius: BorderRadius.circular(8), // Ajusta según lo necesites
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: onPressed,
          icon: const Icon(Icons.save, color: Colors.black),
          label: const Text(
            'GUARDAR REGISTRO',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ),
  );
}  

List<Widget> buildFieldRows(List<Widget> fields) {
  List<Widget> rows = [];
  
  for (int i = 0; i < fields.length; i += 2) {
    rows.add(
      Row(
        children: [
          Expanded(child: fields[i]), // Primer campo
          const SizedBox(width: 10), // Espaciado entre campos
          if (i + 1 < fields.length) Expanded(child: fields[i + 1]), // Segundo campo si existe
        ],
      ),
    );
  }
  
  return rows;
}

}


