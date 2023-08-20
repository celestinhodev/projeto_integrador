import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

class cartTileTemplate extends StatefulWidget {
  String titleBook;
  double amount;
  double price;

  cartTileTemplate({
    super.key,
    required this.titleBook,
    required this.amount,
    required this.price,
  });


  @override
  State<cartTileTemplate> createState() => _cartTileTemplateState(
    titleBook: titleBook,
    amount: amount,
    price: price
  );
}

class _cartTileTemplateState extends State<cartTileTemplate> {
  String titleBook;
  double amount;
  double price;

  _cartTileTemplateState({
    required this.titleBook,
    required this.amount,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: EdgeInsets.only(bottom: 5),
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
                    constraints: BoxConstraints(
                      maxWidth: 260,
                    ),
                    child: Text(
                      'Titulo aqui muito grande pra eu testar se ta quebrando e descendo pra outra linha',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            amount--;
                          });
                        },
                        icon: Icon(Icons.remove),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: paletteBlack,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            amount.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            amount++;
                          });
                        },
                        icon: Icon(Icons.add),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'x R\$${(amount * price).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              width: 55,
            ),
          ],
        ),
      ),
    );
  }
}
