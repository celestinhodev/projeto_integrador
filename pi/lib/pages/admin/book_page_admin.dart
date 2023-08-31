// Packages

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    'title': 'Titulo',
    'price': 'Preço',
    'category': 'Categoria',
    'author': 'Autor',
    'description': 'Descrição',
  };

  // Carousel
  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];
  int _groupValue = 0;

  List<XFile> listXFiles = [];

  // Control Flag
  bool showDeleteImageButton = false;
  bool containPlaceholderImage = false;

  // Methods
  void setCarouselToPlaceholder() {
    setState(() {
      carouselItens = [
        Image.asset('images/livros/book_placeholder.png'),
      ];
      containPlaceholderImage == true;
    });
  }

  void changeCarouselItem(value) {
    setState(() {
      _groupValue = value!;
      print(_groupValue);
      bookCarouselController.animateToPage(value);
    });
  }

  void getBookDataFromDB({required String documentId}) async {
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
  }

  void setBookData({required databaseBookInfo}) async {
    book_data = databaseBookInfo;

    List<Widget> new_carousel_itens = [];

    for (var element in book_data['listImagesURL']) {
      var image = Image.network(element);
      new_carousel_itens.add(image);
    }

    setState(() {
      carouselItens = new_carousel_itens;
    });
  }

  void deleteImageFromCarousel() {
    setState(() {
      // ignore: prefer_is_empty
      if (carouselItens.length == 1 && containPlaceholderImage == false) {
        setCarouselToPlaceholder();
        showDeleteImageButton = false;
      } else if (carouselItens.length > 1) {
        carouselItens.removeAt(_groupValue);
      }

      if (_groupValue != 0) {
        _groupValue--;
      }
    });
  }

  void addImageToCarousel() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (containPlaceholderImage == true) {
        carouselItens.clear();
        carouselItens.add(Image.network(image!.path));
        showDeleteImageButton = true;
        containPlaceholderImage = false;
      } else {
        carouselItens.add(Image.network(image!.path));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    if (widget.documentId != null) {
      getBookDataFromDB(documentId: widget.documentId!);
      showDeleteImageButton = true;
      containPlaceholderImage = false;
    } else {
      setCarouselToPlaceholder();
      showDeleteImageButton = false;
      containPlaceholderImage = true;
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
                      viewportFraction: 0.9,
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
                        children: List.generate(
                          carouselItens.length,
                          (index) => MyRadioOption(
                            label: '',
                            groupValue: _groupValue,
                            unselectedColor: paletteWhite,
                            selectedColor: paletteBlack,
                            value: index,
                            size: 16,
                            onChanged: (value) {
                              setState(() {
                                _groupValue = value!;
                                bookCarouselController.animateToPage(value);
                              });
                            },
                            text: '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: paletteYellow,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: IconButton(
                        onPressed: addImageToCarousel,
                        icon: Icon(
                          Icons.add,
                          color: paletteBlack,
                        ),
                      ),
                    ),
                  ),
                  showDeleteImageButton == true
                      ? Positioned(
                          bottom: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              color: paletteBlack,
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: IconButton(
                              onPressed: deleteImageFromCarousel,
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
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
                onPressed: () {
                  appwrite_constants.createDocument(
                    title: book_data['title'],
                    author: book_data['author'],
                    price: book_data['price'],
                    category: book_data['category'],
                    description: book_data['description'],
                    listXFiles: listXFiles,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: paletteYellow,
                ),
                child: const Text(
                  'Create Book',
                  style: TextStyle(
                    color: paletteBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
