// Packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:carousel_slider/carousel_slider.dart';

// Components
import '../components/booktok_appbar.dart';
import '../components/radio_button.dart';
import '../components/navigation_bar.dart';

// Constants
import '../constantes/cores.dart';
import '../constantes/appwrite_system.dart';

// Pages
import 'Home.dart';
import 'carrinho.dart';
import 'profile.dart';
import 'search.dart';

// BookDetail Page
class BookDetailsPage extends StatefulWidget {
  models.Document documentInstance;
  models.Document? userPrefs;

  BookDetailsPage({super.key, required this.documentInstance, this.userPrefs});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  // Declarations
  // Appwrite
  AppwriteSystem appwriteSystem = AppwriteSystem();

  Map<String, String> book_data = {
    'title': '',
    'price': '',
    'description': '',
    'category': '',
    'author': '',
    'year': '',
  };
  List<String> listImagesUrl = [];

  int _value = 0;
  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];
  List<dynamic> cartItens = [];

  // Methods
  void setBookInformation() async {
    listImagesUrl = appwriteSystem.prepareUrlListFromString(
        listImageUrlString: widget.documentInstance.data['listImages']);

    setState(() {
      book_data['title'] = widget.documentInstance.data['title'];
      book_data['price'] = widget.documentInstance.data['price'];
      book_data['description'] = widget.documentInstance.data['description'];
      book_data['category'] = widget.documentInstance.data['category'];
      book_data['author'] = widget.documentInstance.data['author'];
      book_data['year'] = widget.documentInstance.data['year'].toString();

      for (String imageUrl in listImagesUrl) {
        carouselItens.add(Image.network(imageUrl));
      }
    });
  }

  void setCart() async {
    cartItens = await appwriteSystem.getCurrentCart(
        currentCartString: widget.userPrefs!.data['cartItens']);
  }

  cartItemModel() {
    return {
      "amount": 1,
      "price": book_data['price'],
      "title": book_data['title'],
      "imagePath": listImagesUrl[0]
    };
  }

  Future<void> addToCart() async {
    var inCart = false;
    for (var element in cartItens) {
      if(element['title'] == book_data['title']) {
        inCart = true;
        element['amount']++;
      }
    }
    if(inCart == false) {
      cartItens.add(cartItemModel());
    }
    await appwriteSystem.updateCart(
        newCartItens: cartItens, documentId: widget.userPrefs!.$id);

    widget.userPrefs!.data['cartItens'] = JsonEncoder().convert(cartItens);
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    setCart();
    setBookInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      backgroundColor: paletteBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey.shade700,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: carouselItens,
                    carouselController: bookCarouselController,
                    options: CarouselOptions(
                      //Configurações do carrossel
                      initialPage: 0,
                      height: 300,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _value = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          carouselItens.length,
                          (index) => MyRadioOption(
                            label: '',
                            groupValue: _value,
                            unselectedColor: paletteWhite,
                            selectedColor: paletteBlack,
                            value: index,
                            size: 16,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                bookCarouselController.animateToPage(value);
                              });
                            },
                            text: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome Livro
                  Text(
                    book_data['title']!,
                    style: const TextStyle(
                      color: paletteWhite,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Linha com Preço e Genero,
                  Row(
                    children: [
                      // Preço
                      const Icon(
                        Icons.shopping_cart,
                        color: paletteWhite,
                      ),
                      Text(
                        'R\$ ${book_data['price']}',
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    color: paletteWhite,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'DESCRIÇÃO',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    book_data['description']!,
                    maxLines: 99999,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: paletteWhite,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    color: paletteWhite,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'ESPECIFICAÇÕES',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      const Text(
                        'Categoria: ',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book_data['category']!,
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      const Text(
                        'Autor: ',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book_data['author']!,
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      const Text(
                        'Ano de lançamento: ',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book_data['year']!.toString(),
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Container(
              color: paletteYellow,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: paletteYellow,
                ),
                child: const Text(
                  'COMPRAR',
                  style: TextStyle(
                    color: paletteBlack,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: paletteBrown,
              child: TextButton(
                onPressed: () async {
                  addToCart();
                },
                style: TextButton.styleFrom(
                  backgroundColor: paletteBrown,
                ),
                child: const Text(
                  'ADICIONAR AO CARRINHO',
                  style: TextStyle(
                    color: paletteWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
          route: Home(
            userPrefs: widget.userPrefs,
          ),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
            route: SearchScreen(
              userPrefs: widget.userPrefs,
            ),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: Carrinho(
              userPrefs: widget.userPrefs,
            ),
            icon: const Icon(Icons.shopping_cart),
            current: false),
        user: MyIconButtonNavigator(
          route: Profile(
            userPrefs: widget.userPrefs,
          ),
          icon: const Icon(Icons.person),
          current: false,
        ),
      ),
    );
  }
}
