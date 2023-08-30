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
            const Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 5),
              child: TextField(
                obscureText: !_senhaLogin,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: const TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _senhaLogin = !_senhaLogin;
                      });
                    },
                    child: Icon(
                      _senhaLogin ? Icons.visibility : Icons.visibility_off,
                      color: paletteBlack,
                    ),
                  ),
                ),
              ),
            ),
            //////////////Esqueceu a senha///////////////////////////
            Padding(
              padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
              child: TextButton(
                style: TextButton.styleFrom(
                  //cor do foregroud
                  foregroundColor: paletteWhite,
                ),
                onPressed: () {
                  //logica aqui
                },
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ///////////////Botão login////////////////
            Container(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: paletteBlack,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                ),
                onPressed: () {
                  //logica aqui
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    color: paletteYellow2
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
                  style: TextStyle(
                    fontSize: 25,
                  ),
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
