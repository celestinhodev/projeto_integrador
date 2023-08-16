// Packages
import 'package:flutter/material.dart';

// Components
import 'package:pi/components/book_template.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/pages/carrinho.dart';

// Constantes
import '../components/drawer.dart';
import '../components/radio_button.dart';
import '../constantes/cores.dart';

//carrossel (organizar depois)
import 'package:carousel_slider/carousel_slider.dart'; // Importe a biblioteca aqui
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:carousel_slider/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController carouselController = CarouselController();
  int _value = 0;

  List<Widget> carouselBannerItens = [];

  @override
  void initState() {
    // TODO: implement initState
    carouselBannerItens = [
      Image.asset('images/livros/livro.png'),
      Image.asset('images/logo-appbar.png'),
      Image.asset('images/livros/livro.png'),
      Image.asset('images/livros/livro.png'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Comum Component App Bar
      appBar: BookTokAppBar,

      drawer: MyDrawer(),

      backgroundColor: paletteBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Carrossel -----------------------------------------------------------------------
            Container(
              color: paletteBrown,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 45),
                    child: CarouselSlider(
                      items: carouselBannerItens,
                      carouselController: carouselController,
                      options: CarouselOptions(
                        //Configurações do carrossel
                        height: 250,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _value = index;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          carouselBannerItens.length,
                          (index) => MyRadioOption(
                            label: '',
                            groupValue: _value,
                            unselectedColor: paletteWhite,
                            selectedColor: paletteBlack,
                            value: index,
                            size: 14,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                carouselController.animateToPage(value);
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

            //Fim do Carrossel ----------------------------------------------------------------

            // Titulo lançamento
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
              child: Text(
                'Lançamentos',
                style: TextStyle(
                  fontSize: 20,
                  color: paletteWhite,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //Linha 1 -----------------------------------------------------------------------
            GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisExtent: 220),
              shrinkWrap: true,

              children: [
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: 'A Menina que Navegou ao Reino Encantado no Barco que ela Mesma Fez',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: 'A Fantastica fabrica de mamadores',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '3',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '4',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '5',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '6',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '7',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '8',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '9',),
                BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: '10',),
              ],
            ),
          ],
        ),
      ),

      //Barra de navegação ------------------------------------------------------
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.home), current: true),
        search: MyIconButtonNavigator(
            route: const Home(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: const Carrinho(),
            icon: const Icon(Icons.shopping_cart),
            current: false),
        user: MyIconButtonNavigator(
            route: const Home(),
            icon: const Icon(Icons.person),
            current: false),
      ),
    );
  }
}
