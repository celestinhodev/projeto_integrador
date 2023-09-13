//Packages
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

//Constantes (corrigir a separação aqui)
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/drawer.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/appwrite_system.dart';
import 'package:pi/constantes/cores.dart';

//Componentes
import '../components/search_book_template.dart';
import 'Home.dart';
import '/pages/carrinho.dart';
import '/pages/profile.dart';

class SearchScreen extends StatefulWidget {
  models.Document? userPrefs;
  String? textSearch;
  SearchScreen({super.key, this.userPrefs, this.textSearch});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // Declaration's
  AppwriteSystem appwriteSystem = AppwriteSystem();

  TextEditingController searchController = TextEditingController();
  late TextEditingController searchControllerCustom = TextEditingController(text: widget.textSearch);

  String searchText = '';
  List<Widget> listResults = [];

  // Methods
  void searchAction(String value, [String searchAtribute = 'title']) async {
    setState(() {
      searchText = value;
    });

    models.DocumentList? listBooks =
        await appwriteSystem.listDocuments(searchText: searchText, atributes: searchAtribute);

    if (listBooks == null || listBooks.total == 0) {
      setState(() {
        listResults = [
          const Padding(
            padding: EdgeInsets.all(32.0),
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
      for (models.Document documentInstance in listBooks.documents) {
        String bookImageUrl = (appwriteSystem.prepareUrlListFromString(
            listImageUrlString: documentInstance.data['listImages']))[0];

        String bookTitle = documentInstance.data['title'];

        setState(() {
          listResults.add(
            SearchBookTemplate(
              title: bookTitle,
              imagePath: bookImageUrl,
              documentInstance: documentInstance,
              userPrefs: widget.userPrefs,
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    appwriteSystem.updateCart(
        newCartItens: JsonDecoder().convert(widget.userPrefs!.data['cartItens']), documentId: widget.userPrefs!.$id);
    if(widget.textSearch != null) {
      setState(() {
        searchController.text = widget.textSearch!;
        searchAction(widget.textSearch!, 'category');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      drawer: MyDrawer(userPrefs: widget.userPrefs,),
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
                      style: const TextStyle(
                        color: paletteWhite,
                      ),
                      onChanged: (value) {
                        searchAction(value);
                      },
                      controller: searchController,
                      decoration: const InputDecoration(
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
                ? const Center(
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
          route: Home(
            userPrefs: widget.userPrefs,
          ),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
          route: null,
          icon: const Icon(Icons.search),
          current: true,
        ),
        cart: MyIconButtonNavigator(
          route: Carrinho(
            userPrefs: widget.userPrefs,
          ),
          icon: const Icon(Icons.shopping_cart),
          current: false,
        ),
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
