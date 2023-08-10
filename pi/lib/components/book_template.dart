import 'package:flutter/material.dart';

import '../constantes/cores.dart';
import '../pages/Home.dart';

class BookTemplate extends StatelessWidget {
  String nomeLivro;
  String caminhoImagem;

  BookTemplate({super.key, required this.caminhoImagem, required this.nomeLivro});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 5, 10),
                      child: Image.asset(
                        caminhoImagem,
                        height: 120,
                      ),
                    ),
                    Text(
                      nomeLivro,
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              );
  }
}