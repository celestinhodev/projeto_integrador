import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

class cartTileTemplate extends StatefulWidget {
  String titleBook;
  double amount;
  double price;
  String imageUrl;

  cartTileTemplate({
    super.key,
    required this.titleBook,
    required this.amount,
    required this.price,
    required this.imageUrl,
  });


  @override
  State<cartTileTemplate> createState() => _cartTileTemplateState();
}

class _cartTileTemplateState extends State<cartTileTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(bottom: 5),
      child: GridTile(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 55, 5),
              child: Image.asset('images/livros/livro.png'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 260,
                    ),
                    child: Text(
                      widget.titleBook,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.amount--;
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: paletteBlack,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.amount.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            widget.amount++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'x R\$${(widget.amount * widget.price).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 55,
            ),
          ],
        ),
      ),
    );
  }
}
