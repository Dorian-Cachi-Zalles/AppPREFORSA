import 'package:control_de_calidad/Configuraciones/catalogodropdowns.dart';
import 'package:control_de_calidad/Providers/ProviderI6.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/widgets/Alertas.dart';
import 'package:control_de_calidad/widgets/boton_agregar.dart';
import 'package:control_de_calidad/widgets/boton_guardar.dart';
import 'package:control_de_calidad/widgets/boxformularios.dart';
import 'package:control_de_calidad/widgets/checkboxformulario.dart';
import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:control_de_calidad/widgets/titulos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';


class DatosMPIPS {
  final int? id;
  final bool hasErrors;
  final bool hasSend;
  final int idregistro;
  final String MateriPrima;
  final String INTF;
  final String CantidadEmpaque;
  final String Identif;
  final int CantidadBolsones;
  final double Dosificacion;
  final double Humedad;
  final bool Conformidad;

  // Constructor de la clase
  const DatosMPIPS({
    this.id,
    required this.hasErrors,
    required this.hasSend,
    required this.idregistro,
    required this.MateriPrima,
    required this.INTF,
    required this.CantidadEmpaque,
    required this.Identif,
    required this.CantidadBolsones,
    required this.Dosificacion,
    required this.Humedad,
    required this.Conformidad
  });

  // Factory para crear una instancia desde un Map
  factory DatosMPIPS.fromJson(Map<String, dynamic> map) {
    return DatosMPIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == false,
      hasSend: map['hasSend'] == false,
      idregistro: map['idregistro'] as int,
      MateriPrima: map['MateriPrima'] as String,
      INTF: map['INTF'] as String,
      CantidadEmpaque: map['CantidadEmpaque'] as String,
      Identif: map['Identif'] as String,
      CantidadBolsones: map['CantidadBolsones'] as int,
      Dosificacion: map['Dosificacion'] as double,
      Humedad: map['Humedad'] as double,
      Conformidad: (map['Conformidad'] as int) == 1
    );
  }

  factory DatosMPIPS.fromMap(Map<String, dynamic> map) {
    return DatosMPIPS(
      id: map['id'] as int?,
      hasErrors: map['hasErrors'] == 1,
      hasSend: map['hasSend'] == 1,
      idregistro: map['idregistro'] as int,
      MateriPrima: map['MateriPrima'] as String,
      INTF: map['INTF'] as String,
      CantidadEmpaque: map['CantidadEmpaque'] as String,
      Identif: map['Identif'] as String,
      CantidadBolsones: map['CantidadBolsones'] as int,
      Dosificacion: map['Dosificacion'] as double,
      Humedad: map['Humedad'] as double,
      Conformidad: (map['Conformidad'] as int) == 1
    );
  }

  // Método para convertir la instancia a Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'hasErrors': hasErrors ? 1 : 0,
      'hasSend': hasSend ? 1 : 0,
      'idregistro': idregistro,
      'MateriPrima': MateriPrima,
      'INTF': INTF,
      'CantidadEmpaque': CantidadEmpaque,
      'Identif': Identif,
      'CantidadBolsones': CantidadBolsones,
      'Dosificacion': Dosificacion,
      'Humedad': Humedad,
      'Conformidad': Conformidad ? 1 : 0
    };
  }

  // Método copyWith
  DatosMPIPS copyWith({
    int? id,
    bool? hasErrors,
    bool? hasSend,
    int? idregistro,
    String? MateriPrima, String? INTF, String? CantidadEmpaque, String? Identif, int? CantidadBolsones, double? Dosificacion, double? Humedad, bool? Conformidad
  }) {
    return DatosMPIPS(
      id: id ?? this.id,
      hasErrors: hasErrors ?? this.hasErrors,
      hasSend: hasSend ?? this.hasSend,
      idregistro: idregistro ?? this.idregistro,
      MateriPrima: MateriPrima ?? this.MateriPrima,
      INTF: INTF ?? this.INTF,
      CantidadEmpaque: CantidadEmpaque ?? this.CantidadEmpaque,
      Identif: Identif ?? this.Identif,
      CantidadBolsones: CantidadBolsones ?? this.CantidadBolsones,
      Dosificacion: Dosificacion ?? this.Dosificacion,
      Humedad: Humedad ?? this.Humedad,
      Conformidad: Conformidad ?? this.Conformidad
    );
  }
}


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


class ScreenListDatosMPIPS extends StatefulWidget {
  @override
  State<ScreenListDatosMPIPS> createState() => _ScreenListDatosMPIPSState();
}

class _ScreenListDatosMPIPSState extends State<ScreenListDatosMPIPS> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final providerregistro = Provider.of<IdsProvider>(context, listen: false);       
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16,left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    '¿Se tiene una mezcla con \ncolorante o aditivo?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),                  
                 OutlinedButton(
  style: OutlinedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    side: const BorderSide(color: Colors.black),
    minimumSize: const Size(120, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
  onPressed: () async {
    int? idregistro = await providerregistro.getNumeroById(1);
    if (idregistro == null || idregistro == 0) return;

    provider.addDatosColoranteIPS(DatosColoranteIPS(
      hasErrors: true,
      hasSend: false,
      idregistro: idregistro,
      Colorante: 'Microbatch Azul',
      Codigo: '',
      KL: '',
      BP: '',
      Dosificacion: 0,
      CantidadBolsone: 1,
    ));
  },
  child: const Text(
    "SI",
    style: TextStyle(fontSize: 24),
  ),
),
                ],
              ),
          ),
          const Titulos(
            titulo: 'REGISTRO COLORANTE',
            tipo: 0,
          ),
          SizedBox(
            height: 180,
            child: Expanded(
              child: Consumer<DatosProviderPrefIPS>(
                builder: (context, provider, _) {
                  final datoscoloranteips = provider.datoscoloranteipsList;
            
                  if (datoscoloranteips.isEmpty) {
                    return const Center(
                      child: Text(
                        'No hay registros aún.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }
            
                  return ListView.separated(
                    itemCount: datoscoloranteips.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final dtdatoscoloranteips = datoscoloranteips[index];
            
                      return GradientExpandableCard(
                        idlista: dtdatoscoloranteips.id,
                        hasSend:dtdatoscoloranteips.hasSend,
                        numeroindex: (index + 1).toString(),
                        onSwipedAction: () async {
                          await provider.removeDatosColoranteIPS(context, dtdatoscoloranteips.id!);   
                        },
                        titulo: 'Colorante',                      
                        subtitulos: {'': dtdatoscoloranteips.Colorante},
                        expandedContent: generateExpandableContent([                        
                          ['Codigo: ', 1, dtdatoscoloranteips.Codigo],
                          ['KL: ', 1, dtdatoscoloranteips.KL],
                          ['BP: ', 1, dtdatoscoloranteips.BP],
                          ['Dosificacion: ', 1, dtdatoscoloranteips.Dosificacion.toString()],
                          ['CantidadBolsone: ', 1, dtdatoscoloranteips.CantidadBolsone.toString()],
                        ]),
                        hasErrors: dtdatoscoloranteips.hasErrors,
                        onOpenModal: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditDatosColoranteIPSForm(
                                id: dtdatoscoloranteips.id!,
                                DatoscoloranteIPS: dtdatoscoloranteips,
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
          ),                             
          const Titulos(
            titulo: 'REGISTRO MATERIA PRIMA',
            tipo: 0,            
          ),
          Expanded(
            child: Consumer<DatosProviderPrefIPS>(
              builder: (context, provider, _) {
                final datosmpips = provider.datosmpipsList;

                if (datosmpips.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay registros aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: datosmpips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final dtdatosmpips = datosmpips[index];

                    return GradientExpandableCard(
                      idlista: dtdatosmpips.id,
                      numeroindex: (index + 1).toString(),
                      onSwipedAction: () async {
                        await provider.removeDatosMPIPS(context, dtdatosmpips.id!);
                      },                      
                      titulo: 'Materia Prima',
                      subtitulos: {
                        '': dtdatosmpips.MateriPrima,                        
                        'Conformidad': dtdatosmpips.Conformidad ? 'SI' : 'NO',
                      },
                      expandedContent: generateExpandableContent([
                        ['INTF: ', 1, dtdatosmpips.INTF],
                        ['CantidadEmpaque: ', 1, dtdatosmpips.CantidadEmpaque],
                        ['Identif: ', 1, dtdatosmpips.Identif],
                        ['CantidadBolsones: ', 1, dtdatosmpips.CantidadBolsones.toString()],
                        ['Dosificacion: ', 1, dtdatosmpips.Dosificacion.toString()],
                        ['Humedad: ', 1, dtdatosmpips.Humedad.toString()],                        
                      ]),
                      hasErrors: dtdatosmpips.hasErrors,
                      hasSend: dtdatosmpips.hasSend,
                      onOpenModal: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditDatosMPIPSForm(
                              id: dtdatosmpips.id!,
                              datosMpIps: dtdatosmpips,
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
  } provider.addDatosMPIPS(DatosMPIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: idregistro,  // Ya sabemos que no es 0 ni null
              MateriPrima: 'JADE CZ 328A',
              INTF: ' ',
              CantidadEmpaque: ' ',
              Identif: ' ',
              CantidadBolsones: 1,
              Dosificacion: 0,
              Humedad: 0,
              Conformidad: true,
  ));
},
      ),);
    
  }
}


class EditProviderDatosMPIPS with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class EditDatosMPIPSForm extends StatefulWidget {
  final int id;
  final DatosMPIPS datosMpIps;

  const EditDatosMPIPSForm({required this.id, required this.datosMpIps, Key? key})
      : super(key: key);

  @override
  _EditDatosMPIPSFormState createState() => _EditDatosMPIPSFormState();
}

class _EditDatosMPIPSFormState extends State<EditDatosMPIPSForm> {
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
  final Map<String, List<dynamic>> dropOptionsDatosMPIPS =
        catalogosProvider.getCatalogo('MP');
    return ChangeNotifierProvider(
      create: (_) => EditProviderDatosMPIPS(),
      child: Consumer<EditProviderDatosMPIPS>(
        builder: (context, provider, child) {
          return Scaffold(
          body: Column(
              children:[
               Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormularioGeneralDatosMPIPS(
              formKey: _formKey,
              
              widget: widget,
              dropOptions: dropOptionsDatosMPIPS,
            ),),),),

           BotonDeslizable(
  onPressed: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosMPIPS(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();

    await provider.updateDatosMPIPS(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosMPIPS(widget.id);

    if (!enviado) {
    EnviadoDialog.mostrar(context, false);

     
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
      await provider.updateDatosMPIPS(widget.id, updatedDatitoEnviado);
      EnviadoDialog.mostrar(context, true);
      Navigator.pop(context);
    }
  
  },
)        
          ]));
        }
        )
        );
        
  }
  DatosMPIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;
  return widget.datosMpIps.copyWith(
                  hasErrors:_formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
                   hasSend: hasSend,
                  MateriPrima: values['MateriPrima'] ?? widget.datosMpIps.MateriPrima,
                  INTF: values['INTF'] ?? widget.datosMpIps.INTF,
                  CantidadEmpaque: values['CantidadEmpaque'] ?? widget.datosMpIps.CantidadEmpaque,
                  Identif: values['Identif'] ?? widget.datosMpIps.Identif,
                  CantidadBolsones: (values['CantidadBolsones'] == null || values['CantidadBolsones'].toString().isEmpty)     ? 0 
    : int.tryParse(values['CantidadBolsones'].toString()) ?? 0,       
                  Dosificacion:(values['Dosificacion']?.isEmpty ?? true)? 0 : double.tryParse(values['Dosificacion']),
                  Humedad:(values['Humedad']?.isEmpty ?? true)? 0 : double.tryParse(values['Humedad']),
                  Conformidad: values['Conformidad'] ?? widget.datosMpIps.Conformidad,

                );

}
  
}

class FormularioGeneralDatosMPIPS extends StatelessWidget {
  const FormularioGeneralDatosMPIPS({
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
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [

          DropdownSimple(
            name: 'MateriPrima',
            label: 'Materia Prima',
            textoError: 'Selecciona',
            valorInicial: widget.datosMpIps.MateriPrima,
            opciones: 'MateriaPrima',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['MateriPrima'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

          CustomInputField(
              name: 'INTF',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['INTF'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Intf',
              valorInicial: widget.datosMpIps.INTF.toString(),
              isNumeric: false,
              isRequired: true,),

          CustomInputField(
              name: 'CantidadEmpaque',
               onChanged: (value) {
              final field = _formKey.currentState?.fields['CantidadEmpaque'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
              label: 'Cantidad de Empaque [Kg]',
              valorInicial: widget.datosMpIps.CantidadEmpaque.toString(),
              isRequired: true,),

          CustomInputField(
              name: 'Identif',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Identif'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Identif',
              valorInicial: widget.datosMpIps.Identif.toString(),
              isRequired: true,
              isNumeric: false,),

          DropdownSimple<dynamic>(
            name: 'CantidadBolsones',
            label: 'Cantidad de bolsones',
            textoError: 'Selecciona',
            valorInicial: widget.datosMpIps.CantidadBolsones,
            opciones: 'CantidadBolsones',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['CantidadBolsones'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),

          CustomInputField(
              name: 'Dosificacion',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Dosificacion'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Dosificacion [%]',
              valorInicial: widget.datosMpIps.Dosificacion == 0 ? '': widget.datosMpIps.Dosificacion.toString(),
              isNumeric: true,
              isRequired: true,
              max: 100,
              min: 0,),

          CustomInputField(
              name: 'Humedad',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['Humedad'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Humedad[%]',
              valorInicial: widget.datosMpIps.Humedad.toString(),
              isNumeric: true,
              isRequired: true,),         
          CheckboxSimple(
            label: 'Conformidad',
            name: 'Conformidad',
            valorInicial: widget.datosMpIps.Conformidad,
          ),

    ]
      ),
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
  final Map<String, List<dynamic>> dropOptionsDatosColoranteIPS =
        catalogosProvider.getCatalogo('Colorante');
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
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();
    
    await provider.updateDatosColoranteIPS(widget.id, updatedDatito);
    Navigator.pop(context);
  },
  onSwipedAction: () async {
    final provider = Provider.of<DatosProviderPrefIPS>(context, listen: false);
    final updatedDatito = obtenerDatosActualizados();
    
    await provider.updateDatosColoranteIPS(widget.id, updatedDatito);

    bool enviado = await provider.enviarDatosAPIDatosColoranteIPS(widget.id);

    if (!enviado) {
      EnviadoDialog.mostrar(context, false);     
    } else {
      final updatedDatitoEnviado = obtenerDatosActualizados(hasSend: true);
      await provider.updateDatosColoranteIPS(widget.id, updatedDatitoEnviado);
      EnviadoDialog.mostrar(context, true); 
      Navigator.pop(context);
    }
  },
)
          ]));
        }));
  }
DatosColoranteIPS obtenerDatosActualizados({bool hasSend = false}) {
  _formKey.currentState?.save();
  final values = _formKey.currentState!.value;

  return
                widget.DatoscoloranteIPS.copyWith(
                hasErrors:_formKey.currentState?.fields.values.any((field) => field.hasError) ?? false,
                hasSend: hasSend,
                  Colorante: values['Colorante'] ?? widget.DatoscoloranteIPS.Colorante,
                  Codigo: values['Codigo'] ?? widget.DatoscoloranteIPS.Codigo,
                  KL: values['KL'] ?? widget.DatoscoloranteIPS.KL,
                  BP: values['BP'] ?? widget.DatoscoloranteIPS.BP,
                  Dosificacion:(values['Dosificacion']?.isEmpty ?? true)? 0 : double.tryParse(values['Dosificacion']),
                  CantidadBolsone:(values['CantidadBolsone'] == null || values['CantidadBolsone'].toString().isEmpty) ? 0 : int.tryParse(values['CantidadBolsone'].toString()) ?? 0,

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
              valorInicial: widget.DatoscoloranteIPS.Dosificacion == 0
    ? ''
    : widget.DatoscoloranteIPS.Dosificacion.toString(),
              ),

          DropdownSimple(
            name: 'CantidadBolsone',
            label: 'Cantidadbolsone',
            textoError: 'Selecciona',
            valorInicial: widget.DatoscoloranteIPS.CantidadBolsone,
            opciones: 'CantidadBolsone',
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