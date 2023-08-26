import 'package:flutter/material.dart';
import '../constantes/cores.dart';

class registerTemplate extends StatelessWidget{
  String hintTexto;

  registerTemplate({super.key, required this.hintTexto});

  @override
  Widget build(BuildContext context) {
    return Container(
            child: const Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 5),
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintTexto,
                  hintStyle: TextStyle(color: paletteWhite),
                  fillColor: paletteDarkGrey,
                  filled: true,
                ),
              ),
            ),
    );

}
  


  
}