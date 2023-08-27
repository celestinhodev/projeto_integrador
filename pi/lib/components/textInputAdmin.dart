import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

class TextFieldAdmin extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconButton? suffixIcon;

  TextFieldAdmin({
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    super.key,
  });

  @override
  // ignore: no_logic_in_create_state
  State<TextFieldAdmin> createState() => _MyTextFieldState(
      hintText: hintText,
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType);
}

class _MyTextFieldState extends State<TextFieldAdmin> {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconButton? suffixIcon;

  _MyTextFieldState({
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
  });

  var _text = '';

  String? get _errorText {
    final text = widget.controller.value.text;

    if (text.isEmpty) {
      return 'O campo precisa ser preenchido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return // TextField Email

        TextField(
      // Controlador do texto
      controller: controller,
      // Texto escondido em senha
      obscureText: obscureText,
      
      // Tipo de teclado
      keyboardType: keyboardType,
      style: TextStyle(
        color: paletteWhite,
      ),
      cursorColor: paletteWhite,


      decoration: InputDecoration(
        // Borders
        border: OutlineInputBorder(),
        enabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: paletteWhite)),
        disabledBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: paletteWhite)),
            focusedBorder: 
            const OutlineInputBorder(borderSide: BorderSide(color: paletteYellow)),
        suffixIcon: suffixIcon,

        // Background Color,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),

        errorText: _errorText,
      ),
      maxLines: null,
      

      onChanged: (text) {
        setState(() => _text);
      },
    );
  }
}
