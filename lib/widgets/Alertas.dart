import 'package:flutter/material.dart';


class EnviadoDialog extends StatefulWidget {
  final int durationInSeconds;
  final bool seEnvio;

  const EnviadoDialog({super.key, this.durationInSeconds = 2, required this.seEnvio});

  @override
  _EnviadoDialogState createState() => _EnviadoDialogState();
}

class _EnviadoDialogState extends State<EnviadoDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: widget.durationInSeconds), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(widget.seEnvio ? "ENVIADO" : "ERROR DE ENVÍO"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.seEnvio ? "Registros enviados a la base de datos" : "No se pudo enviar los registros"),
          const SizedBox(height: 10),
          Image.asset(widget.seEnvio ? "images/check.gif" : "images/error.gif"),
        ],
      ),
    );
  }
}

// Para mostrar el diálogo en cualquier parte del código:
void mostrarEnviadoDialog(BuildContext context, {int durationInSeconds = 2, required bool seEnvio}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => EnviadoDialog(durationInSeconds: durationInSeconds, seEnvio: seEnvio),
  );
}
