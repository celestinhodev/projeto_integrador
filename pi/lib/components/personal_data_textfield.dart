import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constantes/cores.dart';

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
  State<PersonalDataTextField> createState() => _registerTemplateState();
}

class _registerTemplateState extends State<PersonalDataTextField> {
  bool _senhaLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 350,
        maxHeight: 45,
      ),
      child: widget.isPassword == false
          ? TextField(
              style: TextStyle(
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
              style: TextStyle(
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
            ),
    );
  }
}
