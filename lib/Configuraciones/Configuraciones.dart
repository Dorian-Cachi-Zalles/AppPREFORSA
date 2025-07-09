import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;


class Config {
 static String baseUrl = "http://192.168.137.1:8888/api";
 //static String baseUrl = "http://192.168.0.12:8000/api";
}















































































































































































class LicenseChecker {
  static const String apiUrl = 'https://api.jsonbin.io/v3/b/67e1c3ff8561e97a50f2109c';
  static const String apiKey = r'$2a$10$eNzN0FBMRgybWdaP7Hb0aecBhid6EOf0xkp6dqN7zg1v7d5UAW9QK';
   static const String licenseKey = 'license_status'; // Clave para guardar en SharedPreferences

  static Future<bool> checkLicense() async {
    final prefs = await SharedPreferences.getInstance();

    // 📡 Revisar conexión a internet
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      bool savedStatus = prefs.getBool(licenseKey) ?? true;     
      return savedStatus;
    }

    // 🌐 Si hay internet, consultar API
    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'X-Master-Key': apiKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);    

        // ✅ Extraer estado de la licencia desde 'record'
        if (data.containsKey('record') && data['record'].containsKey('app_access')) {
          bool isValid = data['record']['app_access'];

          // 🗑️ Eliminar el estado anterior y guardar el nuevo
          await prefs.remove(licenseKey);
          await prefs.setBool(licenseKey, isValid);

          return isValid;
        } else {
         
        }
      } else {        
      }
    } catch (e) {
      
    }

    // 🔄 Si hay un error, usar estado anterior
    bool savedStatus = prefs.getBool(licenseKey) ?? true;   
    return savedStatus;
  }
}
  