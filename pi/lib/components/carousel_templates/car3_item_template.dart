import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/Home.dart';

class Car3Template extends StatefulWidget {
  final String texto;
  final String imagem1;
  final String imagem2;
  final String imagem3;

  const Car3Template({Key? key, required this.texto, required this.imagem1, required this.imagem2, required this.imagem3}) : super(key: key);

  @override
  State<Car3Template> createState() => _Car3TemplateState();
}

class _Car3TemplateState extends State<Car3Template> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
        },
        child: Container(
          color: paletteBrown,
          child: Column(
            children: [
              Text(
                widget.texto,
                style: const TextStyle(
                  fontSize: 30,
                  color: paletteWhite
                ),
              ),
              //const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                  
                    Container(
                      width: 100,
                      child: Image.asset(widget.imagem1)
                    ), 
                    const SizedBox(width: 50),
                    Container(
                      width: 100,
                      child: Image.asset(widget.imagem2)
                      ), 
                      const SizedBox(width: 50),
                    Container(
                      width: 100,
                      child: Image.asset(widget.imagem3)
                      ), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
