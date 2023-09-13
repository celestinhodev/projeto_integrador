import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi/constantes/cores.dart';

class CarItemTemplate extends StatefulWidget {
  String caminhoImagem;
  String Texto;
  CarItemTemplate({super.key, required this.caminhoImagem, required this.Texto});

  @override
  State<CarItemTemplate> createState() => _CarItemTemplateState();
}

class _CarItemTemplateState extends State<CarItemTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: paletteYellow,
        child: Row(
          
          children: [
            Image.asset(widget.caminhoImagem),
            const SizedBox(width: 20),
            Text(widget.Texto),
          ],
        ),
      ),
    );
  }
}