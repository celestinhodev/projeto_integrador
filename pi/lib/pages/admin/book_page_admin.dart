// Packages
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pi/constantes/appwrite_system.dart';
import 'package:pi/pages/admin/home_admin.dart';

// Components
import '../../components/booktok_appbar.dart';

// Constants
import '../../components/radio_button.dart';
import '../../components/textInputAdmin.dart';
import '../../constantes/cores.dart';

// BookDetail Page
class BookCreationPage extends StatefulWidget {
  models.Document? documentInstance;

  BookCreationPage({super.key, required this.documentInstance});

  @override
  State<BookCreationPage> createState() => _BookCreationPageState();
}

class _BookCreationPageState extends State<BookCreationPage> {
  // Declaration's
  // Appwrite
  AppwriteSystem appwriteSystem = AppwriteSystem();

  Map<String, dynamic> book_data = {
    'title': 'Titulo',
    'price': 'Preço',
    'category': 'Categoria',
    'author': 'Autor',
    'description': 'Descrição',
    'year': 'Ano',
  };

  List<XFile> listXFileImages = [];

  // TextEditingControllers
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController categoryEditingController = TextEditingController();
  TextEditingController authorEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController yearEditingController = TextEditingController();

  // Carousel
  CarouselController bookCarouselController = CarouselController();
  late List<Widget> carouselItens = [];
  int _groupValue = 0;

  List<XFile> listXFiles = [];
  List<InputFile> listInputFiles = [];
  List<String> listImagesUrl = [];
  List<String> deletedImages = [];

  bool dataIsLoaded = false;

  // Control Flag
  bool showDeleteImageButton = false;
  bool containPlaceholderImage = false;

  // Methods
  navigateBackHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeAdmin(),
        ),
        (route) => false);
  }

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

  void getBookDataFromDB() async {
    setState(() {
      book_data['title'] = widget.documentInstance!.data['title'];
      book_data['price'] = widget.documentInstance!.data['price'];
      book_data['category'] = widget.documentInstance!.data['category'];
      book_data['author'] = widget.documentInstance!.data['author'];
      book_data['description'] = widget.documentInstance!.data['description'];
      book_data['year'] = widget.documentInstance!.data['year'];

      listImagesUrl = appwriteSystem.prepareUrlListFromString(
          listImageUrlString: widget.documentInstance!.data['listImages']);

      for (String imageUrl in listImagesUrl) {
        carouselItens.add(Image.network(imageUrl));
        listXFileImages.add(XFile(''));
      }

      dataIsLoaded = true;
    });
  }

  void deleteImageFromCarousel() {
    try {
      setState(() {
        // ignore: prefer_is_empty
        if (carouselItens.length == 1 && containPlaceholderImage == false) {
          listXFileImages = [];
          deletedImages.add(listImagesUrl[0]);
          listImagesUrl = [];

          setCarouselToPlaceholder();

          containPlaceholderImage = true;
          showDeleteImageButton = false;
        } else if (carouselItens.length > 1) {
          listXFileImages.removeAt(_groupValue);

          try {
            deletedImages.add(listImagesUrl[_groupValue]);
          } catch (e) {}

          listImagesUrl.removeAt(_groupValue);

          carouselItens.removeAt(_groupValue);
        }

        if (_groupValue != 0) {
          _groupValue--;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void addImageToCarousel() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        if (containPlaceholderImage == true) {
          carouselItens = [];
          carouselItens.add(Image.network(image!.path));
          listImagesUrl.add('');

          listXFileImages.add(image);

          showDeleteImageButton = true;
          containPlaceholderImage = false;
        } else if (containPlaceholderImage == false) {
          carouselItens.add(Image.network(image!.path));

          listImagesUrl.add('');

          listXFileImages.add(image);
        }
      });
    } catch (e) {
      print('Falha ao pegar a imagem');
    }
  }

  void getInfoFromTextfield() {
    book_data['title'] = titleEditingController.text;
    book_data['price'] = priceEditingController.text;
    book_data['category'] = categoryEditingController.text;
    book_data['author'] = authorEditingController.text;
    book_data['description'] = descriptionEditingController.text;
    book_data['year'] = int.parse(yearEditingController.text);
  }

  Future<void> setImagesToUpload() async {
    for (XFile XFileImage in listXFileImages) {
      if (XFileImage.path != '') {
        var bytes = await XFileImage.readAsBytes();

        setState(() {
          listInputFiles.add(
            InputFile.fromBytes(
              bytes: bytes,
              filename: XFileImage.name,
            ),
          );
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.documentInstance != null) {
      getBookDataFromDB();
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
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: paletteYellow,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: IconButton(
                        onPressed: addImageToCarousel,
                        icon: const Icon(
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
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
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
                          hasToBeFilled: widget.documentInstance == null,
                        )
                      : const SizedBox(),

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

                      const Text(
                        'R\$',
                        style: TextStyle(
                          color: paletteWhite,
                          fontSize: 18,
                        ),
                      ),

                      Container(
                        constraints: const BoxConstraints(
                          maxWidth: 80,
                        ),
                        child: dataIsLoaded == true
                            ? TextFieldAdmin(
                                controller: priceEditingController,
                                hintText: book_data['price'],
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                hasToBeFilled: widget.documentInstance == null,
                              )
                            : const SizedBox(),
                      ),

                      const Spacer(),
                    ],
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
                          hasToBeFilled: widget.documentInstance == null,
                        )
                      : const SizedBox(),

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
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Categoria:',
                        style: TextStyle(
                          fontSize: 14,
                          color: paletteWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 250,
                        child: dataIsLoaded == true
                            ? TextFieldAdmin(
                                controller: categoryEditingController,
                                hintText: book_data['category'],
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                hasToBeFilled: widget.documentInstance == null,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Autor:',
                        style: TextStyle(
                          fontSize: 14,
                          color: paletteWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 250,
                        child: dataIsLoaded == true
                            ? TextFieldAdmin(
                                controller: authorEditingController,
                                hintText: book_data['author'],
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                hasToBeFilled: widget.documentInstance == null,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ano de lançamento:',
                        style: TextStyle(
                          fontSize: 14,
                          color: paletteWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 250,
                        child: dataIsLoaded == true
                            ? TextFieldAdmin(
                                controller: yearEditingController,
                                hintText: book_data['year'],
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                hasToBeFilled: widget.documentInstance == null,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Container(
              color: paletteYellow,
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () async {
                  setState(() {
                    getInfoFromTextfield();
                  });

                  await setImagesToUpload();

                  // Create document
                  if (widget.documentInstance == null &&
                      carouselItens.isNotEmpty &&
                      !containPlaceholderImage &&
                      book_data['title'] != '' &&
                      book_data['price'] != '' &&
                      book_data['category'] != '' &&
                      book_data['author'] != '' &&
                      book_data['description'] != '' &&
                      book_data['year'] != '') {
                    bool responseSuccess = await appwriteSystem.createDocument(
                      bookInformation: book_data,
                      listInputFile: listInputFiles,
                    );

                    if (responseSuccess) {
                      navigateBackHome();
                    }
                  } else if (widget.documentInstance != null &&
                      carouselItens.isNotEmpty &&
                      !containPlaceholderImage) {
                    if (book_data['title'] == '') {
                      book_data['title'] =
                          widget.documentInstance!.data['title'];
                    }
                    if (book_data['category'] == '') {
                      book_data['category'] =
                          widget.documentInstance!.data['category'];
                    }
                    if (book_data['price'] == '') {
                      book_data['price'] =
                          widget.documentInstance!.data['price'];
                    }
                    if (book_data['author'] == '') {
                      book_data['author'] =
                          widget.documentInstance!.data['author'];
                    }
                    if (book_data['description'] == '') {
                      book_data['description'] =
                          widget.documentInstance!.data['description'];
                    }
                    if (book_data['year'] == '') {
                      book_data['year'] = widget.documentInstance!.data['year'];
                    }

                    for (var element in listImagesUrl) {
                      listImagesUrl.remove('');
                    }

                    bool responseSuccess = await appwriteSystem.updateDocument(
                      documentId: widget.documentInstance!.$id,
                      newBookInformation: book_data,
                      listRemainingImages: listImagesUrl, 
                      listNewImages: listInputFiles,
                      listDeletedImagesUrl: deletedImages,
                    );

                    if (responseSuccess) {
                      navigateBackHome();
                    }
                  } else {
                    print('Algum elemento está faltando');
                  }
                },
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                  fontSize: 18,
                )),
                child: Text(
                  widget.documentInstance == null
                      ? 'Create Book'
                      : 'Update book',
                  style: const TextStyle(
                    color: paletteBlack,
                  ),
                ),
              ),
            ),
          ),
          widget.documentInstance != null
              ? Expanded(
                  child: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                      onPressed: () async {
                        bool responseSuccess =
                            await appwriteSystem.deleteDocument(
                                documentId: widget.documentInstance!.$id);

                        if (responseSuccess) {
                          navigateBackHome();
                        }
                      },
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(
                        fontSize: 18,
                      )),
                      child: Text(
                        'Delete Document',
                        style: const TextStyle(
                          color: paletteWhite,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
