import 'package:control_de_calidad/Configuraciones/catalogodropdowns.dart';
import 'package:control_de_calidad/Providers/ProviderI6.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/widgets/Alertas.dart';
import 'package:control_de_calidad/widgets/boton_agregar.dart';
import 'package:control_de_calidad/widgets/boton_guardar.dart';
import 'package:control_de_calidad/widgets/boxformularios.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:control_de_calidad/widgets/titulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatosPESOSIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String Hora;
  final String PA;
  final double PesoTara;
  final double PesoNeto;
  final double PesoTotal;

  // Constructor de la clase
  const DatosPESOSIPS(
      {this.id,
      required this.hasErrors,
      required this.hasSend,
      required this.idregistro,
      required this.Hora,
      required this.PA,
      required this.PesoTara,
      required this.PesoNeto,
      required this.PesoTotal});

  // Factory para crear una instancia desde un Map
  factory DatosPESOSIPS.fromMap(Map<String, dynamic> map) {
    return DatosPESOSIPS(
        id: map['id'] as int?,
        hasErrors: map['hasErrors'] == 1,
        hasSend: map['hasSend'] == 1,
        idregistro: map['idregistro'] as int,        
        Hora: map['Hora'] as String,
        PA: map['PA'] as String,
        PesoTara: map['PesoTara'] as double,
        PesoNeto: map['PesoNeto'] as double,
        PesoTotal: map['PesoTotal'] as double);
  }

  // Método para usar con API (cuando los datos vienen en formato JSON)
  factory DatosPESOSIPS.fromJson(Map<String, dynamic> json) {
    return DatosPESOSIPS(
      id: json['id'],
      hasErrors: json['hasErrors'] ?? false,  // ✅ Evita null en booleanos
      hasSend: json['hasSend'] ?? false,
      idregistro: json['idregistro']?? 0,  // ✅ Evita null en enteros
      Hora: json['Hora']?? '',  // ✅ Evita null en cadenas
      PA: json['PA']?? '',
      PesoTara: (json['PesoTara'] ?? 0.0).toDouble(),
      PesoNeto: (json['PesoTara'] ?? 0.0).toDouble(),
      PesoTotal: (json['PesoTara'] ?? 0.0).toDouble(),
    );
  }

  // Método para convertir la instancia a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'hasErrors': hasErrors ? 1 : 0,
      'hasSend': hasSend ? 1 : 0,
      'idregistro': idregistro,
      'Hora': Hora,
      'PA': PA,
      'PesoTara': PesoTara,
      'PesoNeto': PesoNeto,
      'PesoTotal': PesoTotal
    };
  }

  // Método copyWith
  DatosPESOSIPS copyWith(
      {int? id,
      bool? hasErrors,
      bool? hasSend,
      int? idregistro,
      String? Hora,
      String? PA,
      double? PesoTara,
      double? PesoNeto,
      double? PesoTotal}) {
    return DatosPESOSIPS(
        id: id ?? this.id,
        hasErrors: hasErrors ?? this.hasErrors,
        hasSend: hasSend ?? this.hasSend,
        idregistro: idregistro ?? this.idregistro,
        Hora: Hora ?? this.Hora,
        PA: PA ?? this.PA,
        PesoTara: PesoTara ?? this.PesoTara,
        PesoNeto: PesoNeto ?? this.PesoNeto,
        PesoTotal: PesoTotal ?? this.PesoTotal);
  }
}

class ScreenListDatosPESOSIPS extends StatelessWidget {
  const ScreenListDatosPESOSIPS({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          const Titulos(
            titulo: 'REGISTROS DE PESOS',
            tipo: 0,            
          ),
          Expanded(
            child: Consumer<DatosProviderPrefIPS>(
              builder: (context, provider, _) {
                final datosPESOSIPS = provider.datospesosipsList;

                if (datosPESOSIPS.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay registros aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: datosPESOSIPS.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dtdatospesosips = datosPESOSIPS[index];

                    return GradientExpandableCard(
                      idlista: dtdatospesosips.id,
                      hasSend: dtdatospesosips.hasSend, 
                      numeroindex: (index + 1).toString(),
                      onSwipedAction:() async {
    await provider.removePeso(
      dtdatospesosips.id!,
      (onUndo) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Registro eliminado'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: onUndo,
            ),
          ),
        );
      },
    );
  },
                      subtitulos: {
                        'Hora': dtdatospesosips.Hora,
                        'PA': dtdatospesosips.PA,                       
                      },
                      expandedContent: generateExpandableContent([
                        ['PesoTara: ', 1, dtdatospesosips.PesoTara.toString()],
                        ['PesoNeto: ', 1, dtdatospesosips.PesoNeto.toString()],
                        ['PesoTotal: ',1,dtdatospesosips.PesoTotal.toString()],
                      ]),
                      hasErrors: dtdatospesosips.hasErrors,
                      onOpenModal:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosPESOSIPSForm(
                              id: dtdatospesosips.id!,
                              datosPESOSIPS: dtdatospesosips,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BotonAgregar(
        onPressed: () async {
  int? idregistro = await providerregistro.getNumeroById(1);

  if (idregistro == null || idregistro == 0) {
  
    return; // Detiene la ejecución si el idregistro es 0 o null
  } provider.addPesosIPS(DatosPESOSIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: idregistro,  // Ya sabemos que no es 0 ni null
    Hora: DateFormat('HH:mm').format(DateTime.now()),
    PA: ' ',
    PesoTara: 0,
    PesoNeto: 0,
    PesoTotal: 0,
  ));  
},
      ),
    );
  }
}

class EditProviderDatosPESOSIPS with ChangeNotifier {
  double _pesoNeto = 0.0;

  double get pesoNeto => _pesoNeto;

  set pesoNeto(double value) {
    _pesoNeto = value;
    notifyListeners();
  }
}

class EditDatosPESOSIPSForm extends StatefulWidget {
  final int id;
  final DatosPESOSIPS datosPESOSIPS;

  const EditDatosPESOSIPSForm(
      {required this.id, required this.datosPESOSIPS, super.key});

  @override
  EditDatosPESOSIPSFormState createState() => EditDatosPESOSIPSFormState();
}

class EditDatosPESOSIPSFormState extends State<EditDatosPESOSIPSForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

 

  @override
  void initState() {
    super.initState();
    // Validación inicial después de la construcción del widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.saveAndValidate();
    });
  }

  @override
  Widget build(BuildContext context) {
  final catalogosProvider = Provider.of<CatalogosProvider>(context);    
  final Map<String, List<dynamic>> dropOptionsDatosPESOSIPS =
        catalogosProvider.getCatalogo('PESOSIPS');
    return Consumer<EditProviderDatosPESOSIPS>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
            body: Column(children: [
          const Titulos(titulo: 'Formulario de Pesos', tipo: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: FormularioGeneralDatosPESOSIPS(
                  formKey: _formKey,
                  widget: widget,
                  dropOptions: dropOptionsDatosPESOSIPS,
                ),
              ),
            ),
          ),
          BotonDeslizable(
  onPressed: () async {
  if (!mounted) return;
  final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
  final updatedDatito = obtenerDatosActualizados();

  await provider.updatePESO(widget.id, updatedDatito);

  if (!mounted) return;
  Navigator.pop(context);
},
  onSwipedAction: () async {
  if (!mounted) return;
  final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
  final updatedDatito = obtenerDatosActualizados();
  await provider.updatePESO(widget.id, updatedDatito);
  bool enviado = await provider.enviarDatosAPIPeso(widget.id);
  if (!mounted) return; 
  if (!enviado) {
    EnviadoDialog.mostrar(context, false);
    return; 
  }
  final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
  await provider.updatePESO(widget.id, updatedDatitoEnviado);
  if (!mounted) return;

  EnviadoDialog.mostrar(context, true);
  Navigator.pop(context);
},
)
        ]));
      },
    );
  }
  // Función para obtener los datos actualizados y evitar repeticiones
  DatosPESOSIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;

  return widget.datosPESOSIPS.copyWith(
    hasErrors: _formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
    idregistro: widget.datosPESOSIPS.idregistro,
    hasSend: hasSend,
    Hora: values['Hora'] ?? widget.datosPESOSIPS.Hora,
    PA: values['PA'] ?? widget.datosPESOSIPS.PA,
    PesoTara: double.tryParse(values['PesoTara'] ?? '') ?? 0,
    PesoNeto: double.tryParse(values['PesoNeto'] ?? '') ?? 0,
    PesoTotal: double.tryParse(values['PesoTotal'] ?? '') ?? 0,
  );
}
}

class FormularioGeneralDatosPESOSIPS extends StatelessWidget {
  const FormularioGeneralDatosPESOSIPS({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.widget,
    required this.dropOptions,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final dynamic widget;
  final Map<String, List<dynamic>> dropOptions;
  void _updatePesoTotal(BuildContext context) {
    final formState = _formKey.currentState;

    if (formState != null) {
      // Obtén los valores actuales de PesoTara y PesoNeto
      final pesoTara =
          double.tryParse(formState.fields['PesoTara']?.value ?? '0') ?? 0.0;
      final pesoNeto =
          double.tryParse(formState.fields['PesoNeto']?.value ?? '0') ?? 0.0;

      // Calcula el PesoTotal
      final pesoTotal = pesoTara + pesoNeto;

      // Actualiza el campo PesoTotal
      formState.fields['PesoTotal']?.didChange(pesoTotal.toStringAsFixed(2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(children: [
          const SizedBox(
            height: 15,
          ),
          CustomInputField(
              name: 'Hora',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Hora'];
                field?.validate();
                field?.save();
              },
              label: 'Hora',
              isreadonly: true,
              isNumeric: false,
              valorInicial: widget.datosPESOSIPS.Hora,
              isRequired: true,
              ),
          CustomInputField(
              name: 'PA',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['PA'];
                field?.validate();
                field?.save();
              },
              label: 'PA',
              valorInicial: widget.datosPESOSIPS.PA,
              isRequired: true,),
        CustomInputField(
              name: 'PesoTara',
                            
              onChanged: (value) {                
                final field = _formKey.currentState?.fields['PesoTara'];
                field?.validate(); // Valida solo este campo
                field?.save();
                _updatePesoTotal(context);
              },
              label: 'Peso Tara [Kg]',
              valorInicial: widget.datosPESOSIPS.PesoTara == 0 ? '': widget.datosPESOSIPS.PesoTara.toString(),
              isNumeric: true,
              isRequired: true,              
              min: 0,
              max: 100,                          
              ),
          CustomInputField(
              name: 'PesoNeto',
              onChanged: (value) {               
                final field = _formKey.currentState?.fields['PesoNeto'];
                field?.validate(); // Valida solo este campo
                field?.save();
                _updatePesoTotal(context);
              },
              label: 'Peso Neto [Kg]',
              valorInicial: context
                  .watch<EditProviderDatosPESOSIPS>()
                  .pesoNeto
                  .toString(),
              isNumeric: true,
              isRequired: true,              
              min: 0,
              max: 10000,
              ),
          CustomInputField(
              name: 'PesoTotal',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['PesoTotal'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Peso Total[kg]',
              valorInicial: widget.datosPESOSIPS.PesoTotal.toString(),
              isNumeric: true,
              isRequired: true,              
              min: 0,
              max: 10000,),
        ]));
  }
}
