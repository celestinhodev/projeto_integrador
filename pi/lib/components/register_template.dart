import 'package:flutter/material.dart';
import '../constantes/cores.dart';

class registerTemplate extends StatefulWidget {
  String? hintText;
  bool isPassword;

  registerTemplate({super.key, required this.hintText, required this.isPassword});

  @override
  State<registerTemplate> createState() => _registerTemplateState();
}

class _registerTemplateState extends State<registerTemplate> {
  TextEditingController textController = TextEditingController();
  bool _senhaLogin = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(60, 0, 60, 5),
        child: widget.isPassword == false
            ? TextField(
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: paletteYellow, width: 1),

                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey, width: 0.4,
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent, width: 0.4,
                    ),
                  ),
                ),
              )
            : TextField(
                controller: textController,
                obscureText: _senhaLogin,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: paletteYellow, width: 1),

                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.4
                    ),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.redAccent, width: 0.4,
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
      )
    ]);
  }
}
