import 'package:flutter/material.dart';
import 'package:pi/constantes/appwrite_constants.dart';

import '../constantes/cores.dart';
import '../pages/book_page.dart';

class SearchBookTemplate extends StatefulWidget {
  String documentId;
  String title;
  String imagePath;

  SearchBookTemplate({
    super.key,
    required this.documentId,
    required this.title,
    required this.imagePath,
  });

  @override
  State<SearchBookTemplate> createState() => _SearchBookTemplateState();
}

class _SearchBookTemplateState extends State<SearchBookTemplate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(
              documentId: widget.documentId,
            ),
          ),
        );
      },
      
      child: Container(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(
                color: paletteGrey,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 35,
                  ),
                  Container(
                    height: 98,
                    child: widget.imagePath != '' ? Image.network(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ) : null,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          color: paletteWhite,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Divider(
                color: paletteGrey,
              ),
            ],
          )),
    );
  }
}
