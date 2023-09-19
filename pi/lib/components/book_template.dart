import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import '../constantes/cores.dart';
import '../pages/admin/book_page_admin.dart';
import '../pages/book_page.dart';

// ignore: must_be_immutable
class BookTemplate extends StatefulWidget {
  // Declaration's
  String nomeLivro;
  String caminhoImagem;
  bool admin;
  models.Document documentInstance;
  models.Document? userPrefs;

  // Constructor
  BookTemplate({
    super.key,
    required this.caminhoImagem,
    required this.nomeLivro,
    required this.admin,
    required this.documentInstance,
    this.userPrefs,
  });

  @override
  State<BookTemplate> createState() => _BookTemplateState();
}

class _BookTemplateState extends State<BookTemplate> {
  // Methods
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.admin == false) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                documentInstance: widget.documentInstance,
                userPrefs: widget.userPrefs,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookCreationPage(
                documentInstance: widget.documentInstance,
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
                    height: 130,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    widget.caminhoImagem,
                    height: 130,
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
                  fontSize: 13,
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
    );
  }
}
