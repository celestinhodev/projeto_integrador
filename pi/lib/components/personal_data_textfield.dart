import 'package:flutter/material.dart';
import '../constantes/cores.dart';

// ignore: must_be_immutable
class PersonalDataTextField extends StatefulWidget {
  String? hintText;
  TextEditingController textEditingController = TextEditingController();
  bool isPassword;

  PersonalDataTextField(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.textEditingController});

  @override
  State<PersonalDataTextField> createState() => _PersonalDataTextField();
}

class _PersonalDataTextField extends State<PersonalDataTextField> {
  bool _senhaLogin = true;
  
  @override
  Widget build(BuildContext context) {
    return widget.isPassword == false
        ? TextField(
            style: const TextStyle(
              color: paletteWhite,
            ),
            controller: widget.textEditingController,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: paletteDarkGrey,
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: paletteYellow, width: 1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 0.4,
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 0.4,
                ),
              ),
            ),
          )
        : TextField(
            style: const TextStyle(
              color: paletteWhite,
            ),
            controller: widget.textEditingController,
            obscureText: _senhaLogin,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: paletteDarkGrey,
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: paletteYellow, width: 1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 0.4),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.redAccent,
                  width: 0.4,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _senhaLogin = !_senhaLogin;
                  });
                },
                child: Icon(
                  _senhaLogin ? Icons.visibility_off : Icons.visibility,
                  color: paletteGrey,
                ),
              ),
            ),
          );
  }
}
