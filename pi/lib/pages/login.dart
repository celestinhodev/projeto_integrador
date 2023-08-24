import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _senhaVisivel = false;

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
                obscureText: !_senhaVisivel,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: const TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _senhaVisivel = !_senhaVisivel;
                      });
                    },
                    child: Icon(
                      _senhaVisivel
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: paletteBlack,
                    ),
                  ),
                ),
              ),
            ),
            //////////////Esqueceu a senha///////////////////////////
            Padding(padding: const EdgeInsets.fromLTRB(200, 0, 0, 0),
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
                    fontSize: 20
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ///////////////Botão login////////////////
            TextButton(
              style: TextButton.styleFrom(
              //cor do foregroud
                foregroundColor: paletteBlack,
                //cor do background
                backgroundColor: paletteYellow2,
                //Espaçamento dentro do botão
                padding: 
                const EdgeInsets.symmetric(
                  horizontal: 165,
                  vertical: 20
                  ) 
              ),
              onPressed: () {
                //logica aqui
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Ou, entre com',
              style: TextStyle(
                color: paletteWhite,
                fontSize: 25
              ),
            )
          ],  
        ),
      ),
    );
  }
}
