import 'package:flutter/material.dart';

import '../constantes/cores.dart';
import '../pages/book_page.dart';
import '../pages/home.dart';

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
                      builder: (context) => BookDetailsPage(nomeLivro: nomeLivro,),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        caminhoImagem,
                        height: 120,
                        fit: BoxFit.fill,
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 110,
                        ),
                        child: Text(
                          nomeLivro,
                          style: const TextStyle(
                            color: paletteWhite,
                          ),
                      
                        softWrap: false,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                
                        textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}