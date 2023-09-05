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
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

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
      body: Column(
        children: [
          Image.asset(
            'Images/logo-login.png',
            width: 500,
            height: 200,
          ),
          registerTemplate(hintText: 'Nome Completo', isPassword: false, textEditingController: nameEditingController,),
          const SizedBox(height: 25),
          registerTemplate(hintText: 'Email', isPassword: false, textEditingController: emailEditingController,),
          const SizedBox(height: 25),
          registerTemplate(hintText: 'Senha', isPassword: true, textEditingController: passwordEditingController,),
          const SizedBox(height: 25),
          registerTemplate(hintText: 'Repita a Senha', isPassword: true, textEditingController: confirmPasswordEditingController,),
          const SizedBox(height: 20),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(62, 0, 0, 0),
            child: Row(
              children: [
                Transform.scale(
                  scale: 2.0,
                child: Checkbox(
                  checkColor: paletteBlack,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                )
                ),
                const SizedBox(width: 20),
                RichText(
                  text: TextSpan(
                    text: 'Ao criar uma conta, você concorda com os' 
                  'TERMOS DE USO do aplicativo. Por favor'
                  'verifique a NOTIFICAÇÃO DE PRIVACIDADE,'
                  'NOTIFICAÇÃO DE COOKIES, e a NOTIFICAÇÃO' 
                  'DE ANÚNCIOS BASEADOS EM INTERESSE.',
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'termos de uso',
                      style: TextStyle(
                        color: Colors.blue,
                      )
                    )
                    
                  ]
                  ),
                )
              ],
            ),
          ),
          ]
        ),
      );
  }
}
