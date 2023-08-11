// Packages
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      backgroundColor: paletteBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Hero(
              tag: nomeLivro, 
              child: Image.asset('images/livros/livro.png'),
            ),
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
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

                SizedBox(height: 20,),
          
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

                SizedBox(height: 10,),

                Divider(
                  color: paletteWhite,
                ),

                SizedBox(height: 10,),
          
                Text(
                  'DESCRIÇÃO',
                  style: TextStyle(
                    color: paletteWhite,
                    fontSize: 20,
                  ),
                ),

                SizedBox(height: 15,),
          
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

          Spacer(),

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
