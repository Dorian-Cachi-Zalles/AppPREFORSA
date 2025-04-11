import 'dart:convert';
import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:control_de_calidad/widgets/titulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ColoranteIPSProvider with ChangeNotifier {
  
  final String baseUrl = '${Config.baseUrl}/coloranteIPS';
  SharedPreferences? _prefs;
  bool isLoading = true; // Nueva bandera para controlar la carga
  bool seenvia =true;
  String Colorante = "";
  String Codigo= "";
  String KL = "";
  String BP = "";
  double Dosificacion = 0.0;
  int CantidadBolsones = 1;
  int ID_regis = 0;
  


  ColoranteIPSProvider() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();
    isLoading = false; // Indicar que los datos ya se cargaron
    notifyListeners(); 
  }

  void _loadData() {
    if (_prefs == null) return;
    seenvia = _prefs!.getBool("miBooleano") ?? true;
    Colorante = _prefs!.getString("Colorante") ?? "";
    Codigo= _prefs!.getString("Codigo") ?? "";
    KL =_prefs!.getString("KL") ?? "";
    BP = _prefs!.getString("BP") ?? "";
    Dosificacion = _prefs!.getDouble("Dosificacion") ?? 0.0;
    CantidadBolsones = _prefs!.getInt("CantidadBolsones") ?? 1;
    ID_regis = _prefs!.getInt("CantidadBolsones") ?? 1;    
    
  }

  Future<void> updateData({bool?seenvia,
  String?Colorante,
  String?Codigo,
  String?KL,
  String?BP,
  double?Dosificacion,
  int?CantidadBolsones,
  int?ID_regis,
  }) async {
    if (_prefs == null) return;

    if (seenvia != null) {
      await _prefs!.setBool("seenvia", seenvia);
      this.seenvia = seenvia;
    }
    if (Colorante != null) {
      await _prefs!.setString("Colorante", Colorante);
      this.Colorante = Colorante;
    }
    if (Codigo != null) {
      await _prefs!.setString("Codigo", Codigo);
      this.Codigo = Codigo;
    }
    if (KL != null) {
      await _prefs!.setString("KL", KL);
      this.KL = KL;
    }
    if (BP != null) {
      await _prefs!.setString("BP", BP);
      this.BP = BP;
    }
    if (Dosificacion != null) {
      await _prefs!.setDouble("Dosificacion", Dosificacion);
      this.Dosificacion = Dosificacion;
    }
    if (CantidadBolsones != null) {
      await _prefs!.setInt("CantidadBolsones", CantidadBolsones);
      this.CantidadBolsones = CantidadBolsones;
    }
    if (ID_regis != null) {
      await _prefs!.setInt("ID_regis", ID_regis);
      this.ID_regis = ID_regis;
    }

    notifyListeners(); 
  }

  Future<void> updateDatabase() async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "Colorante": Colorante,
          "Codigo": Codigo,
          "KL": KL,
          "BP": BP,
          "Dosificacion": Dosificacion,
          "CantidadBolsones": CantidadBolsones,
          "ID_regis":ID_regis,        
          
        }),
      );
    
      if (response.statusCode != 200) {
        
      }
    } catch (e) {
     
    }
  }

  Future<void> clearData() async {
    if (_prefs == null) return;
    await _prefs!.clear();
    seenvia = true;
    Colorante = " ";
    Codigo= " ";
    KL = " ";
    BP = " ";
    Dosificacion = 0.0;
    CantidadBolsones = 1;
    ID_regis = 0;
    notifyListeners();
  }
}

class FormularioColoranteIPS extends StatefulWidget {
  @override
  _FormularioColoranteIPSState createState() => _FormularioColoranteIPSState();
}

class _FormularioColoranteIPSState extends State<FormularioColoranteIPS> {
  final _formKey = GlobalKey<FormBuilderState>();

  // Mapa para las opciones de Dropdowns
  final Map<String, List<dynamic>> dropOptionsColorante = {
    'Colorante': ['Al inicio', 'Medio', 'Final'],
    'CantidadBolsones': [1, 2, 3, 4, 5, 6],
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ColoranteIPSProvider>(context, listen: false)._initPrefs(),
      builder: (context, snapshot) {
        return Consumer<ColoranteIPSProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  // Cerrar el teclado cuando se toque fuera de un campo
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(0),
                  child: FormBuilder(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: FocusScope(
                      node: FocusScopeNode(),// FocusScope global para todo el formulario
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Titulos(
                              titulo: 'Formulario Colorante IPS',
                              tipo: 0,            
                            ),
                            const SizedBox(height: 10,),
                          if (provider.isLoading) // Mostrar solo si está cargando
                            Center(child: CircularProgressIndicator())
                          else ...[
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownSimple<String>(
                                    name: 'Colorante',
                                    label: 'Colorante',
                                    valorInicial: provider.Colorante,
                                    textoError: 'Seleccione un colorante',
                                    opciones: 'Colorante',
                                    dropOptions: dropOptionsColorante,
                                    onChanged: (value) {
                                      provider.updateData(Colorante: value);
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CustomInputField(
                                    name: 'Codigo',
                                    label: 'Codigo',
                                    valorInicial: provider.Codigo,
                                    isRequired: true,
                                    onChanged: (value) {
                                      provider.updateData(Codigo: value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    name: 'KL',
                                    label: 'KL',
                                    valorInicial: provider.KL,
                                    isNumeric: true,
                                    isRequired: true,
                                    onChanged: (value) {
                                      provider.updateData(KL: value);
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CustomInputField(
                                    name: 'BP',
                                    label: 'BP',
                                    valorInicial: provider.BP,
                                    isNumeric: true,
                                    isRequired: true,
                                    onChanged: (value) {
                                      provider.updateData(BP: value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    name: 'Dosificacion',
                                    label: 'Dosificacion',
                                    valorInicial: provider.Dosificacion.toString(),
                                    isNumeric: true,
                                    isRequired: true,
                                    onChanged: (value) {
                                      provider.updateData(Dosificacion: double.tryParse(value!) ?? 0.0);
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: DropdownSimple<int>(
                                    name: 'CantidadBolsones',
                                    label: 'CantidadBolsones',
                                    valorInicial: provider.CantidadBolsones,
                                    textoError: 'Seleccione una opción',
                                    opciones: 'CantidadBolsones',
                                    dropOptions: dropOptionsColorante,
                                    onChanged: (value) {
                                      provider.updateData(CantidadBolsones: value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            TextButton.icon(
                                        style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blueAccent.withOpacity(0.2), // celeste plomo
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                         
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                                        ),
                                        onPressed: () {
                      provider.updateData(seenvia: false);
                      provider.updateDatabase();
                      Navigator.of(context)
                                                  .pop();
                                        },
                                        icon: const Icon(Icons.send, size: 20),
                                        label: const Text(
                      'Enviar Colorante',
                      style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
