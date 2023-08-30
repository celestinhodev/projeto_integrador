// Packages
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pi/constantes/appwrite_constants.dart';

// Components
import '../../components/booktok_appbar.dart';

// Constants
import '../../components/radio_button.dart';
import '../../constantes/book_class.dart';
import '../../constantes/cores.dart';

// BookDetail Page
class BookCreationPage extends StatefulWidget {
  String? documentId;

  BookCreationPage({super.key, required this.documentId});

  @override
  State<BookCreationPage> createState() => _BookCreationPageState();
}

class _BookCreationPageState extends State<BookCreationPage> {
  // Declaration's
  // Appwrite
  AppwriteConstants appwrite_constants = AppwriteConstants();

  Map book_data = {
    'title': 'Titulo Placeholder',
    'price': 'Preço Placeholder',
    'category': 'Categoria Placeholder',
    'author': 'Autor Placeholder',
    'description': 'Descrição Placeholder',
  };

  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];
  List<Widget> carouselRadioButtons = [];
  int _groupValue = 0;

  Widget loadingScreen = Scaffold(
    backgroundColor: paletteBlack,
    body: Center(
      child: Image.asset(
        'images/loading.gif',
        height: 80,
        fit: BoxFit.contain,
      ),
    ),
  );

  late Widget appLayout = Scaffold(
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
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _groupValue = index;
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
                      children: carouselRadioButtons,
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
                  book_data['title'],
                  style: const TextStyle(
                    color: paletteWhite,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(
                  height: 20,
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
                      'R\$${book_data['price']}',
                      style: const TextStyle(
                        color: paletteWhite,
                        fontSize: 18,
                      ),
                    ),

                    Spacer(),

                    // Genero
                    const Icon(
                      Icons.art_track,
                      color: paletteWhite,
                    ),
                    Text(
                      book_data['category'],
                      style: const TextStyle(
                        color: paletteWhite,
                        fontSize: 18,
                      ),
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
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                Text(
                  book_data['description'],
                  maxLines: 99999,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: paletteWhite,
                    fontSize: 14,
                  ),
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
  );

  Widget currentLayout = SizedBox();

  // Methods
  void changeCarouselItem(value) {
    setState(() {
      _groupValue = value!;
      bookCarouselController.animateToPage(value);
    });
  }

  getBookDataFromDB({required String documentId}) async {
    try {
      var document =
          await appwrite_constants.getDocument(documentId: documentId);

      Map database_book_info = {};

      database_book_info['title'] = document!.data['title'];
      database_book_info['price'] = document.data['price'];
      database_book_info['category'] = document.data['category'];
      database_book_info['author'] = document.data['author'];
      database_book_info['description'] = document.data['description'];
      database_book_info['listImagesURL'] = appwrite_constants.getImageUrlList(
          listImages: appwrite_constants.prepareList(
              listImagesString: document.data['listImages']));

      setBookData(databaseBookInfo: database_book_info);
    } catch (e) {
      print('Error in getBookDataFromDB');
    }
    ;
  }

  setBookData({required databaseBookInfo}) async {
    int count = 0;
    book_data = databaseBookInfo;

    List<Widget> new_carousel_itens = [];

    for (var element in book_data['listImagesURL']) {
      Widget radioButton = MyRadioOption(
        label: '',
        groupValue: _groupValue,
        unselectedColor: paletteWhite,
        selectedColor: paletteBlack,
        value: count,
        size: 16,
        onChanged: (value) => changeCarouselItem(value),
        text: '',
      );

      carouselRadioButtons.add(radioButton);

      var image = Image.network(element);
      new_carousel_itens.add(image);

      count++;
    }

    setState(() {
      carouselItens = new_carousel_itens;
      currentLayout = appLayout;
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.documentId != null) {
      currentLayout = loadingScreen;
      getBookDataFromDB(documentId: widget.documentId!);
    } else {
      carouselItens = [Image.asset('images/livros/book_placeholder.png')];
      currentLayout = appLayout;
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentLayout;
  }
}
