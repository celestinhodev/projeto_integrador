import 'package:flutter/material.dart';
import '../constantes/cores.dart';

class registerTemplate extends StatefulWidget {
  String? hintText;
  TextEditingController textEditingController = TextEditingController();
  bool isPassword;
  bool needErrorVerification;

  registerTemplate({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.textEditingController,
    required this.needErrorVerification,
  });

  @override
  State<registerTemplate> createState() => _registerTemplateState();
}

class _registerTemplateState extends State<registerTemplate> {
  bool _senhaLogin = true;
  String? errorText = null;

  void errorVerify() {
    setState(() {
      if (widget.textEditingController.text == '') {
        errorText = 'O campo precisa ser preenchido';
      } else {
        errorText = null;
      }

      if (widget.isPassword) {
        if (widget.textEditingController.text.length < 8) {
          errorText = 'A senha precisa ter no minimo 8 digitos.';
        } else {
          errorText = null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 350,
      ),
      child: widget.isPassword == false
          ? TextField(
              style: TextStyle(
                color: paletteWhite,
              ),
              controller: widget.textEditingController,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) =>
                  widget.needErrorVerification == true ? errorVerify() : null,
              decoration: InputDecoration(
                errorText: errorText,
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: paletteWhite),
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
                border: OutlineInputBorder(),
              ),
            )
          : TextField(
              style: TextStyle(
                color: paletteWhite,
              ),
              controller: widget.textEditingController,
              obscureText: _senhaLogin,
              onChanged: (value) =>
                  widget.needErrorVerification == true ? errorVerify() : null,
              keyboardType: widget.hintText == 'Email'
                  ? TextInputType.emailAddress
                  : widget.hintText == 'Nome Completo'
                      ? TextInputType.name
                      : widget.hintText == 'Telefone'
                          ? TextInputType.phone
                          : TextInputType.text,
              decoration: InputDecoration(
                errorText: errorText,
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                hintText: widget.hintText,
                hintStyle: const TextStyle(color: paletteWhite),
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
                border: OutlineInputBorder(),
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
