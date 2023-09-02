// Packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pi/constantes/appwrite_constants.dart';
import 'package:pi/pages/carrinho.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

// Components
import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';

// Constants
import '../components/radio_button.dart';
import '../constantes/cores.dart';
import 'home.dart';

// BookDetail Page
class BookDetailsPage extends StatefulWidget {
  String? documentId;

  BookDetailsPage({super.key, required this.documentId});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  // Declarations
  // Appwrite
  AppwriteConstants appwrite_constants = AppwriteConstants();

  Map<String, String> book_data = {
    'title': '',
    'price': '',
    'description': '',
    'category': '',
    'author': '',
    'year': '',
  };

  int _value = 0;
  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];

  // Methods
  void getBookDataFromDB() async {
    var document =
        await appwrite_constants.getDocument(documentId: widget.documentId!);

    List<String> listImages = appwrite_constants.prepareList(
        listImagesString: document!.data['listImages']);

    setState(() {
      book_data['title'] = document.data['title'];
      book_data['price'] = document.data['price'];
      book_data['description'] = document.data['description'];
      book_data['category'] = document.data['category'];
      book_data['author'] = document.data['author'];
      book_data['year'] = document.data['year'];

      for (var element in listImages) {
        carouselItens.add(Container(
          child: Image.network(element),
        ));
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    if (widget.documentId != null) {
      getBookDataFromDB();
    } else {
      carouselItens = [
        Image.asset('images/livros/livro.png'),
        Image.asset('images/livros/livro.png'),
        Image.asset('images/livros/livro.png'),
        Image.asset('images/livros/livro.png'),
      ];
    }
  }

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
              color: Colors.grey.shade700,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: carouselItens,
                    carouselController: bookCarouselController,
                    options: CarouselOptions(
                      //Configurações do carrossel
                      initialPage: 0,
                      height: 300,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.vertical,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _value = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    right: 30,
                    child: Container(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          carouselItens.length,
                          (index) => MyRadioOption(
                            label: '',
                            groupValue: _value,
                            unselectedColor: paletteWhite,
                            selectedColor: paletteBlack,
                            value: index,
                            size: 16,
                            onChanged: (value) {
                              setState(() {
                                _value = value!;
                                bookCarouselController.animateToPage(value);
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
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome Livro
                  Text(
                    book_data['title']!,
                    style: const TextStyle(
                      color: paletteWhite,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // Linha com Preço e Genero,
                  Row(
                    children: [
                      // Preço
                      const Icon(
                        Icons.shopping_cart,
                        color: paletteWhite,
                      ),
                      Text(
                        'R\$ ${book_data['price']}',
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    color: paletteWhite,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'DESCRIÇÃO',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    book_data['description']!,
                    maxLines: 99999,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: paletteWhite,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    color: paletteWhite,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    'ESPECIFICAÇÕES',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      const Text(
                        'Categoria: ',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book_data['category']!,
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      const Text(
                        'Autor: ',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book_data['author']!,
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      const Text(
                        'Ano de lançamento: ',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        book_data['year']!,
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Container(
              color: paletteYellow,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: paletteYellow,
                ),
                child: const Text(
                  'COMPRAR',
                  style: TextStyle(
                    color: paletteBlack,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: paletteBrown,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: paletteBrown,
                ),
                child: const Text(
                  'ADICIONAR AO CARRINHO',
                  style: TextStyle(
                    color: paletteWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: const Home(), icon: const Icon(Icons.home), current: false),
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
