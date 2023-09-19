// Packages
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

// Constants
import '../constantes/cores.dart';

// Pages
import '../pages/book_page.dart';

// ignore: must_be_immutable
class SearchBookTemplate extends StatefulWidget {
  String title;
  String imagePath;
  models.Document documentInstance;
  models.Document? userPrefs;

  SearchBookTemplate({
    super.key,
    required this.title,
    required this.imagePath,
    required this.documentInstance,
    this.userPrefs,
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
              userPrefs: widget.userPrefs,
            ),
          ),
        );
      },
      
      child: SizedBox(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Divider(
                color: paletteGrey,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 35,
                  ),
                  SizedBox(
                    height: 98,
                    child: widget.imagePath != '' ? Image.network(
                      widget.imagePath,
                      fit: BoxFit.cover,
                    ) : null,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 20, 20, 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.title,
                        softWrap: false,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: paletteWhite,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: paletteGrey,
              ),
            ],
          )),
    );
  }
}
