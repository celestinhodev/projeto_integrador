// Packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// Components
import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';

// Constants
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

  int? _value;

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
              color: paletteBrown,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: [
                      Hero(
                        tag: nomeLivro,
                        child: Image.asset('images/livros/livro.png'),
                      ),
                      Image.asset('images/livros/livro.png'),
                      Image.asset('images/livros/livro.png'),
                      Image.asset('images/livros/livro.png'),
                    ],
                    options: CarouselOptions(
                      //Configurações do carrossel
                      height: 400,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 0.7,
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _value,
                            onChanged: (value) {
                              _value = value;
                            },
                          ),
                          Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              _value = value;
                            },
                          ),
                          Radio(
                            value: 2,
                            groupValue: _value,
                            onChanged: (value) {
                              _value = value;
                            },
                          ),
                        ],
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
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 20,
                    ),
                  ),
        
                  SizedBox(
                    height: 20,
                  ),
        
                  // Linha com Preço e Genero,
                  Row(
                    children: [
                      // Preço
                      Icon(
                        Icons.shopping_cart,
                        color: paletteWhite,
                      ),
                      Text(
                        'R\$${precoLivro}',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 20,
                        ),
                      ),
        
                      SizedBox(
                        width: 50,
                      ),
        
                      // Genero
                      Icon(
                        Icons.art_track,
                        color: paletteWhite,
                      ),
                      Text(
                        generoLivro,
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(
                    height: 10,
                  ),
        
                  Divider(
                    color: paletteWhite,
                  ),
        
                  SizedBox(
                    height: 10,
                  ),
        
                  Text(
                    'DESCRIÇÃO',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 20,
                    ),
                  ),
        
                  SizedBox(
                    height: 15,
                  ),
        
                  Text(
                    descricaoLivro,
                    maxLines: 99999,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 60,),
            
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: paletteYellow,
                    ),
                    child: Text(
                      'COMPRAR',
                      style: TextStyle(
                        color: paletteBlack,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: paletteBrown,
                    ),
                    child: Text(
                      'ADICIONAR AO CARRINHO',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.home), current: false),
        search: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.search), current: false),
        cart: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.shopping_cart), current: false),
        user: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.person), current: false),
      ),
    );
  }
}
