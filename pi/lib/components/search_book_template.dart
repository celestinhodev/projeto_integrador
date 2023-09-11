// Packages
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

// Constants
import '../constantes/cores.dart';

// Pages
import '../pages/book_page.dart';

class SearchBookTemplate extends StatefulWidget {
  String title;
  String imagePath;
  models.Document documentInstance;

  SearchBookTemplate({
    super.key,
    required this.title,
    required this.imagePath,
    required this.documentInstance,
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
              documentInstance: widget.documentInstance,
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
