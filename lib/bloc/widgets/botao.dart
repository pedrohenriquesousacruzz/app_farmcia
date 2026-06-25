import 'package:flutter/material.dart';

class CategoriaButton extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const CategoriaButton({
    super.key,
    required this.texto,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(right: 10),
   child :ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8A2A25),
        foregroundColor: Colors.white,
      ),
      child: Text(texto),
   )
    );
    
  }
}
