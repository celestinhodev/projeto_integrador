import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi/components/register_template.dart';
import 'package:pi/components/submitt_button.dart';
import 'package:pi/constantes/appwrite_constants.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Declaration's
  // Appwrite
  AppwriteConstants appwrite_constants = AppwriteConstants();

  // Texting editing controller
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

  Future<bool> userRegisterStart({required String name, required String email, required String password,}) async {
    try {
      bool response = await appwrite_constants.accountCreate(name: name, email: email, password: password);

      return response;
    } catch (e) {
      return false;
    }
  }

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
        registerTemplate(
          hintText: 'Nome Completo',
          isPassword: false,
          textEditingController: nameEditingController,
        ),
        const SizedBox(height: 25),
        registerTemplate(
          hintText: 'Email',
          isPassword: false,
          textEditingController: emailEditingController,
        ),
        const SizedBox(height: 25),
        registerTemplate(
          hintText: 'Senha',
          isPassword: true,
          textEditingController: passwordEditingController,
        ),
        const SizedBox(height: 25),
        registerTemplate(
          hintText: 'Repita a Senha',
          isPassword: true,
          textEditingController: confirmPasswordEditingController,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
          child: Column(
            children: [
              Row(
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
                    ),
                  ),
                  const SizedBox(width: 20),
                  RichText(
                    text: const TextSpan(
                      text: 'Ao criar uma conta, você concorda com os\n',
                      style: TextStyle(
                        fontSize: 15,
                        color: paletteWhite,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Termos de uso ',
                          style: TextStyle(
                            color: paletteBlue,
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
                            color: paletteBlue,
                          ),
                        ),
                        TextSpan(
                          text: 'Notificação de cookies ',
                          style: TextStyle(
                            color: paletteBlue,
                          ),
                        ),
                        TextSpan(
                          text: 'e a ',
                          style: TextStyle(
                            color: paletteWhite,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Notificação de\nanúncios baseados em interesse',
                          style: TextStyle(
                            color: paletteBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        SubmittButton(
          buttonText: 'Cadastrar',
          onPressed: () async {
            String name = nameEditingController.text;
            String email = emailEditingController.text;
            String password = passwordEditingController.text;

            bool registerSuccess = await userRegisterStart(name: name, email: email, password: password); 
          
            if(registerSuccess == true) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            }
          },
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 22),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: paletteWhite,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            child: const Text(
              'Voltar ao login?',
              style: TextStyle(
                fontSize: 18,
                color: paletteBlue,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
