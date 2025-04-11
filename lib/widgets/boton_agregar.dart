import 'package:flutter/material.dart';

class BotonAgregar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? textoopcional;

  const BotonAgregar({
    super.key,    
    this.onPressed,
    this.textoopcional,
  });

  @override
  Widget build(BuildContext context) {
    final bool setienetext = textoopcional != null && textoopcional!.isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 53,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 187, 206, 243),
                Color.fromARGB(255, 117, 165, 247),
              ],
            ),
            borderRadius: BorderRadius.circular(8), // Ajusta según lo necesites
          ),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
            ),
            onPressed: onPressed,


            icon: const Icon(Icons.add, color: Colors.black),
            label: Text(
               setienetext ? textoopcional! :'AGREGAR UN REGISTRO',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )))));
      
  }
}