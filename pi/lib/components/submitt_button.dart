import 'package:flutter/material.dart';
import '../constantes/cores.dart';

class SubmittButton extends StatefulWidget {
  String buttonText;
  Function()? onPressed;

  SubmittButton({super.key, required this.buttonText, required this.onPressed});

  @override
  State<SubmittButton> createState() => _SubmittButtonState();
}

class _SubmittButtonState extends State<SubmittButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Container(
        width: double.infinity,
        height: 50,

        constraints: const BoxConstraints(
          maxWidth: 350,
        ),

        color: paletteYellow2, // Cor de fundo do botão
        padding: const EdgeInsets.symmetric(
            horizontal: 50), // Ajuste o padding conforme necessário
        child: Center(
          child: Text(
            widget.buttonText,
            style: const TextStyle(
              fontSize: 18,
              color: paletteBlack, // Cor do texto
            ),
          ),
        ),
      ),
    );
  }
}
