import 'package:flutter/material.dart';

import '../constantes/cores.dart';
import '../pages/admin/book_page_admin.dart';
import '../pages/book_page.dart';

class BookTemplate extends StatefulWidget {
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

  @override
  State<BookTemplate> createState() => _BookTemplateState();
}

class _BookTemplateState extends State<BookTemplate> {
  // Methods
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (widget.admin == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsPage(
                  nomeLivro: widget.nomeLivro,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookCreationPage(
                  documentId: widget.idDocument,
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              widget.caminhoImagem.contains('https://')
                  ? Image.network(
                      widget.caminhoImagem,
                      height: 140,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      widget.caminhoImagem,
                      height: 140,
                      fit: BoxFit.contain,
                    ),
              const SizedBox(
                height: 10,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 135,
                ),
                child: Text(
                  widget.nomeLivro,
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
