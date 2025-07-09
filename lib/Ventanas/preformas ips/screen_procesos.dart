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


class DatosPROCEIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String Hora;
  final String PAprod;
  final List<double> TempTolvaSec;
  final double TempProd;
  final double Tciclo;
  final double Tenfri;

  // Constructor de la clase
  const DatosPROCEIPS({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.Hora,
    required this.PAprod,
    required this.TempTolvaSec,
    required this.TempProd,
    required this.Tciclo,
    required this.Tenfri
  });

  // Factory para crear una instancia desde un Map
  factory DatosPROCEIPS.fromMap(Map<String, dynamic> map) {
    return DatosPROCEIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      Hora: map['Hora'] as String,
      PAprod: map['PAprod'] as String,
      TempTolvaSec: (map['TempTolvaSec'] as String).split(',').where((item) => item.isNotEmpty).map(double.parse).toList(),
      TempProd: map['TempProd'] as double,
      Tciclo: map['Tciclo'] as double,
      Tenfri: map['Tenfri'] as double
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
      'PAprod': PAprod,
      'TempTolvaSec': TempTolvaSec.join(','),
      'TempProd': TempProd,
      'Tciclo': Tciclo,
      'Tenfri': Tenfri
    };
  }

  // Método copyWith
  DatosPROCEIPS copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? Hora, String? PAprod, List<double>? TempTolvaSec, double? TempProd, double? Tciclo, double? Tenfri
  }) {
    return DatosPROCEIPS(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      Hora: Hora ?? this.Hora,
      PAprod: PAprod ?? this.PAprod,
      TempTolvaSec: TempTolvaSec ?? this.TempTolvaSec,
      TempProd: TempProd ?? this.TempProd,
      Tciclo: Tciclo ?? this.Tciclo,
      Tenfri: Tenfri ?? this.Tenfri
    );
  }
}



class ScreenListDatosPROCEIPS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: [
          Titulos(
            titulo: 'REGISTRO DE PROCESOS',
            tipo: 0,          
          ),
          Expanded(
            child: Consumer<DatosProviderPrefIPS>(
              builder: (context, provider, _) {
                final datosproceips = provider.datosproceipsList;

                if (datosproceips.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay registros aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: datosproceips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dtdatosproceips = datosproceips[index];

                    return GradientExpandableCard(
                      idlista: dtdatosproceips.id,
                      numeroindex: (index + 1).toString(),
                      onSwipedAction: () async {
                        await provider.removeProceso(context, dtdatosproceips.id!);
                      },
                                          subtitulos: {
                        'Hora': dtdatosproceips.Hora,
                        'PA Prod': dtdatosproceips.PAprod,
                                          },
                      expandedContent: generateExpandableContent([
                       
                        ['Temp Tolva Sec ', 4,dtdatosproceips.TempTolvaSec],
                        ['Temp Prod: ', 1, dtdatosproceips.TempProd.toString() + ' °C'],
                        ['T ciclo: ', 1, dtdatosproceips.Tciclo.toString() + ' seg'],	
                        ['T enfri: ', 1, dtdatosproceips.Tenfri.toString()],
                      ]),
                      hasErrors: dtdatosproceips.hasErrors,
                      hasSend: dtdatosproceips.hasSend,
                      onOpenModal: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosPROCEIPSForm(
                              id: dtdatosproceips.id!,
                              DatosProceips: dtdatosproceips,
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
  } provider.addProceIPS(DatosPROCEIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: idregistro,  // Ya sabemos que no es 0 ni null
                  Hora: DateFormat('HH:mm').format(DateTime.now()),
              PAprod: ' ',
              TempTolvaSec: [0,0,0],
              TempProd: 0,
              Tciclo: 0,
              Tenfri: 0,
  ));
},
      ),
    );
  }
}
    class EditProviderDatosPROCEIPS with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class EditDatosPROCEIPSForm extends StatefulWidget {
  final int id;
  final DatosPROCEIPS DatosProceips;

  const EditDatosPROCEIPSForm({required this.id, required this.DatosProceips, Key? key})
      : super(key: key);

  @override
  _EditDatosPROCEIPSFormState createState() => _EditDatosPROCEIPSFormState();
}

class _EditDatosPROCEIPSFormState extends State<EditDatosPROCEIPSForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // Mapa para las opciones de Dropdowns
  final Map<String, List<dynamic>> dropOptionsDatosPROCEIPS = {
    'Opciones': ['Opción 1', 'Opción 2', 'Opción 3'],
  };

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
    return ChangeNotifierProvider(
      create: (_) => EditProviderDatosPROCEIPS(),
      child: Consumer<EditProviderDatosPROCEIPS>(
        builder: (context, provider, child) {
          return Scaffold(
          body: Column(
              children:[
               Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormularioGeneralDatosPROCEIPS(
              formKey: _formKey,
              widget: widget,
              dropOptions: dropOptionsDatosPROCEIPS,
            ),),),),

            BotonDeslizable(
  onPressed: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateProcesos(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateProcesos(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosPROCEIPS(widget.id);

    if (!enviado) {
     EnviadoDialog.mostrar(context, false);      
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
      await provider.updateProcesos(widget.id, updatedDatitoEnviado);
      EnviadoDialog.mostrar(context, true); 
      Navigator.pop(context);
    }
  },
),          
          ]));
        }));
  }
DatosPROCEIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value; 

  return
                widget.DatosProceips.copyWith(
                hasErrors:_formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
                 hasSend: hasSend,
                  Hora: values['Hora'] ?? widget.DatosProceips.Hora,
                  PAprod: values['PAprod'] ?? widget.DatosProceips.PAprod,
                  TempTolvaSec: List.generate(
                  widget.DatosProceips.TempTolvaSec.length,
                  (index) => double.tryParse(values['TempTolvaSec_$index'] ?? '0') ?? 0,
                ),
                  TempProd:(values['TempProd']?.isEmpty ?? true)? 0 : double.tryParse(values['TempProd']),
                  Tciclo:(values['Tciclo']?.isEmpty ?? true)? 0 : double.tryParse(values['Tciclo']),
                  Tenfri:(values['Tenfri']?.isEmpty ?? true)? 0 : double.tryParse(values['Tenfri']),

                );

}
}

class FormularioGeneralDatosPROCEIPS extends StatelessWidget {
  const FormularioGeneralDatosPROCEIPS({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.widget,
    required this.dropOptions,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final widget;
  final Map<String, List<dynamic>> dropOptions;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [

          CustomInputField(
              name: 'Hora',
              isreadonly: true,
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Hora'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Hora',
              valorInicial: widget.DatosProceips.Hora,
              isNumeric: false,
              isRequired: true,),

          CustomInputField(
              name: 'PAprod',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['PAprod'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'PA producido',
              valorInicial: widget.DatosProceips.PAprod,
              isNumeric: true,
              isRequired: true,),

            const SizedBox(height: 15,),
            ...List.generate(
              widget.DatosProceips.TempTolvaSec.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: CustomInputField(
              name: 'TempTolvaSec_$index',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['TempTolvaSec_$index'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Temperatura Tolva Seccionada ${index+1} [°C]',
              valorInicial: widget.DatosProceips.TempTolvaSec[index] == 0
              ? ''
              : widget.DatosProceips.TempTolvaSec[index].toString(),
  
              isNumeric: true,
              isRequired: true,),
            )),
          CustomInputField(
              name: 'TempProd',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['TempProd'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Temperatura de prod [°C]',
              valorInicial: widget.DatosProceips.TempProd == 0 ? '': widget.DatosProceips.TempProd.toString(),
              isNumeric: true,
              isRequired: true,),

          CustomInputField(
              name: 'Tciclo',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Tciclo'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Tiempo de ciclo [seg]',
              valorInicial:widget.DatosProceips.Tciclo == 0 ?'': widget.DatosProceips.Tciclo.toString(),
             isNumeric: true,
              isRequired: true,),

          CustomInputField(
              name: 'Tenfri',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Tenfri'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Tiempo de enfriamiento [seg]',
              valorInicial: widget.DatosProceips.Tenfri == 0 ? '': widget.DatosProceips.Tenfri.toString(),
              isNumeric: true,
              isRequired: true,),

    ]
      ),
    );
  }
}