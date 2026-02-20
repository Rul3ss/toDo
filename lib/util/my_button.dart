import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      textColor: Colors.white, // Cor do texto
      padding: EdgeInsets.all(10), // Espaçamento interno
      shape: RoundedRectangleBorder(
        // Bordas arredondadas
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5, // Sombra
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
