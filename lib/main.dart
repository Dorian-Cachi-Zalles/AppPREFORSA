import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:control_de_calidad/Providers/BDpreformasIPS.dart';
import 'package:control_de_calidad/Providers/Providerids.dart';
import 'package:control_de_calidad/Ventanas/Screen_login.dart';
import 'package:control_de_calidad/Ventanas/home_screen.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/form_coloranteips.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_datosiniciales.dart';
import 'package:control_de_calidad/widgets/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feature_discovery/feature_discovery.dart'; // Importar FeatureDiscovery


class AppThemes {
  // Tema claro
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 255, 255, 255),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueAccent,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Color.fromARGB(255, 14, 13, 13),
      backgroundColor: Colors.lightBlue,
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(108, 173, 170, 165),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }
        return Colors.transparent;
      }),
    ),
  );

  // Tema oscuro
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color.fromARGB(255, 51, 47, 47),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.grey,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
      backgroundColor: Colors.blueGrey,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white70,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blueGrey;
        }
        return Colors.transparent;
      }),
    ),
  );
}
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isLicensed = await LicenseChecker.checkLicense();

  runApp(
    FeatureDiscovery(
      // Asegurarse de que FeatureDiscovery envuelva toda la aplicación
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SettingsProvider()),          
          ChangeNotifierProvider(create: (_) => IdsProvider()),
          ChangeNotifierProvider(create: (_) => DatosProviderPrefIPS()),         
          ChangeNotifierProvider(create: (_) => RegistroIPSProvider()) ,
          ChangeNotifierProvider(create: (_) => ColoranteIPSProvider()) ,           

          
        ],        
        child: MyApp(isLicensed: isLicensed),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  
  final bool isLicensed;
  const MyApp({super.key, required this.isLicensed});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  late bool isLicensed;

  @override
  void initState() {
    super.initState();
    isLicensed = widget.isLicensed;
  }

  Future<void> refreshLicense() async {
    bool newStatus = await LicenseChecker.checkLicense();
    setState(() {
      isLicensed = newStatus;
    });
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<IdsProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (context) => SettingsModel(),
      child: Builder(
        builder: (context) {
          // Obtener la configuración del modelo para aplicar al tema
          final settingsProvider = Provider.of<SettingsProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Configuraciones App',
            theme: settingsProvider.isDarkMode
                ? AppThemes.darkTheme
                : AppThemes.lightTheme,                                     
             home: 
             isLicensed ? authProvider.acceso ? const HomeScreen(): const LoginScreen() :LicenseExpiredScreen() ,       
          );
        },
      ),
    );
  }
}


class LicenseExpiredScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(      
      body: Center(child: Column(
        children: [
          Text('Tu licencia ha expirado contactarse a',style:TextStyle(fontSize: 56),),
           Text('doriancachim@gmail.com',style:TextStyle(fontSize: 56),),
        ],
      )),
    );
  }
}