// Packages
import 'package:flutter/material.dart';

// Components
import 'package:pi/components/book_template.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';

// Constantes
import '../components/drawer.dart';
import '../constantes/cores.dart';

//carrossel (organizar depois)
//import 'package:carousel_slider/carousel_slider.dart';  // Importe a biblioteca aqui


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Lançamentos',
                style: TextStyle(
                  fontSize: 20,
                  color: paletteWhite,
                ),
              ),
            ),

            //Carrossel -----------------------------------------------------------------------
    /*CarouselSlider(
        options: CarouselOptions(
          // Configurações do carrossel
          height: 200,
          enlargeCenterPage: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
        ),
        items: [
          // Itens do carrossel
          _buildBookTemplate('Título 1'),
          _buildBookTemplate('Título 2'),
          _buildBookTemplate('Título 3'),
          // ...adicionar mais itens conforme necessário
        ],
      ),
    ],*/


            //Fim do Carrossel ----------------------------------------------------------------

            const SizedBox(height: 20),

            //Linha 1 -----------------------------------------------------------------------
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro: 'O Gato que Amava Livros'
                  ),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                  ),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                  ),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'
                  ),
                ],
              ),
            ),

            //Linha 2 -------------------------------------------------------------------------------------------------

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro: 'O Gato que Amava Livros'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'O Gato que Amava Livros 2'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'O Gato que Amava Livros, O Retorno do Gato'),
                ],
              ),
            ),

            //Linha 3 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro: 'O Gato que Amava Livros'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                ],
              ),
            ),

            //Linha 4 ----------------------------------------------------------------------------------------------------------------------------------------------
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro: 'O Gato que Amava Livros'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                ],
              ),
            ),

            //Linha 5 ---------------------------------------------------------------------------------------------------------------------------------------------

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro: 'O Gato que Amava Livros'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
                  BookTemplate(
                      caminhoImagem: 'images/livros/livro.png',
                      nomeLivro:
                          'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
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
            route: const Home(), icon: const Icon(Icons.search), current: false),
        cart: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.shopping_cart), current: false),
        user: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.person), current: false),
      ),
    );
  }
}


