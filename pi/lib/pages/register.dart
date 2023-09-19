import 'package:flutter/material.dart';

import 'package:pi/components/register_template.dart';
import 'package:pi/components/submitt_button.dart';
import 'package:pi/constantes/appwrite_system.dart';
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
  AppwriteSystem appwriteSystem = AppwriteSystem();

  // Texting editing controller
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    return paletteYellow;
  }

  bool isChecked = false;

  Widget error = Container(
    color: Colors.redAccent,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Falha no registro.'),
      ],
    ),
  );
  Widget success = Container(
    color: Colors.green,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Registro bem-sucedido!'),
      ],
    ),
  );
  Widget? statusShowing;

  // Methods
  showErrorMessage(atualError) async {
    setState(() {
      statusShowing = atualError;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      statusShowing = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBlack,
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            'Images/logo-login.png',
            width: 500,
            height: 200,
          ),
          RegisterTemplate(
            hintText: 'Nome Completo',
            isPassword: false,
            textEditingController: nameEditingController,
            needErrorVerification: true,
            submittField: (p0) {},
          ),
          const SizedBox(height: 25),
          RegisterTemplate(
            hintText: 'Email',
            isPassword: false,
            textEditingController: emailEditingController,
            needErrorVerification: true,
            submittField: (p0) {},
          ),
          const SizedBox(height: 25),
          RegisterTemplate(
            hintText: 'Senha',
            isPassword: true,
            textEditingController: passwordEditingController,
            needErrorVerification: true,
            submittField: (p0) {},
          ),
          const SizedBox(height: 25),
          RegisterTemplate(
            hintText: 'Repita a Senha',
            isPassword: true,
            textEditingController: confirmPasswordEditingController,
            needErrorVerification: true,
            submittField: (p0) {},
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
              String confirmPassword = confirmPasswordEditingController.text;
              
              bool registerSuccess = false;
      
              if (name != '' &&
                  email != '' &&
                  password != '' &&
                  confirmPassword != '' &&
                  password == confirmPassword &&
                  isChecked) {
      
                registerSuccess = await appwriteSystem.registerAccount(name: name, email: email, password: password);
                
              }
      
              if (registerSuccess == true) {
                await showErrorMessage(success);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              } else {
                showErrorMessage(error);
              }
            },
          ),
          
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 22, 0, 22),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: paletteWhite,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
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
      ),
      bottomSheet: statusShowing != null ? BottomSheet(
        onClosing: () {},
        builder: (context) => statusShowing!
      ) : null,
    );
  }
}
