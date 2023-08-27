import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:image_picker/image_picker.dart';

class AppwriteConstants {
  String endPoint;
  String projectId;
  String databaseId;
  String bookCollectionId;
  String bucketId;

  AppwriteConstants([
    this.endPoint = 'https://cloud.appwrite.io/v1',
    this.projectId = '64e4007617e6f144bc02',
    this.databaseId = '64e4023ae7be07f9d20c',
    this.bookCollectionId = '64e402567c80fa1abfcb',
    this.bucketId = '64e403ad974f334b94c1',
  ]);

  late Client client = Client().setEndpoint(endPoint).setProject(projectId);

  late Databases database = Databases(client);
  late Storage storage = Storage(client);

  Future<DocumentList?> getDocuments() async {
    try {
      final DocumentList response = await database.listDocuments(
          databaseId: databaseId, collectionId: bookCollectionId);

      return response;
    } catch (e) {
      return null;
    }
  }

  Future prepareImage({required XFile image, required String title}) async {
    var filename = title.replaceAll(' ', '_');

    try {
      InputFile readyImage = InputFile.fromBytes(
          bytes: await image.readAsBytes(), filename: filename);
      print('Imagem pronta.');
      return readyImage;
    } catch (e) {
      print('Error to prepareImage(): ${e}');
      return null;
    }
  }

  Future<List<String?>?> uploadImages(
      {required List<InputFile> listImages}) async {
    List<String?>? listPath = [];

    if (listImages.isNotEmpty) {
      for (var image in listImages) {
        try {
          var response = await storage.createFile(
              bucketId: bucketId, fileId: ID.unique(), file: image);

          listPath.add(response.$id.toString());
        } catch (e) {
          print('Error on uploadFile(): ${e}');
        }
      }
      print('Upload feito');
      return listPath;
    } else {
      return null;
    }
  }

  void createDocument(
      {required String title,
      required String author,
      required String price,
      required String category,
      required String description,
      required List<XFile> listXFiles}) async {
    List<InputFile> listPreparedImages = [];

    print('Title: ${title.toString()}');
    print('Author: ${author.toString()}');
    print('Price: ${price.toString()}');
    print('Category: ${category.toString()}');
    print('Description: ${description.toString()}');

    for (var element in listXFiles) {
      listPreparedImages.add(await prepareImage(image: element, title: title,));
    }

    print('Images: $listPreparedImages');

    List<String?>? listIdImages =
        await uploadImages(listImages: listPreparedImages);

    try {
      var response = database.createDocument(
          databaseId: databaseId,
          collectionId: bookCollectionId,
          documentId: ID.unique(),
          data: {
            "title": title,
            "price": price,
            "category": category,
            "author": author,
            "description": description,
            "listImages": listIdImages.toString(),
          });
      print('Documento criado com sucesso!!');
    } catch (e) {
      print('Falha ao criar o documento.');
    }
  }
}
