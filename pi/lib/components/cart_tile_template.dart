// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

// ignore: must_be_immutable
class CartTileTemplate extends StatefulWidget {
  String titleBook;
  int amount;
  double price;
  String imageUrl;
  int index;
  Function(int index) indexDelete;
  Function(int amount, int index) amountUpdate;

  CartTileTemplate({
    super.key,
    required this.titleBook,
    required this.amount,
    required this.price,
    required this.imageUrl,
    required this.index,
    required this.indexDelete,
    required this.amountUpdate,
  });


  @override
  State<CartTileTemplate> createState() => _CartTileTemplateState();
}

class _CartTileTemplateState extends State<CartTileTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      constraints: const BoxConstraints(
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
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: Text(
                      widget.titleBook,
                      style: const TextStyle(
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
                        onPressed: () {
                          setState(() {
                            widget.amount--;
                            widget.amountUpdate(widget.amount, widget.index);
                            if(widget.amount == 0) {
                              widget.indexDelete(widget.index,);  
                            }
                          });
                        },
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
                        onPressed: () {
                          setState(() {
                            widget.amount++;
                            widget.amountUpdate(widget.amount, widget.index);
                          });
                        },
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
