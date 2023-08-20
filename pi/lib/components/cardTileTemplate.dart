import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

class cartTileTemplate extends StatelessWidget {
  cartTileTemplate({
    super.key,
    required this.titleBook,
  });

  String titleBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.red,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 40,),

          Container(
            height: 140,
            child: Image.asset(
              'images/livros/livro.png'
            ),
          ),

          SizedBox(width: 50,),
          
          Container(
            width: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    SizedBox(height: 20,),
                    
                    Text(
                      titleBook,
                      softWrap: false,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: paletteBlack,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    TextButton(onPressed: () {}, child: Text('-'))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}