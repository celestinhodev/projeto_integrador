import 'package:flutter/material.dart';

import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/search.dart';

import '../components/cardTileTemplate.dart';
import 'home.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  double subtotalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CARRINHO',
          style: TextStyle(color: paletteBlack, fontWeight: FontWeight.bold),
        ),
        backgroundColor: paletteWhite,
        toolbarHeight: 50,
        centerTitle: true,
      ),
      backgroundColor: paletteWhite,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            height: 408,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  cartTileTemplate(
                    titleBook:
                        'NOME DE LIVRO MUITO GRANDE PRA PODER TESTAR SE ELE TA PEGANDO CERTIN',
                    amount: 2,
                    price: 65.35,
                  ),
                  cartTileTemplate(
                    titleBook: 'Nome de livro 2 pra testar se ta tudo certinho',
                    amount: 9,
                    price: 35.10,
                  ),
                  cartTileTemplate(
                    titleBook: 'Nome de livro 3 pra testar se ta tudo certinho',
                    amount: 2,
                    price: 35.10,
                  ),
                  cartTileTemplate(
                    titleBook: 'Nome de livro 4 pra testar se ta tudo certinho',
                    amount: 3,
                    price: 35.10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 118,
        child: Column(
          children: [
            const Divider(
              color: paletteBlack,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SUBTOTAL',
                    style: TextStyle(
                        color: paletteBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    'R\$${subtotalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: paletteBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: paletteYellow),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                  child: Text(
                    'FINALIZAR COMPRA',
                    style: TextStyle(
                        color: paletteBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.home), current: false),
        search: MyIconButtonNavigator(
            route: const SearchScreen(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: const Carrinho(),
            icon: const Icon(Icons.shopping_cart),
            current: true),
        user: MyIconButtonNavigator(
            route: const Home(),
            icon: const Icon(Icons.person),
            current: false),
      ),
    );
  }
}
