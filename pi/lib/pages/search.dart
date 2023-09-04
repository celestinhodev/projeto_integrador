//Packages
import 'package:flutter/material.dart';

//Constantes (corrigir a separação aqui)
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/cores.dart';

//Componentes
import '../components/search_book_template.dart';
import '/pages/home.dart';
import '/pages/carrinho.dart';
import '/pages/profile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      body: Container(
        color: paletteBlack,
        child: Column(
          children: [
            // Área da pesquisa
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: paletteGrey,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Lógica de pesquisa aqui
                    },
                    icon: const Icon(Icons.search),
                  ),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Buscar por título, autor',
                        hintStyle: TextStyle(color: paletteWhite),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                SearchBookTemplate(title: 'O Iluminado', imagePath: '', documentId: '',),
              ],
            ),
          ],
        ),
      ),
      //Barra de navegação ----------------------------------------------------------------
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
          route: Home(),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
          route: const SearchScreen(),
          icon: const Icon(Icons.search),
          current: true,
        ),
        cart: MyIconButtonNavigator(
          route: const Carrinho(),
          icon: const Icon(Icons.shopping_cart),
          current: false,
        ),
        user: MyIconButtonNavigator(
          route: const Profile(),
          icon: const Icon(Icons.person),
          current: false,
        ),
      ),
    );
  }
}
