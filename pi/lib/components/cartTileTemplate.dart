import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

class cartTileTemplate extends StatefulWidget {
  String titleBook;
  double amount;
  double price;
  String imageUrl;
  Function() addToAmount;
  Function() subtractFromAmount;

  cartTileTemplate({
    super.key,
    required this.titleBook,
    required this.amount,
    required this.price,
    required this.imageUrl,
    required this.addToAmount,
    required this.subtractFromAmount,
  });


  @override
  State<cartTileTemplate> createState() => _cartTileTemplateState();
}

class _cartTileTemplateState extends State<cartTileTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      constraints: BoxConstraints(
        maxWidth: 500
      ),
      padding: const EdgeInsets.only(bottom: 5),
      child: GridTile(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 10, 35, 5),
              child: Image.network(widget.imageUrl)
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 250),
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

                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.subtractFromAmount,
                        icon: const Icon(Icons.remove),
                      ),
                      const SizedBox(
                        width: 2,
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
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      IconButton(
                        onPressed: widget.addToAmount,
                        icon: const Icon(Icons.add),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'x R\$${(widget.amount * widget.price).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
