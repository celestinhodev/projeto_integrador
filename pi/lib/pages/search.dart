//Packages
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

//Constantes (corrigir a separação aqui)
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/appwrite_constants.dart';
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
  // Declaration's
  AppwriteConstants appwrite_constants = AppwriteConstants();

  TextEditingController searchController = TextEditingController();

  String searchText = '';
  List<Widget> listResults = [];

  // Methods

  void searchAction(String value) async {
    setState(() {
      searchText = value;
    });

    models.DocumentList? listBooks =
        await appwrite_constants.searchBooks(searchText: searchText);

    if (listBooks == null || listBooks.total == 0) {
      setState(() {
        listResults = [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Livro não encontrado',
              style: TextStyle(
                color: paletteWhite,
                fontSize: 18,
              ),
            ),
          ),
        ];
      });
    } else {
      listResults = [];
      for (var element in listBooks.documents) {
        var listImages = appwrite_constants.prepareList(
            listImagesString: element.data['listImages']);

        setState(() {
          listResults.add(
            SearchBookTemplate(
              documentId: element.$id,
              title: element.data['title'],
              imagePath: listImages[0],
            ),
          );
        });
      }
    }
  }

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
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                      onChanged: (value) {
                        searchAction(value);
                      },
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
            searchText == ''
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'Pesquire alguma coisa',
                        style: TextStyle(
                          color: paletteGrey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: listResults,
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
