// Packages

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pi/constantes/appwrite_constants.dart';

// Components
import '../../components/booktok_appbar.dart';

// Constants
import '../../components/radio_button.dart';
import '../../components/textInputAdmin.dart';
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

  List<XFile> listXFileImages = [];

  // TextEditingControllers
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController categoryEditingController = TextEditingController();
  TextEditingController authorEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();

  // Carousel
  CarouselController bookCarouselController = CarouselController();
  late List<Widget> carouselItens = [];
  int _groupValue = 0;

  List<XFile> listXFiles = [];
  List<XFile> listXFilesForUpload = [];
  List<String> imagePath = [];
  List<String> deletedImages = [];

  bool dataIsLoaded = false;

  // Control Flag
  bool showDeleteImageButton = false;
  bool containPlaceholderImage = false;

  // Methods
  void setCarouselToPlaceholder() {
    carouselItens = [
      Image.asset('images/livros/book_placeholder.png'),
    ];
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

      book_data['title'] = document!.data['title'];
      book_data['price'] = document.data['price'];
      book_data['category'] = document.data['category'];
      book_data['author'] = document.data['author'];
      book_data['description'] = document.data['description'];

      setState(() {
        book_data['title'] = document.data['title'];
        book_data['price'] = document.data['price'];
        book_data['category'] = document.data['category'];
        book_data['author'] = document.data['author'];
        book_data['description'] = document.data['description'];

        imagePath = appwrite_constants.prepareList(
            listImagesString: document.data['listImages']);

        for (var element in imagePath) {
          carouselItens.add(Image.network(element));
          listXFileImages.add(XFile(''));
        }

        dataIsLoaded = true;
      });
    } catch (e) {
      print('Error in getBookDataFromDB');
    }
  }

  void deleteImageFromCarousel() {
    try {
      setState(() {
        // ignore: prefer_is_empty
        if (carouselItens.length == 1 && containPlaceholderImage == false) {
          listXFileImages = [];

          try {
            deletedImages.add(imagePath[0]);
          } catch (e) {}

          imagePath = [];

          setCarouselToPlaceholder();

          containPlaceholderImage = true;
          showDeleteImageButton = false;
        } else if (carouselItens.length > 1) {
          listXFileImages.removeAt(_groupValue);

          try {
            deletedImages.add(imagePath[_groupValue]);
          } catch (e) {}

          imagePath.removeAt(_groupValue);

          carouselItens.removeAt(_groupValue);
        }

        if (_groupValue != 0) {
          _groupValue--;
        }

        print(deletedImages);
      });
    } catch (e) {
      print(e);
    }
  }

  void addImageToCarousel() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (containPlaceholderImage == true) {
        carouselItens = [];
        carouselItens.add(Image.network(image!.path));
        imagePath.add('');

        listXFileImages.add(image);

        showDeleteImageButton = true;
        containPlaceholderImage = false;
      } else if (containPlaceholderImage == false) {
        carouselItens.add(Image.network(image!.path));

        imagePath.add('');

        listXFileImages.add(image);
      }
    });

    print(listXFileImages);
  }

  void getInfoFromTextfield() {
    book_data['title'] = titleEditingController.text;
    book_data['price'] = priceEditingController.text;
    book_data['category'] = categoryEditingController.text;
    book_data['author'] = authorEditingController.text;
    book_data['description'] = descriptionEditingController.text;
  }

  void setImagesToUpload() {
    setState(() {
      for (var element in listXFileImages) {
        if (element.path != '') {
          listXFilesForUpload.add(element);
        }
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
      dataIsLoaded = true;
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
                              onPressed: dataIsLoaded
                                  ? deleteImageFromCarousel
                                  : () {},
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
                  // Nome Livro,
                  dataIsLoaded == true
                      ? TextFieldAdmin(
                          controller: titleEditingController,
                          hintText: book_data['title'],
                          keyboardType: TextInputType.text,
                          obscureText: false,
                        )
                      : SizedBox(),

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
                        style: const TextStyle(
                          color: paletteWhite,
                          fontSize: 18,
                        ),
                      ),

                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 80,
                        ),
                        child: dataIsLoaded == true
                            ? TextFieldAdmin(
                                controller: priceEditingController,
                                hintText: book_data['price'],
                                keyboardType: TextInputType.text,
                                obscureText: false,
                              )
                            : SizedBox(),
                      ),

                      Spacer(),

                      // Genero
                      const Icon(
                        Icons.art_track,
                        color: paletteWhite,
                      ),

                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 150,
                        ),
                        child: dataIsLoaded == true
                            ? TextFieldAdmin(
                                controller: categoryEditingController,
                                hintText: book_data['category'],
                                keyboardType: TextInputType.text,
                                obscureText: false,
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 200,
                    ),
                    child: dataIsLoaded == true
                        ? TextFieldAdmin(
                            controller: authorEditingController,
                            hintText: book_data['author'],
                            keyboardType: TextInputType.text,
                            obscureText: false,
                          )
                        : SizedBox(),
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

                  dataIsLoaded == true
                      ? TextFieldAdmin(
                          controller: descriptionEditingController,
                          hintText: book_data['description'],
                          keyboardType: TextInputType.text,
                          obscureText: false,
                        )
                      : SizedBox(),
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
              padding: EdgeInsets.all(8),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    getInfoFromTextfield();
                  });

                  setImagesToUpload();

                  if (widget.documentId == null) {
                    appwrite_constants.createDocument(
                      title: book_data['title'],
                      author: book_data['author'],
                      price: book_data['price'],
                      category: book_data['category'],
                      description: book_data['description'],
                      listXFileImages: listXFilesForUpload,
                    );
                  } else {
                    appwrite_constants.updateDocument(
                      idDocument: widget.documentId,
                      title: book_data['title'],
                      author: book_data['author'],
                      price: book_data['price'],
                      category: book_data['category'],
                      description: book_data['description'],
                      listXFileImages: listXFilesForUpload,
                      listCurrentImages: imagePath,
                      deletedImages: deletedImages,
                    );
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: paletteYellow,
                    textStyle: TextStyle(
                      fontSize: 18,
                    )),
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
