import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:image_picker/image_picker.dart';

class AppwriteConstants {
  // Declaration's
  String endPoint = 'https://cloud.appwrite.io/v1';
  String projectId = '64e4007617e6f144bc02';
  String databaseId = '64e4023ae7be07f9d20c';
  String bookCollectionId = '64e402567c80fa1abfcb';
  String UserInfoCollectionId = '64f56f4ecd5d55db5f34';
  String bucketId = '64e403ad974f334b94c1';

  late Client client = Client().setEndpoint(endPoint).setProject(projectId);
  late Databases database = Databases(client);
  late Storage storage = Storage(client);
  late Account account = Account(client);

  // Methods
  // Process Methods
  // Book's Processing
  Future<models.Document?> getDocument({required String documentId}) async {
    try {
      return await database.getDocument(
          databaseId: databaseId,
          collectionId: bookCollectionId,
          documentId: documentId);
    } catch (e) {}

    return null;
  }

  List<String> prepareList({required listImagesString}) {
    return listImagesString
        .toString()
        .replaceFirst('[', '')
        .replaceFirst(']', '')
        .split(', ');
  }

  Future<InputFile?> prepareImage(
      {required XFile image, required String title}) async {
    String filename = title.replaceAll(' ', '_');

    try {
      InputFile readyImage = InputFile.fromBytes(
          bytes: await image.readAsBytes(), filename: filename);
      return readyImage;
    } catch (e) {
      print('Error to prepareImage(): ${e}');
      return null;
    }
  }

  Future<List<String>> uploadImages(
      {required List<InputFile> listImages}) async {
    List<String> listImagesId = [];

    if (listImages.isNotEmpty) {
      for (var image in listImages) {
        try {
          var response = await storage.createFile(
              bucketId: bucketId, fileId: ID.unique(), file: image);

          listImagesId.add(response.$id.toString());
        } catch (e) {
          print('Error on uploadFile(): ${e}');
        }
      }
      return listImagesId;
    } else {
      return [];
    }
  }

  List<String> getImageUrlList({required List<String> listImages}) {
    List<String> imageUrlList = [];

    for (var element in listImages) {
      imageUrlList.add(
          'https://cloud.appwrite.io/v1/storage/buckets/$bucketId/files/$element/view?project=$projectId');
    }

    return imageUrlList;
  }

  List<String> getImagesIdFromUrl(listImagesUrl) {
    List<String> imagesIdList = [];

    for (String element in listImagesUrl) {
      imagesIdList.add(element.split('/')[8]);
    }

    print(imagesIdList);

    return imagesIdList;
  }

  // Final Methods
  Future<models.DocumentList?> listDocuments() async {
    try {
      models.DocumentList response = await database.listDocuments(
          databaseId: databaseId, collectionId: bookCollectionId);

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<bool> createDocument(
      {required String title,
      required String author,
      required String price,
      required String category,
      required String description,
      required String year,
      required List<XFile> listXFileImages}) async {
    List<InputFile> listPreparedImages = [];

    for (var element in listXFileImages) {
      InputFile? preparedImage = await prepareImage(
        image: element,
        title: title,
      );
      listPreparedImages.add(preparedImage!);
    }

    List<String> listIdImages =
        await uploadImages(listImages: listPreparedImages);

    List<String> finalImages = getImageUrlList(listImages: listIdImages);

    try {
      // ignore: unused_local_variable
      var response = await database.createDocument(
          databaseId: databaseId,
          collectionId: bookCollectionId,
          documentId: ID.unique(),
          data: {
            "title": title,
            "price": price,
            "category": category,
            "author": author,
            "description": description,
            "year": year,
            "listImages": finalImages.toString(),
          });

      print('Documento criado com sucesso!!');
      return true;
    } catch (e) {
      print('Falha ao criar o documento.');
    }
    return false;
  }

  Future<bool> updateDocument(
      {required String title,
      required String author,
      required String price,
      required String category,
      required String description,
      required String year,
      required List<XFile> listXFileImages,
      required List<String> listCurrentImages,
      required List<String> deletedImages,
      required String? idDocument}) async {
    List<InputFile> listPreparedImages = [];

    List<String> listDeletedImagesId = getImagesIdFromUrl(deletedImages);

    for (var element in listDeletedImagesId) {
      await storage.deleteFile(bucketId: bucketId, fileId: element);
    }

    for (var element in listXFileImages) {
      InputFile? preparedImage = await prepareImage(
        image: element,
        title: title,
      );
      listPreparedImages.add(preparedImage!);
    }

    List<String> listIdImages =
        await uploadImages(listImages: listPreparedImages);

    List<String> finalImages = getImageUrlList(listImages: listIdImages);

    for (var i = 0; i < listCurrentImages.length; i++) {
      listCurrentImages.remove('');
    }

    for (var element in finalImages) {
      listCurrentImages.add(element);
    }

    try {
      // ignore: unused_local_variable
      models.Document response = await database.updateDocument(
          databaseId: databaseId,
          collectionId: bookCollectionId,
          documentId: idDocument!,
          data: {
            "title": title,
            "price": price,
            "category": category,
            "author": author,
            "description": description,
            "year": year,
            "listImages": listCurrentImages.toString(),
          });
      print('Upload feito com sucesso!!');
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  void deleteImage({required List<String> listImages}) async {
    for (var element in listImages) {
      await storage.deleteFile(bucketId: bucketId, fileId: element);
    }
  }

  Future<bool> deleteDocument(String documentId) async {
    models.Document? document = await getDocument(documentId: documentId);
    List<String> listImages = [];

    if (document!.data['listImages'].toString().contains(',')) {
      listImages = prepareList(listImagesString: document.data['listImages']);
    } else {
      listImages = [
        document.data['listImages']
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', '')
      ];
    }

    List<String> listImagesId = getImagesIdFromUrl(listImages);

    for (var element in listImagesId) {
      try {
        await storage.deleteFile(bucketId: bucketId, fileId: element);
      } catch (e) {
        return false;
      }
    }

    try {
      await database.deleteDocument(
          databaseId: databaseId,
          collectionId: bookCollectionId,
          documentId: documentId);

      return true;
    } catch (e) {}

    return false;
  }

  Future<models.DocumentList?> searchBooks({required String searchText}) async {
    try {
      var response = await database.listDocuments(
        databaseId: databaseId,
        collectionId: bookCollectionId,
        queries: [
          Query.search("title", searchText),
        ],
      );

      return response;
    } catch (e) {}
  }


  // Account Processing
  Future<models.Document?> createAccountDocument(
      {required String email}) async {
    try {
      var response = await database.createDocument(
        databaseId: databaseId,
        collectionId: UserInfoCollectionId,
        documentId: ID.unique(),
        data: {
          'email': email,
        },
      );

      return response;
    } catch (e) {
      return null;
    }
  }

  Future<bool> accountCreate({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var response = await account.create(
        userId: ID.unique(),
        name: name,
        email: email,
        password: password,
      );

      print('Conta criada com sucesso');

      createAccountDocument(email: email);

      print('Documento criado');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> accountLogin(
      {required String email, required String password}) async {
    try {
      var response = await account.createEmailSession(
        email: email,
        password: password,
      );

      print('Login feito');
      return true;
    } catch (e) {
      return false;
    }
  }
}
