import 'package:flutter/material.dart';

import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/cores.dart';

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
        title: Text(
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
          Padding(
            padding: const EdgeInsets.only(top: 20,),
            child: SingleChildScrollView(
              child: Flex(
                direction: Axis.vertical,
                children: [
          
                  cartTileTemplate(titleBook: 'NOME DE LIVRO MUITO GRANDE PRA PODER TESTAR SE ELE TA PEGANDO CERTIN',),
          
                ],
              ),
            ),
          ),
          Spacer(),
          Divider(
            color: paletteBlack,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SUBTOTAL',
                  style: TextStyle(
                      color: paletteBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  'R\$${subtotalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
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
              style: ElevatedButton.styleFrom(
                backgroundColor: paletteYellow
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
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
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.home), current: false),
        search: MyIconButtonNavigator(
            route: const Home(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: const Home(),
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
