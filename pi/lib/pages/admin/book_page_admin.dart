// Packages

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Components
import '../../components/booktok_appbar.dart';
import '../../components/radio_button.dart';
import '../../components/textInputAdmin.dart';
import '../../constantes/cores.dart';

// Constants
import '../../constantes/appwrite_constants.dart';
import 'home_admin.dart';

// BookDetail Page
class CreateBookPage extends StatefulWidget {
  // Declatarion's
  String? idDocument;

  // Constructor
  CreateBookPage({super.key, this.idDocument});

  @override
  // ignore: no_logic_in_create_state
  State<CreateBookPage> createState() => _CreateBookPageState();
}

class _CreateBookPageState extends State<CreateBookPage> {
  // Declaration's
  // Book Information
  String? idDocument;
  String nomeLivro;
  String descricaoLivro;
  String autorLivro;
  String precoLivro;
  String categoriaLivro;

  // Appwrite
  AppwriteConstants appwrite_constants = AppwriteConstants();

  // Carousel
  int _currentIndex = 0;
  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];

  // TextEditingController's
  TextEditingController bookTitleController = TextEditingController();
  TextEditingController bookPriceController = TextEditingController();
  TextEditingController bookCategoryController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController bookDescriptionController = TextEditingController();

  // Bools
  bool? deleteButtonShow;
  bool? containsPlaceHolder;

  // Lists
  List<XFile> listXFilesImages = [];
  List<String> listPath = [];
  List<String> listImages = [];

  // Colors
  Color textColor = Colors.grey;

  // appLayout
  Widget appLayout = Scaffold(
    backgroundColor: paletteBlack,
    body: Center(
      child: Image.asset('images/loading.gif'),
    ),
  );

  _CreateBookPageState({
    this.nomeLivro = 'Titulo...',
    this.precoLivro = 'Preço...',
    this.categoriaLivro = 'Categoria...',
    this.autorLivro = 'Autor...',
    this.descricaoLivro = 'Descrição...',
  });

  // Methods
  placeholderImage() {
    setState(() {
      carouselItens.add(Image.asset('images/livros/book_placeholder.png'));

      deleteButtonShow = false;
      containsPlaceHolder = true;
    });
  }

  void setBookData({required String idDocument}) async {
    var document = await appwrite_constants.getDocument(documentId: idDocument);
    var data = document!.data;

    nomeLivro = data['title'];
    descricaoLivro = data['description'];
    autorLivro = data['author'];
    precoLivro = data['price'];
    categoriaLivro = data['category'];

    var listImages = appwrite_constants.prepareList(listImagesString: data['listImages']);
    var listUrlImages = appwrite_constants.imageUrlList(listImages: listImages);

    for (var url in listUrlImages) {
      carouselItens.add(Image.network(url));
    }

    setState(() {
      setLayout();
    });
  }

  void setLayout() {
    appLayout = Scaffold(
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
                          _currentIndex = index;
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
                            groupValue: _currentIndex,
                            unselectedColor: paletteWhite,
                            selectedColor: paletteBlack,
                            value: index,
                            size: 16,
                            onChanged: (value) {
                              setState(() {
                                _currentIndex = value!;
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
                    bottom: 20,
                    left: 20,
                    child: FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: paletteYellow,
                      child: Icon(
                        Icons.add_to_photos,
                        color: paletteBlack,
                      ),
                    ),
                  ),
                  deleteButtonShow == true
                      ? Positioned(
                          bottom: 20,
                          right: 20,
                          child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: paletteBlack,
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
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
                  TextFieldAdmin(
                    controller: bookTitleController,
                    hintText: nomeLivro,
                    keyboardType: TextInputType.text,
                    obscureText: false,
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
                        'R\$',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 100,
                        ),
                        child: TextFieldAdmin(
                          controller: bookPriceController,
                          hintText: precoLivro,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                        ),
                      ),

                      Spacer(),

                      // Genero
                      const Icon(
                        Icons.art_track,
                        color: paletteWhite,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 180,
                        ),
                        child: TextFieldAdmin(
                          controller: bookCategoryController,
                          hintText: categoriaLivro,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 150,
                    ),
                    child: TextFieldAdmin(
                      controller: bookAuthorController,
                      hintText: autorLivro,
                      keyboardType: TextInputType.text,
                      obscureText: false,
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
                    'DESCRIÇÃO',
                    style: TextStyle(
                      color: paletteWhite,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  TextFieldAdmin(
                    controller: bookDescriptionController,
                    hintText: descricaoLivro,
                    keyboardType: TextInputType.text,
                    obscureText: false,
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
                onPressed: () async {},
                style: TextButton.styleFrom(
                  backgroundColor: paletteYellow,
                ),
                child: const Text(
                  'UPLOAD',
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

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState

    idDocument = widget.idDocument;
    print(idDocument);

    if (idDocument == null) {
      deleteButtonShow = false;
      containsPlaceHolder = true;
      placeholderImage();
      setLayout();
    } else {
      deleteButtonShow = true;
      containsPlaceHolder = false;
      setBookData(idDocument: idDocument!);
    }
  }

  // Layout
  @override
  Widget build(BuildContext context) {
    return appLayout;
  }
}
