import 'package:flutter/material.dart';

import '../constantes/cores.dart';
import '../pages/book_page.dart';
import '../pages/home.dart';

class BookTemplate extends StatelessWidget {
  String nomeLivro;
  String caminhoImagem;

  BookTemplate(
      {super.key,
      required this.caminhoImagem,
      required this.nomeLivro,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                nomeLivro: nomeLivro,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Hero(
                tag: nomeLivro,
                child: Image.asset(
                  caminhoImagem,
                  height: 140,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 135,
                ),
                child: Text(
                  nomeLivro,
                  style: const TextStyle(
                    color: paletteWhite,
                    fontSize: 11,
                  ),
                  softWrap: false,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
