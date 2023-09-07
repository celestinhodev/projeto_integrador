// Packages
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import '../components/register_template.dart';
import '../components/submitt_button.dart';
import '../constantes/appwrite_constants.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/Home.dart';

import 'admin/home_admin.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Declarations
  // Appwrite
  AppwriteConstants appwrite_constants = AppwriteConstants();

  bool _senhaLogin = false;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  String email = '';
  String password = '';

  // Methods
  Future<bool> checkLogin() async {
    setState(() {
      email = emailEditingController.text;
      password = passwordEditingController.text;
    });

    try {
      bool loginStatus = await appwrite_constants.accountLogin(
        email: email,
        password: password,
      );

      return true;
    } catch (e) {}
    return false;
  }

  void navigateAfterLogin({required bool loginStatus}) {
    if (loginStatus == true) {
      switch (email) {
        case 'staffchattube@gmail.com':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeAdmin(),
            ),
          );
          break;
        default:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
      }
    } else {
      print('Falha no login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBlack,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'images/logo-login.png',
              width: 500,
              height: 200,
            ),
            registerTemplate(
              hintText: 'Email',
              isPassword: false,
              textEditingController: emailEditingController,
              needErrorVerification: true,
            ),
            const SizedBox(height: 25),
            registerTemplate(
              hintText: 'Senha',
              isPassword: true,
              textEditingController: passwordEditingController,
              needErrorVerification: true,
            ),
            //////////////Esqueceu a senha///////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 55, 15),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: paletteWhite,
                    ),
                    onPressed: () {
                      // Lógica aqui
                    },
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            ///////////////Botão login////////////////
            SubmittButton(
              buttonText: 'Login',
              onPressed: () async {
                bool login_info = await checkLogin();

                if (emailEditingController.text != '' &&
                    passwordEditingController.text != '') {
                  navigateAfterLogin(loginStatus: login_info);
                } else {}
              },
            ),

            const SizedBox(height: 40),
            const Text(
              'Ou, entre com',
              style: TextStyle(
                color: paletteWhite,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não tem uma conta?',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      //cor do foregroud
                      foregroundColor: paletteWhite,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: const Text(
                      'Registre-se',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
