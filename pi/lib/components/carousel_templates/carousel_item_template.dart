import 'package:flutter/material.dart';
import 'package:pi/components/submitt_button.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/Home.dart';
import 'package:pi/pages/carrinho.dart';

class CarItemTemplate extends StatefulWidget {
  final String caminhoImagem;
  final String texto;
  final String titulo;

  CarItemTemplate({Key? key, required this.caminhoImagem, required this.texto, required this.titulo}) : super(key: key);

  @override
  State<CarItemTemplate> createState() => _CarItemTemplateState();
}

class _CarItemTemplateState extends State<CarItemTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBrown,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => Carrinho(),
            ),
          );
        },
        
      child: Container(
        color: paletteBrown,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            children: [
              // Container para a imagem com largura máxima
              Container(

                width: 150, // largura máxima desejada para a imagem
                child: Image.asset(widget.caminhoImagem),
              ),

              const SizedBox(width: 20),

              // Coluna para o título e texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.titulo,
                        style: const TextStyle(
                          fontSize: 17,
                          color: paletteWhite,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Ajuste o espaçamento conforme necessário
                    Text(
                      widget.texto,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 99,
                      style: const TextStyle(
                        fontSize: 12,
                        color: paletteWhite
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
