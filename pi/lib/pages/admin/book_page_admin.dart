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
  String? nomeLivro;
  String? idDocument;


  // Constructor
  CreateBookPage(
      {super.key, this.nomeLivro = 'Insira o titulo aqui...', this.idDocument});

  @override
  // ignore: no_logic_in_create_state
  State<CreateBookPage> createState() =>
      _CreateBookPageState(nomeLivro: nomeLivro, idDocument: idDocument);
}

class _CreateBookPageState extends State<CreateBookPage> {
  // Declaration's
  // Book Information
  String? idDocument;
  String? nomeLivro;
  String? descricaoLivro;
  String? autorLivro;
  String? precoLivro;
  String? categoriaLivro;

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


  // Constructor
  _CreateBookPageState({
    this.nomeLivro = 'Insira o titulo aqui...',
    this.idDocument,
  });

  
  // Methods
  void addImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (containsPlaceHolder == true) {
        carouselItens.clear();
        containsPlaceHolder = false;
      }

      setState(() {
        listPath.add(image.path);
        print(listPath);
        carouselItens.add(Image.network(listPath.last));

        if (carouselItens.length > 1) {
          bookCarouselController.nextPage();
          _currentIndex++;
        }
        deleteButtonShow = true;
      });
    }
  }

  void deleteImage() {
    setState(() {
      if (carouselItens.isNotEmpty) {
        carouselItens.removeAt(_currentIndex);
        if (listPath.isNotEmpty) {
          listPath.removeAt(_currentIndex);
        } else {
          listImages[_currentIndex];
        }
        print(listPath);
        if (_currentIndex != 0) {
          _currentIndex--;
        }
      }

      if (carouselItens.isEmpty) {
        deleteButtonShow = false;
        carouselItens.add(Image.asset('images/livros/book_placeholder.png'));
        containsPlaceHolder = true;
      }
    });
  }

  getBookData(String idDocument) async {
    var response = await appwrite_constants.database.getDocument(
        databaseId: appwrite_constants.databaseId,
        collectionId: appwrite_constants.bookCollectionId,
        documentId: idDocument);

    setState(() {
      nomeLivro = response.data['title'];
      precoLivro = response.data['price'];
      categoriaLivro = response.data['category']; 
      autorLivro = response.data['author'];
      descricaoLivro = response.data['description'];

      listImages = response.data['listImages']
          .toString()
          .replaceFirst('[', '')
          .replaceFirst(']', '')
          .split(', ');

      for (var element in listImages) {
        print(element);
        carouselItens.add(Image.network(
            'https://cloud.appwrite.io/v1/storage/buckets/${appwrite_constants.bucketId}/files/${element}/view?project=${appwrite_constants.projectId}'));
      }

      deleteButtonShow = true;
      containsPlaceHolder = false;

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
                            hintText: precoLivro!,
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
                            hintText: categoriaLivro!,
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
                        hintText: autorLivro!,
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
                      hintText: descricaoLivro!,
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

                    if (listPath.isNotEmpty && listPath != null) {
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
                        listXFilesImages.isNotEmpty &&
                        idDocument == null) {
                      var response = await appwrite_constants.createDocument(
                          title: title,
                          author: author,
                          price: price,
                          category: category,
                          description: description,
                          listXFiles: listXFilesImages);
                    } else if (title != '' &&
                        author != '' &&
                        price != '' &&
                        category != '' &&
                        description != '' &&
                        listXFilesImages.isNotEmpty &&
                        idDocument != null) {
                      var response = await appwrite_constants.updateDocument(
                          title: title,
                          author: author,
                          price: price,
                          category: category,
                          description: description,
                          listXFiles: listXFilesImages,
                          idDocument: idDocument);
                    } else {
                      print('Um dos itens está faltante');
                    }

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeAdmin(),
                        ));
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
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: todo
    // TODO: implement initState

    if (idDocument == null) {
      setState(() {
        carouselItens = [
          Image.asset('images/livros/book_placeholder.png'),
        ];
        deleteButtonShow = false;
        containsPlaceHolder = true;
      });
    } else {
      getBookData(idDocument!);
    }
  }

  // Layout
  @override
  Widget build(BuildContext context) {
    return appLayout;
  }
}
