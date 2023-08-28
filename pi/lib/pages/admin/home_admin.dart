// Packages
import 'package:appwrite/models.dart' as models;

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

// Components
import 'package:pi/components/book_template.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/appwrite_constants.dart';
import 'package:pi/pages/admin/book_page_admin.dart';


// Constantes
import '../../constantes/cores.dart';

//carrossel (organizar depois)
import 'package:carousel_slider/carousel_slider.dart'; // Importe a biblioteca aqui

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  AppwriteConstants appwrite_constants = AppwriteConstants();

  CarouselController carouselController = CarouselController();
  int _value = 0;

  List<Widget> books = [];

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState

    getBooks();
  }

  void getBooks() async {
    List<Widget> bookResponse = [];
    try {
      var response = await appwrite_constants.getDocuments();

        for (var element in response!.documents) {

          String title = element.data['title'];
          String fileId = element.data['listImages'].toString().replaceAll('[', '').replaceAll(']', '').split(',')[0];

          bookResponse.add(BookTemplate(
              caminhoImagem: 'images/livros/livro.png',
              nomeLivro: title,
              admin: true));
          
          await getImage(fileId);
        }
      
      
      setState(() {
        books = bookResponse;
      });
      print('getBooks() executado!!');
    } catch (e) {
      print('Erro getBooks(): ' + e.toString());
    }
  }

  getImage(fileId) async {
    var response = await appwrite_constants.storage.getFile(bucketId: appwrite_constants.bucketId, fileId: fileId);
    print(response.);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Comum Component App Bar
      appBar: BookTokAppBar,

      backgroundColor: paletteBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Carrossel -----------------------------------------------------------------------
              Text(
                'Livros',
                style: TextStyle(
                  fontSize: 20,
                  color: paletteWhite,
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
                  children: books,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateBookPage(),
            ),
          );
        },
        child: Icon(Icons.add_box),
      ),

      //Barra de navegação ------------------------------------------------------
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
    );
  }
}
