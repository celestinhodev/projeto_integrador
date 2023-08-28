// Packages
import 'dart:js_interop';

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
  String? nomeLivro;
  CreateBookPage({super.key, this.nomeLivro = 'Insira o titulo aqui...'});

  @override
  // ignore: no_logic_in_create_state
  State<CreateBookPage> createState() => _CreateBookPageState(nomeLivro: nomeLivro);
}

class _CreateBookPageState extends State<CreateBookPage> {
  _CreateBookPageState({this.nomeLivro = 'Insira o titulo aqui...'});

  AppwriteConstants appwrite_constants = AppwriteConstants();

  String? nomeLivro;
  String descricaoLivro = 'Insira a descrição do livro aqui...';
  String autorLivro = 'Author do livro aqui...';
  String precoLivro = 'Preço aqui..';
  String categoriaLivro = 'Categoria aqui...';

  int _value = 0;
  CarouselController bookCarouselController = CarouselController();
  List<Widget> carouselItens = [];
  List<XFile> listXFilesImages = [];

  TextEditingController bookTitleController = TextEditingController();
  TextEditingController bookPriceController = TextEditingController();
  TextEditingController bookCategoryController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();
  TextEditingController bookDescriptionController = TextEditingController();

  bool? deleteButtonShow;
  bool? containsPlaceHolder;
  List<String> listPath = [];

  Color textColor = Colors.grey;

  void addImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (!image.isNull) {
      if (containsPlaceHolder == true) {
        carouselItens.clear();
        containsPlaceHolder = false;
      }

      setState(() {
        listPath.add(image!.path);
        print(listPath);
        carouselItens.add(Image.network(listPath.last));

        if (carouselItens.length > 1) {
          bookCarouselController.nextPage();
          _value++;
        }
        deleteButtonShow = true;
      });
    }
  }

  void deleteImage() {
    setState(() {
      if (carouselItens.isNotEmpty) {
        carouselItens.removeAt(_value);
        listPath.removeAt(_value);
        print(listPath);
        if (_value != 0) {
          _value--;
        }
      }

      if (carouselItens.isEmpty) {
        deleteButtonShow = false;
        carouselItens.add(Image.asset('images/livros/book_placeholder.png'));
        containsPlaceHolder = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState

    setState(() {
      carouselItens = [
        Image.asset('images/livros/book_placeholder.png'),
      ];
      deleteButtonShow = false;
      containsPlaceHolder = true;
    });
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
                      viewportFraction: 1,
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
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: FloatingActionButton(
                      onPressed: addImage,
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
                            onPressed: deleteImage,
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
                    hintText: nomeLivro!,
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
                          maxWidth: 150,
                        ),
                        child: TextFieldAdmin(
                          controller: bookPriceController,
                          hintText: precoLivro,
                          keyboardType: TextInputType.number,
                          obscureText: false,
                        ),
                      ),

                      const SizedBox(
                        width: 20,
                      ),

                      // Genero
                      const Icon(
                        Icons.art_track,
                        color: paletteWhite,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
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
                onPressed: () async {
                  String title = '';
                  String author = 'a';
                  String price = '';
                  String category = '';
                  String description = '';

                  setState(() {
                    title = bookTitleController.text;
                    author = bookAuthorController.text;
                    price = bookPriceController.text;
                    category = bookCategoryController.text;
                    description = bookDescriptionController.text;
                  });

                  if (listPath.isNotEmpty && !listPath.isNull) {
                    listPath.forEach((path) {
                      listXFilesImages.add(XFile(path));
                    });
                  } else {
                    print('Você não fez upload nas imagens');
                  }

                  if (title != '' &&
                      author != '' &&
                      price != '' &&
                      category != '' &&
                      description != '' &&
                      listXFilesImages.isNotEmpty) {
                    var response = await appwrite_constants.createDocument(
                        title: title,
                        author: author,
                        price: price,
                        category: category,
                        description: description,
                        listXFiles: listXFilesImages);
                  } else {
                    print('Um dos itens está faltante');
                  }

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeAdmin(),));
                },
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
}
