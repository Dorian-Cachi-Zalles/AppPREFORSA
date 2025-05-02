
import 'package:control_de_calidad/Providers/BDpreformasIPS.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/widgets/Alertas.dart';

import 'package:control_de_calidad/widgets/boton_guardar.dart';

import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';


class DatosColoranteIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String Colorante;
  final String Codigo;
  final String KL;
  final String BP;
  final double Dosificacion;
  final int CantidadBolsone;

  // Constructor de la clase
  const DatosColoranteIPS({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.Colorante,
    required this.Codigo,
    required this.KL,
    required this.BP,
    required this.Dosificacion,
    required this.CantidadBolsone
  });

  // Factory para crear una instancia desde un Map
  factory DatosColoranteIPS.fromMap(Map<String, dynamic> map) {
    return DatosColoranteIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      Colorante: map['Colorante'] as String,
      Codigo: map['Codigo'] as String,
      KL: map['KL'] as String,
      BP: map['BP'] as String,
      Dosificacion: map['Dosificacion'] as double,
      CantidadBolsone: map['CantidadBolsone'] as int
    );
  }

  // Método para convertir la instancia a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'hasErrors': hasErrors ? 1 : 0,
      'hasSend': hasSend ? 1 : 0,
      'idregistro': idregistro,
      'Colorante': Colorante,
      'Codigo': Codigo,
      'KL': KL,
      'BP': BP,
      'Dosificacion': Dosificacion,
      'CantidadBolsone': CantidadBolsone
    };
  }

  // Método copyWith
  DatosColoranteIPS copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? Colorante, String? Codigo, String? KL, String? BP, double? Dosificacion, int? CantidadBolsone
  }) {
    return DatosColoranteIPS(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      Colorante: Colorante ?? this.Colorante,
      Codigo: Codigo ?? this.Codigo,
      KL: KL ?? this.KL,
      BP: BP ?? this.BP,
      Dosificacion: Dosificacion ?? this.Dosificacion,
      CantidadBolsone: CantidadBolsone ?? this.CantidadBolsone
    );
  }
}



    class EditProviderDatosColoranteIPS with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class EditDatosColoranteIPSForm extends StatefulWidget {
  final int id;
  final DatosColoranteIPS DatoscoloranteIPS;
  

  const EditDatosColoranteIPSForm({required this.id, required this.DatoscoloranteIPS, Key? key})
      : super(key: key);

  @override
  _EditDatosColoranteIPSFormState createState() => _EditDatosColoranteIPSFormState();
}

class _EditDatosColoranteIPSFormState extends State<EditDatosColoranteIPSForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // Mapa para las opciones de Dropdowns
  final Map<String, List<dynamic>> dropOptionsDatosColoranteIPS = {
    'Colorante': ['Microbatch azul', 'Microbatch verde'],
    'CantidadBolsones': [1, 2, 3, 4, 5, 6],
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
      create: (_) => EditProviderDatosColoranteIPS(),
      child: Consumer<EditProviderDatosColoranteIPS>(
        builder: (context, provider, child) {
          return Scaffold(
          body: Column(
              children:[
               Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormularioGeneralDatosColoranteIPS(
              formKey: _formKey,
              widget: widget,
              dropOptions: dropOptionsDatosColoranteIPS,
            ),),),),
            BotonDeslizable(
  onPressed: () async {
    print("ola");
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    int? id_registro = await providerregistro.getNumeroById(1);
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados(idregistro:id_registro!);
     

    await provider.updateDatosColoranteIPS(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);
    int? id_registro = await providerregistro.getNumeroById(1);
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados(idregistro: id_registro!);
   

    await provider.updateDatosColoranteIPS(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosColoranteIPS(widget.id);

    if (!enviado) {
     EnviadoDialog.mostrar(context, false);
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true ,idregistro: id_registro);
      await provider.updateDatosColoranteIPS(widget.id, updatedDatitoEnviado);
      EnviadoDialog.mostrar(context, false);
      Navigator.pop(context);
    }
  },
)
          ]));
        }));
  }
DatosColoranteIPS obtenerDatosActualizados({required int idregistro, bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;

  return widget.DatoscoloranteIPS.copyWith(
    hasSend: hasSend,
    hasErrors: _formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
    Colorante: values['Colorante'] ?? widget.DatoscoloranteIPS.Colorante,
    Codigo: values['Codigo'] ?? widget.DatoscoloranteIPS.Codigo,
    idregistro: idregistro,
    KL: values['KL'] ?? widget.DatoscoloranteIPS.KL,
    BP: values['BP'] ?? widget.DatoscoloranteIPS.BP,
    Dosificacion: (values['Dosificacion'] is String && values['Dosificacion'].isEmpty)
    ? 0
    : double.tryParse(values['Dosificacion'].toString()),
    CantidadBolsone: (values['CantidadBolsone'] is String && values['CantidadBolsone'].isEmpty)
    ? 0
    : int.tryParse(values['CantidadBolsone'].toString()),
  );
}

}

class FormularioGeneralDatosColoranteIPS extends StatelessWidget {
  const FormularioGeneralDatosColoranteIPS({
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

          DropdownSimple(
            name: 'Colorante',
            label: 'Colorante',
            textoError: 'Selecciona',
            valorInicial: widget.DatoscoloranteIPS.Colorante,
            opciones: 'Colorante',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['Colorante'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

          CustomInputField(
              name: 'Codigo',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Codigo'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Codigo',
              valorInicial: widget.DatoscoloranteIPS.Codigo,
              ),

          CustomInputField(
              name: 'KL',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['KL'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Kl',
              valorInicial: widget.DatoscoloranteIPS.KL,
              ),

          CustomInputField(
              name: 'BP',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['BP'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Bp',
              valorInicial: widget.DatoscoloranteIPS.BP,
              ),

          CustomInputField(
              name: 'Dosificacion',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Dosificacion'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Dosificacion',
              valorInicial: widget.DatoscoloranteIPS.Dosificacion.toString(),
              ),

          DropdownSimple(
            name: 'CantidadBolsone',
            label: 'Cantidadbolsone',
            textoError: 'Selecciona',
            valorInicial: widget.DatoscoloranteIPS.CantidadBolsone,
            opciones: 'CantidadBolsones',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['CantidadBolsone'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

    ]
      ),
    );
  }
}