import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:image_picker/image_picker.dart';

class AppwriteConstants {
  // Declaration's
  String endPoint = 'https://cloud.appwrite.io/v1';
  String projectId = '64e4007617e6f144bc02';
  String databaseId = '64e4023ae7be07f9d20c';
  String bookCollectionId = '64e402567c80fa1abfcb';
  String bucketId = '64e403ad974f334b94c1';

  late Client client = Client().setEndpoint(endPoint).setProject(projectId);
  late Databases database = Databases(client);
  late Storage storage = Storage(client);


  // Methods
  // Process Methods
  Future<Document?> getDocument({required String documentId}) async {
    try {
      return await database.getDocument(databaseId: databaseId, collectionId: bookCollectionId, documentId: documentId);
    } catch (e) {}

    return null;
  }
  
  List<String> prepareList({required listImagesString}) {
    return listImagesString.toString().replaceFirst('[', '').replaceFirst(']', '').split(', ');
  }
  
  Future<InputFile?> prepareImage({required XFile image, required String title}) async {
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

  List<String> getImageUrlList({required List<String>listImages}) {
    List<String> imageUrlList = [];

    for (var element in listImages) {
      imageUrlList.add('https://cloud.appwrite.io/v1/storage/buckets/$bucketId/files/$element/view?project=$projectId');
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
  Future<DocumentList?> listDocuments() async {
    try {
      DocumentList response = await database.listDocuments(
          databaseId: databaseId, collectionId: bookCollectionId);

      return response;
    } catch (e) {
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

    for (var element in listXFiles) {
      InputFile? preparedImage = await prepareImage(image: element, title: title,);
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
            "listImages": finalImages.toString(),
          });
      print('Documento criado com sucesso!!');
    } catch (e) {
      print('Falha ao criar o documento.');
    }
  }

  void updateDocument(
      {required String title,
      required String author,
      required String price,
      required String category,
      required String description,
      required List<XFile> listXFiles,
      required String? idDocument}) async {
    print('chegou no upload');
    List<InputFile> listPreparedImages = [];

    for (var element in listXFiles) {
      InputFile? preparedImage = await prepareImage(image: element, title: title,);
      listPreparedImages.add(preparedImage!);
    }

    List<String> listIdImages =
        await uploadImages(listImages: listPreparedImages);

    List<String> finalImages = getImageUrlList(listImages: listIdImages);


    try {
      // ignore: unused_local_variable
      Document response = await database.updateDocument(
          databaseId: databaseId,
          collectionId: bookCollectionId,
          documentId: ID.unique(),
          data: {
            "title": title,
            "price": price,
            "category": category,
            "author": author,
            "description": description,
            "listImages": finalImages,
          });
      print('Documento criado com sucesso!!');
    } catch (e) {
      print('Falha ao criar o documento.');
    }
  }

  void deleteImage({required List<String> listImages}) async {
    for (var element in listImages) {
      await storage.deleteFile(bucketId: bucketId, fileId: element);
    }
  }

  void deleteDocument(String documentId) async {
    Document? document = await getDocument(documentId: documentId);
    List<String> listImages = prepareList(listImagesString: document!.data['listImages']);

    List<String> listImagesUrl = getImagesIdFromUrl(listImages);

    deleteImage(listImages: listImagesUrl);

    var response = database.deleteDocument(databaseId: databaseId, collectionId: bookCollectionId, documentId: documentId);
  }
}