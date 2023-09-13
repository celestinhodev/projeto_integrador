import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/appwrite_system.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

import '../components/cartTileTemplate.dart';
import 'Home.dart';

class Carrinho extends StatefulWidget {
  models.Document? userPrefs;

  Carrinho({super.key, this.userPrefs});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  AppwriteSystem appwriteSystem = AppwriteSystem();

  double subtotalPrice = 0.0;
  List<Widget> cartItensWidgets = [];
  List<dynamic> cartItens = [];

  // Methods
  Future<void> getCartItens() async {
    subtotalPrice = 0;

    if (widget.userPrefs!.data['cartItens'] != '[]') {
      cartItens = await appwriteSystem.getCurrentCart(
          currentCartString: widget.userPrefs!.data['cartItens']);

      int counter = 0;

      for (Map<String, dynamic> item in cartItens) {
        setState(() {
          cartItensWidgets.add(cartTileTemplate(
            titleBook: item['title'],
            amount: item['amount'],
            price: item['price'],
            imageUrl: item['imagePath'],
            index: counter,
            indexDelete: deleteItemFromCart,
            amountUpdate: amountUpdate,
          ));
          subtotalPrice += item['price'] * item['amount'];
        });

        counter++;
      }
    }
  }

  void deleteItemFromCart(int index) async {
    if (cartItens.length > 1) {
      cartItens.removeAt(index);
      cartItensWidgets = [];

      int counter = 0;

      for (Map<String, dynamic> item in cartItens) {
        setState(() {
          cartItensWidgets.add(cartTileTemplate(
            titleBook: item['title'],
            amount: item['amount'],
            price: item['price'],
            imageUrl: item['imagePath'],
            index: counter,
            indexDelete: deleteItemFromCart,
            amountUpdate: amountUpdate,
          ));
          subtotalPrice += item['price'] * item['amount'];
        });

        counter++;
      }
    } else {
      cartItens = [];

      setState(() {
        cartItensWidgets = [];
      });
    }

    widget.userPrefs!.data['cartItens'] = JsonEncoder().convert(cartItens);

    var response = await appwriteSystem.updateCart(
        newCartItens: cartItens, documentId: widget.userPrefs!.$id);
  }

  void amountUpdate(int amount, int index) async {
    cartItens[index]['amount'] = amount;
    cartItensWidgets = [];
    subtotalPrice = 0;

    int counter = 0;

    for (Map<String, dynamic> item in cartItens) {
      setState(() {
        cartItensWidgets.add(cartTileTemplate(
          titleBook: item['title'],
          amount: item['amount'],
          price: item['price'],
          imageUrl: item['imagePath'],
          index: counter,
          indexDelete: deleteItemFromCart,
          amountUpdate: amountUpdate,
        ));
        subtotalPrice += item['price'] * item['amount'];
      });

      counter++;
    }

    widget.userPrefs!.data['cartItens'] =
        const JsonEncoder().convert(cartItens);

    var response = await appwriteSystem.updateCart(
      newCartItens: cartItens,
      documentId: widget.userPrefs!.$id,
    );
  }

  @override
  void initState() {
    super.initState();
    appwriteSystem.updateCart(
      newCartItens: JsonDecoder().convert(widget.userPrefs!.data['cartItens']),
      documentId: widget.userPrefs!.$id,
    );

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
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: Column(
                children: cartItensWidgets,
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
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'R\$${subtotalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: paletteBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
          route: Home(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
          route: SearchScreen(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.search),
          current: false,
        ),
        cart: MyIconButtonNavigator(
          route: null,
          icon: const Icon(Icons.shopping_cart),
          current: true,
        ),
        user: MyIconButtonNavigator(
          route: Profile(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.person),
          current: false,
        ),
      ),
    );
  }
}
