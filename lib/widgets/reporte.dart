import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';


class GeneradorReporteCalidad {
  String? _pdfPath;

  Future<void> generarPdfDesdeDatos({
    required Map<String, String> datos,
    required List<Map<String, String>> defectos,
    required List<Map<String, String>> pesos,
  }) async {
    final htmlContent = _htmlConDatos(datos, defectos, pesos);

    final url = Uri.parse('https://app.useanvil.com/api/v1/generate-pdf');
    final username = 'RAoLeG8rpaRJpMNC5h13yiHpmIgV5UCX';
    final password = 'your_password';
    final base64Credentials = base64Encode(utf8.encode('$username:$password'));

    final headers = {
      'Authorization': 'Basic $base64Credentials',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({'data': {'html': htmlContent}});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        await _guardarPdf(response.bodyBytes);
        print('✅ PDF generado correctamente');
      } else {
        print('❌ Error al generar PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Excepción al generar PDF: $e');
    }
  }

  Future<void> _guardarPdf(Uint8List pdfBytes) async {
  final status = await Permission.storage.request();

  if (!status.isGranted) {
    print('❌ Permiso denegado');

    // 👉 Abrir configuración de la app para que el usuario habilite permisos manualmente
    await openAppSettings();
    return;
  }

  final directory = await getExternalStorageDirectory();
  final path = '${directory!.path}/reporte_calidad.pdf';
  final file = File(path);
  await file.writeAsBytes(pdfBytes);
  _pdfPath = path;
  print('✅ PDF guardado en: $_pdfPath');
}

  Future<void> abrirPdf() async {
    if (_pdfPath != null) {
      await OpenFile.open(_pdfPath!);
    } else {
      print('⚠️ No hay PDF generado aún para abrir');
    }
  }

  Future<void> enviarPdf() async {
    if (_pdfPath == null) {
      print('⚠️ No hay PDF para enviar');
      return;
    }

    final url = Uri.parse('http://192.168.137.1:8888/api/upload');

    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer TU_TOKEN_DE_AUTENTICACION'
        ..files.add(await http.MultipartFile.fromPath(
          'pdf',
          _pdfPath!,
          contentType: MediaType('application', 'pdf'),
        ));

      final response = await request.send();
      if (response.statusCode == 200) {
        print('✅ PDF enviado correctamente');
      } else {
        print('❌ Error al enviar PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Excepción al enviar PDF: $e');
    }
  }

  String _htmlConDatos(
    Map<String, String> d,
    List<Map<String, String>> defectos,
    List<Map<String, String>> pesos,
  ) {
    final filasDefectos = defectos.map((e) => '''
      <tr>
        <td>${e['num']}</td>
        <td>${e['hora']}</td>
        <td>${e['defecto']}</td>
        <td>${e['criticidad']}</td>
        <td>${e['palet']}</td>
        <td>${e['empaque']}</td>
        <td>${e['embalaje']}</td>
        <td>${e['etiquetado']}</td>
        <td>${e['inocuidad']}</td>
        <td>${e['retenido']}</td>
        <td>${e['observacion']}</td>
      </tr>
    ''').join();

    final filasPesos = pesos.map((e) => '''
      <tr>
        <td>${e['num']}</td>
        <td>${e['hora']}</td>
        <td>${e['pa']}</td>
        <td>${e['peso_pe']}</td>
        <td>${e['peso_neto']}</td>
        <td>${e['peso_total']}</td>
        <td>${e['cantidad']}</td>
        <td>${e['empaque']}</td>
        <td></td>
      </tr>
    ''').join();

    return '''
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">  
</head>
<body style="font-size: 10px">
<table border="1" style="width: 100%; border-collapse: collapse;">
  <tr>
    <td rowspan="3" style="width: 200px; height: 100px;"></td>
    <td style="text-align: center"><strong>Nombre de Documento:</strong></td>
    <td style="text-align: center"><strong>Código:</strong> SIG RL 03</td>
  </tr>
  <tr>
    <td style="text-align: center">CONTROL DE CALIDAD: REPORTE DIARIO DE PRODUCCIÓN DE PREFORMAS - CAJAS - OPERARIOS</td>
    <td style="text-align: center"><strong>Fecha:</strong> ${d['fecha'] ?? ''}</td>
  </tr>
  <tr>
    <td style="text-align: center"><strong>Tipo de Documento:</strong> REGISTRO</td>
    <td style="text-align: center"><strong>Versión:</strong> 01</td>
  </tr>
</table>

<table style="width: 100%; border-collapse: collapse; margin-bottom: 10px;">
  <tr>
    <td rowspan="2" style="width: 30%;">Resp. Laboratorio: ${d['responsable'] ?? ''}</td>
    <td style="width: 30%;">Fecha: ${d['fecha'] ?? ''}</td>
    <td style="width: 20%;">Turno: ${d['turno'] ?? ''}</td>
    <td rowspan="2"><b>LOTE:</b> ${d['lote'] ?? ''}</td>
  </tr>
  <tr>
    <td>Aux. Laboratorio: ${d['auxiliar'] ?? ''}</td>
    <td>Maquinista: ${d['maquinista'] ?? ''}</td>
  </tr>
</table>

<table style="width: 100%; border: double; margin-bottom: 0px;">
  <tr>
    <td colspan="7" style="text-align: center; border: 1px solid black;">
      <strong>i6 IPS 400</strong> (Modalidad Producción: ${d['modalidad'] ?? ''})
    </td>
  </tr>
</table>

<table border="1" style="width: 100%; border-collapse: collapse; font-size: 10px;">
  <tr>
    <th>Num</th>
    <th>Hora</th>
    <th>Defecto</th>
    <th>Criticidad</th>
    <th>Palet</th>
    <th>Empaque</th>
    <th>Embalaje</th>
    <th>Etiquetado</th>
    <th>Inocuidad</th>
    <th>Retenido</th>
    <th>Observación</th>
  </tr>
  $filasDefectos
</table>

<table border="1" style="width: 100%; border-collapse: collapse; font-size: 10px; margin-top: 10px;">
  <tr>
    <th>Num</th>
    <th>Hora</th>
    <th>PA</th>
    <th>Peso P+E</th>
    <th>Peso Neto</th>
    <th>Peso Total</th>
    <th>Cantidad</th>
    <th>Empaque</th>
    <th>Firma</th>
  </tr>
  $filasPesos
</table>
</body>
</html>
''';
  }
}