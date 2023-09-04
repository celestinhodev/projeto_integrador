import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi/components/register_template.dart';
import 'package:pi/constantes/cores.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    return paletteYellow;
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBlack,
      body: Column(children: [
        Image.asset(
          'Images/logo-login.png',
          width: 500,
          height: 200,
        ),
        registerTemplate(hintText: 'Nome Completo', isPassword: false),
        const SizedBox(height: 25),
        registerTemplate(hintText: 'Email', isPassword: false),
        const SizedBox(height: 25),
        registerTemplate(hintText: 'Senha', isPassword: true),
        const SizedBox(height: 25),
        registerTemplate(hintText: 'Repita a Senha', isPassword: true),
        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Row(
            children: [
              Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  checkColor: paletteBlack,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              RichText(
                text: const TextSpan(
                  text:
                      'Ao criar uma conta, você concorda com os\n',
                  style: TextStyle(
                    fontSize: 15,
                    color: paletteWhite,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Termos de uso ',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: 'do aplicativo. Por favor,\n'
                      'verifique a ',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                    TextSpan(
                      text: 'Notificação de privacidade\n',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: 'Notificação de cookies ',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: 'e a ',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                    TextSpan(
                      text:'Notificação de\nanúncios baseados em interesse',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
