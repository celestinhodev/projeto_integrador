import 'package:flutter/material.dart';
import '../constantes/cores.dart';

class registerTemplate extends StatelessWidget{
  String? hintText;

  registerTemplate({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                ),
              ),
            ),
    );

}
  


  
}