import 'package:flutter/material.dart';

import '../constantes/cores.dart';
import '../pages/admin/book_page_admin.dart';
import '../pages/book_page.dart';

class BookTemplate extends StatelessWidget {
  // Declaration's
  String nomeLivro;
  String? idDocument;
  String caminhoImagem;
  bool admin;


  // Constructor
  BookTemplate({
    super.key,
    required this.caminhoImagem,
    required this.nomeLivro,
    required this.admin,
    this.idDocument,
  });


  // Methods


  // Layout
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (admin == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(
                  nomeLivro: nomeLivro,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateBookPage(
                  nomeLivro: nomeLivro,
                  idDocument: idDocument,
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              caminhoImagem.contains('https://')
                  ? Image.network(
                      caminhoImagem,
                      height: 140,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      caminhoImagem,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
              const SizedBox(
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
                    fontSize: 12,
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
