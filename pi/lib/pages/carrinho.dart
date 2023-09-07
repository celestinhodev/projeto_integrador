import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/appwrite_constants.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

import '../components/cardTileTemplate.dart';
import 'Home.dart';

class Carrinho extends StatefulWidget {
  Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  AppwriteConstants appwrite_constants = AppwriteConstants();

  double subtotalPrice = 0.0;
  List<Widget> listCartItens = [];

  void getCartItens() async   {
    List<String> listCartItensDB = await appwrite_constants.getCartItens();

    for (var element in listCartItensDB) {
      appwrite_constants.database.getBook(documentId: documentId);

      cartTileTemplate(titleBook: titleBook, amount: 1, price: price);
    }
  }

  @override
  void initState() {
    super.initState();

    getCartItens();
  }

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
                children: listCartItens,
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
          route: Home(),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
            route: SearchScreen(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: Carrinho(),
            icon: const Icon(Icons.shopping_cart),
            current: true),
        user: MyIconButtonNavigator(
          route: Profile(),
          icon: const Icon(Icons.person),
          current: false,
        ),
      ),
    );
  }
}
