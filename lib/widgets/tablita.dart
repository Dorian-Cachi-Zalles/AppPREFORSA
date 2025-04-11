import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_ctrl_pesos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class MultiTableProvider with ChangeNotifier {
  List<DatosPESOSIPS> _pesos = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _fechaInicio;
  String? _fechaFin;

  List<DatosPESOSIPS> get pesos => _pesos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get fechaInicio => _fechaInicio;
  String? get fechaFin => _fechaFin;

  MultiTableProvider() {
    _fechaInicio = _calcularFecha(-1); // Ayer
    _fechaFin = _calcularFecha(0); // Hoy
  }

  String _calcularFecha(int dias) {
    return DateFormat('yy-MM-dd').format(DateTime.now().add(Duration(days: dias)));
  }

  void setFechas({String? inicio, String? fin}) {
    _fechaInicio = inicio;
    _fechaFin = fin;
    notifyListeners(); // Notificar cambios en las fechas
  }

  Future<void> fetchData(String endpoint) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      Uri uri = Uri.parse('${Config.baseUrl}/$endpoint').replace(queryParameters: {
        if (_fechaInicio != null) 'fecha_inicial': _fechaInicio,
        if (_fechaFin != null) 'fecha_final': _fechaFin,
      });

      

      final response = await http.get(uri);

     

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          List<dynamic> jsonData = jsonResponse['data'] ?? [];
          _pesos = jsonData.map((json) => DatosPESOSIPS.fromJson(json)).toList();
        } else {
          _pesos = [];
          
        }
      } else {
        _errorMessage = 'Error ${response.statusCode}: ${response.body}';
        
      }
    } catch (e) {
      _errorMessage = 'Error al cargar los datos: $e';
     
    }

    _isLoading = false;
    notifyListeners();
  }
}


// DataSource para la tabla paginada
class PesosDataSource extends DataTableSource {
  final List<DatosPESOSIPS> pesos;

  PesosDataSource(this.pesos);

  @override
  DataRow? getRow(int index) {
    if (index >= pesos.length) return null;
    final peso = pesos[index];
    return DataRow(cells: [
      DataCell(Text(peso.id.toString())),
      DataCell(Text(peso.Hora)),
      DataCell(Text(peso.PA)),
      DataCell(Text(peso.PesoTotal.toString())),
    ]);
  }
    @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => pesos.length;
  @override
  int get selectedRowCount => 0;
}

Future<void> _seleccionarFecha(BuildContext context, TextEditingController controller) async {
  DateTime? fechaSeleccionada = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
  );

  if (fechaSeleccionada != null) {
    String fechaFormateada = DateFormat('yy-MM-dd').format(fechaSeleccionada);
    controller.text = fechaFormateada;
  }
}

class PesosPaginatedTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MultiTableProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Filtro de fecha
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Fecha Inicial',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            String? fecha = await _seleccionarFecha(context);
                            if (fecha != null) {
                              provider.setFechas(inicio: fecha, fin: provider.fechaFin);
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(text: provider.fechaInicio),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Fecha Final',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            String? fecha = await _seleccionarFecha(context);
                            if (fecha != null) {
                              provider.setFechas(inicio: provider.fechaInicio, fin: fecha);
                            }
                          },
                        ),
                      ),
                      controller: TextEditingController(text: provider.fechaFin),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchData('pesosips'); // Ahora se llama desde el Provider
                    },
                    child: const Text('Buscar'),
                  ),
                ],
              ),
            ),
        
            // Tabla 1
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                    ? Center(child: Text('Error: ${provider.errorMessage}'))
                    : provider.pesos.isEmpty
                        ? const Center(child: Text('No hay datos disponibles'))
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PaginatedDataTable(
                              header: const Text('Tabla DatosPESOSIPS'),
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Hora')),
                                DataColumn(label: Text('PA')),
                                DataColumn(label: Text('Peso Total')),
                              ],
                              source: PesosDataSource(provider.pesos),
                              rowsPerPage: 10,
                            ),
                          ),            
        
            // Tabla 2 (si es necesario, puedes agregar otra tabla aquí)
          /*  provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.errorMessage != null
                    ? Center(child: Text('Error: ${provider.errorMessage}'))
                    : provider.pesos.isEmpty
                        ? const Center(child: Text('No hay datos disponibles'))
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: PaginatedDataTable(
                              header: const Text('Otra Tabla DatosPESOSIPS'),
                              columns: const [
                                DataColumn(label: Text('ID')),
                                DataColumn(label: Text('Hora')),
                                DataColumn(label: Text('PA')),
                                DataColumn(label: Text('Peso Total')),
                              ],
                              source: PesosDataSource(provider.pesos),
                              rowsPerPage: 10,
                            ),
                          ),*/
          ],
        ),
      ),
    );
  }



  Future<String?> _seleccionarFecha(BuildContext context) async {
    DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    return fechaSeleccionada != null ? DateFormat('yy-MM-dd').format(fechaSeleccionada) : null;
  }
}
