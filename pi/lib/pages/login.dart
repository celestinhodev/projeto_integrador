// Packages
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:pi/components/social_login_button_template.dart';

import '../components/register_template.dart';
import '../components/submitt_button.dart';
import '../constantes/appwrite_system.dart';
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
  AppwriteSystem appwriteSystem = AppwriteSystem();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String email = '';
  String password = '';

  Widget error = Container(
    color: Colors.redAccent,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Email ou senha incorretos.'),
      ],
    ),
  );
  Widget success = Container(
    color: Colors.green,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Login concluido!'),
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

  void setEditingControllerText() {
    setState(() {
      email = emailEditingController.text;
      password = passwordEditingController.text;
    });
  }

  void navigateAfterLogin({required String loginStatus}) async {
    if (loginStatus == '201') {
      await showErrorMessage(success);
      switch (email) {
        case 'admin@gmail.com':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeAdmin(),
            ),
          );
          break;
        case 'staffchattube@gmail.com':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeAdmin(),
            ),
          );
          break;
        case 'isabelle.lima@gmail.com':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeAdmin(),
            ),
          );
          break;
        case 'gugamarquesgsm@gmail.com':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
          break;
        default:
          models.Document? userPrefs =
              await appwriteSystem.getUserPreferences();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(userPrefs: userPrefs),
            ),
          );
      }
    } else {
      showErrorMessage(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBlack,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'images/logo-login.png',
                    width: 500,
                    height: 200,
                  ),
                  RegisterTemplate(
                    hintText: 'Email',
                    isPassword: false,
                    textEditingController: emailEditingController,
                    needErrorVerification: true,
                    submittField: (p0) {
                      setState(() {
                        FocusScope.of(context).requestFocus(focusNode);
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  RegisterTemplate(
                    hintText: 'Senha',
                    isPassword: true,
                    textEditingController: passwordEditingController,
                    needErrorVerification: true,
                    focusNode: focusNode,
                    submittField: (p0) async {
                      setEditingControllerText();

                      String loginStatus = await appwriteSystem.loginAccount(
                          email: email, password: password);

                      if (emailEditingController.text != '' &&
                          passwordEditingController.text != '') {
                        navigateAfterLogin(loginStatus: loginStatus);
                      } else {}
                    },
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
                      showDialog(
                        context: context,
                        builder: (context) => Container(
                          color: const Color.fromARGB(61, 0, 0, 0),
                          child: Center(
                            child: Image.asset(
                              'images/loading.gif',
                              width: 85,
                              height: 85,
                            ),
                          ),
                        ),
                      );

                      setEditingControllerText();

                      String loginStatus = await appwriteSystem.loginAccount(
                          email: email, password: password);

                      if (emailEditingController.text != '' &&
                          passwordEditingController.text != '' && loginStatus != '400') {
                        navigateAfterLogin(loginStatus: loginStatus);
                      } else {
                        Navigator.of(context).pop();
                        showErrorMessage(error);
                      }
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

                  const SizedBox(height: 30),

                  SocialLoginButton(
                    socialImagePath: 'images/google-logo.png',
                    socialText: 'Google',
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),

                  SocialLoginButton(
                    socialImagePath: 'images/facebook-logo.png',
                    socialText: 'Facebook',
                    onTap: () {},
                  ),

                  const SizedBox(height: 40),

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
                                builder: (context) => const Register(),
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
          ),
        ],
      ),
      bottomSheet: statusShowing != null
          ? BottomSheet(onClosing: () {}, builder: (context) => statusShowing!)
          : null,
    );
  }
}
