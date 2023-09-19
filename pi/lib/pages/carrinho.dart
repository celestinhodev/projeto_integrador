// Imports
// Packages
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:pi/pages/payment.dart';
import 'package:pi/pages/personal_data.dart';

// Components
import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';
import '../components/address_check_template.dart';
import '../components/cartTileTemplate.dart';

// Constants
import '../constantes/appwrite_system.dart';
import '../constantes/cores.dart';

// Pages
import 'profile.dart';
import 'search.dart';
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
            price: double.parse(item['price'].toString().replaceAll(',', '.')),
            imageUrl: item['imagePath'],
            index: counter,
            indexDelete: deleteItemFromCart,
            amountUpdate: amountUpdate,
          ));
          subtotalPrice += double.parse(item['price'].toString().replaceAll(',', '.')) * item['amount'];
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
            price: double.parse(item['price'].toString().replaceAll(',', '.')),
            imageUrl: item['imagePath'],
            index: counter,
            indexDelete: deleteItemFromCart,
            amountUpdate: amountUpdate,
          ));
          subtotalPrice += double.parse(item['price'].toString().replaceAll(',', '.')) * item['amount'];
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
          price: double.parse(item['price'].toString().replaceAll(',', '.')),
          imageUrl: item['imagePath'],
          index: counter,
          indexDelete: deleteItemFromCart,
          amountUpdate: amountUpdate,
        ));
        subtotalPrice += double.parse(item['price'].toString().replaceAll(',', '.')) * item['amount'];
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


  finalizarCompra() {
    setState(() {
      if (widget.userPrefs == null ||
          widget.userPrefs!.data['cep'] == null ||
          widget.userPrefs!.data['city'] == null ||
          widget.userPrefs!.data['address'] == null ||
          widget.userPrefs!.data['complement'] == null ||
          widget.userPrefs!.data['cep'] == '' ||
          widget.userPrefs!.data['city'] == '' ||
          widget.userPrefs!.data['address'] == '' ||
          widget.userPrefs!.data['complement'] == '') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Seu endereço está incompleto... ',
              style: TextStyle(
                  color: paletteWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: paletteBlack,
            content: Text(
              'Para continuar a compra atualize seu endereço.',
              style: TextStyle(color: paletteWhite, fontSize: 18),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Atualizar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PersonalData(userPrefs: widget.userPrefs),
                      ));
                },
              ),
              CupertinoDialogAction(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Seu endereço está correto?',
              style: TextStyle(
                  color: paletteWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: paletteBlack,
            content: Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: AddressCheckTemplate(
                Text1: 'Endereço',
                cep: widget.userPrefs!.data['cep'],
                city: widget.userPrefs!.data['city'],
                address: widget.userPrefs!.data['address'],
                complement: widget.userPrefs!.data['complement'],
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Continuar'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Payment(userPrefs: widget.userPrefs),
                      ));
                },
              ),
              CupertinoDialogAction(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    });
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: cartItensWidgets,
              ),
            ),
          ),
          SizedBox(height: 118,),
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
                onPressed: () {
                  finalizarCompra();
                },
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
