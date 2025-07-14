import 'package:control_de_calidad/widgets/dropdownformmenosrigida.dart';
import 'package:control_de_calidad/widgets/dropdownformulario.dart';
import 'package:control_de_calidad/widgets/textsimpleform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';



class EditProviderDatosProduccionObervada with ChangeNotifier {
  // Implementación del proveedor, puedes agregar lógica específica aquí
}

class FormularioGeneralDatosProduccionObervada extends StatelessWidget {
  const FormularioGeneralDatosProduccionObervada({   
    super.key,
    required GlobalKey<FormBuilderState> formKey,
    required this.widget,
    required this.dropOptions,
    required this.opcionesDEf, this.onPressedDEF,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;
  final widget;
  final Map<String, List<dynamic>> dropOptions;
  final VoidCallback? onPressedDEF;
  final List<String> opcionesDEf;

  @override
  Widget build(BuildContext context) {  
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          DropdownSimple(
            name: 'Desvio',
            label: 'Desvio',
            textoError: 'Selecciona',
            valorInicial: widget.tablaProduccionObservada.Desvio,
            opciones: 'Ffase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['Desvio'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),
          
          CustomInputField(
              name: 'cantidadRetenida',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['cantidadRetenida'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Cantidadretenida',
              isRequired: true,
              isNumeric: true,     
              valorInicial: widget.tablaProduccionObservada.cantidadRetenida.toString(),
              ),

          DropdownSimplemenosrigida(
            name: 'AtributodeProductoNC',
            label: 'AtributodeProductoNC',
            textoError: 'Selecciona',
            valorInicial: widget.tablaProduccionObservada.AtributodeProductoNC,
            opciones: opcionesDEf,
          
            onChanged: (value) {
              final field = _formKey.currentState?.fields['AtributodeProductoNC'];
              field?.validate();
              field?.save();            
            },
          ),


          DropdownSimple(
            name: 'EstadodelProducto',
            label: 'Estadodelproducto',
            textoError: 'Selecciona',
            valorInicial: widget.tablaProduccionObservada.EstadodelProducto,
            opciones: 'Ffase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['EstadodelProducto'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),
          
          DropdownSimple(
            name: 'ArranqueLinea',
            label: 'Arranquelinea',
            textoError: 'Selecciona',
            valorInicial: widget.tablaProduccionObservada.ArranqueLinea,
            opciones: 'Ffase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['ArranqueLinea'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),
          
          CustomInputField(
              name: 'ReprocesoConforme',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['ReprocesoConforme'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Reprocesoconforme',
              isRequired: true,
              isNumeric: true,     
              valorInicial: widget.tablaProduccionObservada.ReprocesoConforme.toString(),
              ),
          
          CustomInputField(
              name: 'ReprocesoNoConforme',
              onChanged: (value) {
                final field = _formKey.currentState?.fields['ReprocesoNoConforme'];
                field?.validate(); // Valida solo este campo
                field?.save();
              },
              label: 'Reprocesonoconforme',
              isRequired: true,
              isNumeric: true,     
              valorInicial: widget.tablaProduccionObservada.ReprocesoNoConforme.toString(),
              ),
          
          DropdownSimple(
            name: 'EstadodelProductoC',
            label: 'Estadodelproductoc',
            textoError: 'Selecciona',
            valorInicial: widget.tablaProduccionObservada.EstadodelProductoC,
            opciones: 'Ffase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['EstadodelProductoC'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),
          
          DropdownSimple(
            name: 'EstadodelProductoNC',
            label: 'Estadodelproductonc',
            textoError: 'Selecciona',
            valorInicial: widget.tablaProduccionObservada.EstadodelProductoNC,
            opciones: 'Ffase',
            dropOptions: dropOptions,
            onChanged: (value) {
              final field = _formKey.currentState?.fields['EstadodelProductoNC'];
              field?.validate(); // Valida solo este campo
              field?.save();
            },
          ),
          
    ]
      ),
    );
  }
}


