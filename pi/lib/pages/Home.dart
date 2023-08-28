// Packages
import 'package:flutter/material.dart';


// Components
import 'package:pi/components/book_template.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/pages/carrinho.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

// Constantes
import '../components/drawer.dart';
import '../components/radio_button.dart';
import '../constantes/cores.dart';

//carrossel (organizar depois)
import 'package:carousel_slider/carousel_slider.dart'; // Importe a biblioteca aqui

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
    super.initState();
    // ignore: todo
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

      drawer: const MyDrawer(),

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
                        initialPage:
                            1, //escolhe a imagem q vai começar (estetic)
                        height: 220,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                        pauseAutoPlayOnTouch:
                            true, //pausa a rolagem do carrossel quando clicado (não está funcionando :/)
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _value = index;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
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
              padding: EdgeInsets.fromLTRB(22, 20, 0, 0),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisExtent: 225,
                ),
                shrinkWrap: true,
                children: [
                ],
              ),
            ),
          ],
        ),
      ),

      //Barra de navegação ------------------------------------------------------
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.home), current: true),
        search: MyIconButtonNavigator(
            route: const SearchScreen(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: const Carrinho(),
            icon: const Icon(Icons.shopping_cart),
            current: false),
        user: MyIconButtonNavigator(
            route: const Profile(),
            icon: const Icon(Icons.person),
            current: false),
      ),
    );
  }
}
