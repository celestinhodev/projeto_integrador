import 'package:pi/constantes/appwrite_constants.dart';

class Book {
  String? documentId;
  late String title;
  late String price;
  late String category;
  late String author;
  late String description;
  late String listImagesString;

  AppwriteConstants appwrite_constants = AppwriteConstants();

  Book({required this.documentId});

  void setBookInformation() async {
    var document = await appwrite_constants.getDocument(documentId: documentId!);

    title = document!.data['title'];
    price = document.data['price'];
    category = document.data['category'];
    author = document.data['author'];
    description = document.data['description'];
    listImagesString = document.data['listImages'];
  }
}