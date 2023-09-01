import 'package:flutter/material.dart';
import 'package:pi/components/register_template.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _senhaLogin = false;

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
            registerTemplate(hintText: 'Email', isPassword: false),
            const SizedBox(height: 30),
            registerTemplate(hintText: 'Senha', isPassword: true),
            //////////////Esqueceu a senha///////////////////////////
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40,
                  20), // Ajuste o padding horizontal conforme necessário
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: double.infinity), // Define largura máxima
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
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),

            ///////////////Botão login////////////////
            TextButton(      
              onPressed: () {

              },
              child: Container(
                width: 379, 
                height: 50,
                color: paletteYellow2, // Cor de fundo do botão
                padding: const EdgeInsets.symmetric(horizontal: 50), // Ajuste o padding conforme necessário
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: paletteBlack, // Cor do texto
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Ou, entre com',
              style: TextStyle(
                color: paletteWhite,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Não tem uma conta?',
                  style: TextStyle(
                    color: paletteWhite,
                    fontSize: 25,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    //cor do foregroud
                    foregroundColor: paletteWhite,
                  ),
                  onPressed: () {
                    //logica aqui
                  },
                  child: const Text(
                    'Registre-se',
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
