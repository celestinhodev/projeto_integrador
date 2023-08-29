// Packages
import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pi/pages/carrinho.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

// Components
import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';

// Constants
import '../components/radio_button.dart';
import '../constantes/cores.dart';
import 'home.dart';

// BookDetail Page
class BookDetailsPage extends StatefulWidget {
  String nomeLivro;

  BookDetailsPage({super.key, required this.nomeLivro});

  @override
  State<BookDetailsPage> createState() =>
      _BookDetailsPageState(nomeLivro: nomeLivro);
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  String nomeLivro;

  _BookDetailsPageState({required this.nomeLivro});

  String descricaoLivro =
      'bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ';
  String precoLivro = '99,99';
  String generoLivro = 'TERROR';

  int _value = 0;
  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    carouselItens = [
      Image.asset('images/livros/livro.png'),
      Image.asset('images/livros/livro.png'),
      Image.asset('images/livros/livro.png'),
      Image.asset('images/livros/livro.png'),
    ];
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
                      viewportFraction: 1,
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
                    nomeLivro,
                    style: const TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
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
                        'R\$${precoLivro}',
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(
                        width: 50,
                      ),

                      // Genero
                      const Icon(
                        Icons.art_track,
                        color: paletteWhite,
                      ),
                      Text(
                        generoLivro,
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 18,
                        ),
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
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    descricaoLivro,
                    maxLines: 99999,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: paletteWhite,
                      fontSize: 14,
                    ),
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
                onPressed: () {},
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
            route: const Home(), icon: const Icon(Icons.home), current: false),
        search: MyIconButtonNavigator(
            route: const SearchScreen(), icon: const Icon(Icons.search), current: false),
        cart: MyIconButtonNavigator(
            route: const Carrinho(), icon: const Icon(Icons.shopping_cart), current: false),
        user: MyIconButtonNavigator(
            route: const Profile(), icon: const Icon(Icons.person), current: false),
      ),
    );
  }
}
