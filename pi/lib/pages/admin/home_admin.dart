// Packages
import 'package:appwrite/models.dart' as models;
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Components
import 'package:pi/components/book_template.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/constantes/appwrite_system.dart';
import 'package:pi/pages/admin/book_page_admin.dart';

// Constantes
import '../../constantes/cores.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  // Declaration's
  // Appwrite
  AppwriteSystem appwriteSystem = AppwriteSystem();

  // Carousel
  CarouselController carouselController = CarouselController();

  // Books
  List<Widget> books = [];

  // Constructor

  // Methods
  void getBooks() async {
    List<Widget> booksPrepare = [];
    Widget finalWidget;
    models.DocumentList? listDocuments = await appwriteSystem.listDocuments(searchText: '', atributes: 'title');

    if (listDocuments!.total != 0) {
      for (models.Document documentInstance in listDocuments.documents) {
        String nomeLivro = documentInstance.data['title'];
        List<String> listImagesUrl = appwriteSystem.prepareUrlListFromString(listImageUrlString: documentInstance.data['listImages']);

        finalWidget = BookTemplate(
          caminhoImagem: listImagesUrl[0],
          nomeLivro: nomeLivro,
          documentInstance: documentInstance,
          admin: true,
        );
        booksPrepare.add(finalWidget);
      }
    }

    setState(() {
      books = booksPrepare;
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState

    getBooks();
  }

  // Layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: bookTokAppBar,

      // Background Color
      backgroundColor: paletteBlack,

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Carrossel -----------------------------------------------------------------------
              const Text(
                'Livros',
                style: TextStyle(
                  fontSize: 20,
                  color: paletteWhite,
                ),
              ),

              const SizedBox(height: 20),

              // Grid Itens
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 225,
                  ),
                  shrinkWrap: true,
                  children: books,
                ),
              ),
            ],
          ),
        ),
      ),

      // Add Book Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookCreationPage(documentInstance: null),
            ),
          );
        },
        child: const Icon(Icons.add_box),
      ),

      // Barra de Navegação
      /*
              bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: const HomeAdmin(),
            icon: const Icon(Icons.home),
            current: true),
        search: MyIconButtonNavigator(
            route: null, icon: const Icon(Icons.search), current: false),
        cart: MyIconButtonNavigator(
            route: null, icon: const Icon(Icons.shopping_cart), current: false),
        user: MyIconButtonNavigator(
            route: null, icon: const Icon(Icons.person), current: false),
      ),
      */
    );
  }
}
