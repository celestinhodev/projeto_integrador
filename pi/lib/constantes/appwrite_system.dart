import 'dart:html';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'dart:convert';

class AppwriteSystem {
  // Declarations
  String projectId = '64e4007617e6f144bc02';
  String endPointUrl = 'https://cloud.appwrite.io/v1';

  String databaseId = '64e4023ae7be07f9d20c';

  String collectionId = '64e402567c80fa1abfcb'; // Livros
  String userInfoCollectionId = '64f56f4ecd5d55db5f34';

  String bucketId = '64e403ad974f334b94c1';

  late Client clientInstance =
      Client().setProject(projectId).setEndpoint(endPointUrl);
  late Databases databaseInstance = Databases(clientInstance);
  late Storage storageInstance = Storage(clientInstance);
  late Account accountInstance = Account(clientInstance);

  // Methods
  // Process methods
  List<String> getIdFromImageUrl({required String listImageUrlString}) {
    List<String> listImagesId = [];
    List<String> listImagesUrl =
        prepareUrlListFromString(listImageUrlString: listImageUrlString);

    for (var imageUrl in listImagesUrl) {
      listImagesId.add(imageUrl.split('/')[8]);
    }

    return listImagesId;
  }

  List<String> prepareUrlListFromString({required String listImageUrlString}) {
    return listImageUrlString
        .replaceAll('[', '')
        .replaceAll(']', '')
        .split(', ');
  }

  // Storage methods
  Future<List<String>?> uploadFile(
      {required List<InputFile> listInputFile}) async {
    List<String> listImages = [];

    for (var file in listInputFile) {
      try {
        models.File newFile = await storageInstance.createFile(
          bucketId: bucketId,
          fileId: ID.unique(),
          file: file,
        );

        listImages.add(
            'https://cloud.appwrite.io/v1/storage/buckets/$bucketId/files/${newFile.$id}/view?project=$projectId');
      } catch (e) {
        return null;
      }
    }

    return listImages;
  }

  Future<bool> deleteFile({required List<String> listFilesId}) async {
    for (var fileId in listFilesId) {
      try {
        await storageInstance.deleteFile(bucketId: bucketId, fileId: fileId);
      } catch (e) {
        return false;
      }
    }

    return true;
  }

  // Database methods
  Future<bool> createDocument({
    required Map<String, dynamic> bookInformation,
    required List<InputFile> listInputFile,
  }) async {
    List<String>? listImages = await uploadFile(listInputFile: listInputFile);

    bookInformation['listImages'] = listImages.toString();

    try {
      models.Document newDocument = await databaseInstance.createDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: bookInformation,
      );

      return true;
    } catch (e) {}

    return false;
  }

  Future<models.Document?> readDocument({required String documentId}) async {
    try {
      return await databaseInstance.getDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId);
    } catch (e) {}

    return null;
  }

  Future<bool> updateDocument({
    required String documentId,
    required Map<String, dynamic> newBookInformation,
    required List<String> listDeletedImagesUrl,
    required List<InputFile> listNewImages,
    required List<String> listRemainingImages,
  }) async {
    List<String> listDeletedImagesId = [];

    for (var deletedImageUrl in listDeletedImagesUrl) {
      listDeletedImagesId.add(deletedImageUrl.split('/')[8]);
    }

    await deleteFile(listFilesId: listDeletedImagesId);

    List<String>? listImagesUrl =
        await uploadFile(listInputFile: listNewImages);

    if (listRemainingImages.isEmpty) {
      newBookInformation['listImages'] = listImagesUrl.toString();
    } else {
      for (String newImageUrl in listImagesUrl!) {
        if (newImageUrl != '') {
          listRemainingImages.add(newImageUrl);
        }
      }

      newBookInformation['listImages'] = listRemainingImages.toString();
    }

    try {
      await databaseInstance.updateDocument(
        databaseId: databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: newBookInformation,
      );

      return true;
    } catch (e) {}

    return false;
  }

  Future<bool> deleteDocument({
    required String documentId,
  }) async {
    models.Document? document = await readDocument(documentId: documentId);

    List<String> listImagesIdToDelete = await getIdFromImageUrl(
        listImageUrlString: document!.data['listImages']);

    bool deleteFileSuccess =
        await deleteFile(listFilesId: listImagesIdToDelete);

    if (deleteFileSuccess) {
      try {
        await databaseInstance.deleteDocument(
            databaseId: databaseId,
            collectionId: collectionId,
            documentId: documentId);

        return true;
      } catch (e) {}
    }

    return false;
  }

  Future<models.DocumentList?> listDocuments(
      {required String searchText, String atributes = 'title'}) async {
    models.DocumentList listDocuments;

    try {
      switch (searchText) {
        case '':
          listDocuments = await databaseInstance.listDocuments(
            databaseId: databaseId,
            collectionId: collectionId,
          );
          break;
        default:
          listDocuments = await databaseInstance.listDocuments(
              databaseId: databaseId,
              collectionId: collectionId,
              queries: [
                Query.search(atributes!, searchText),
              ]);
      }

      return listDocuments;
    } catch (e) {}

    return null;
  }

  // Account methods
  Future<String> loginAccount(
      {required String email, required String password}) async {
    try {
      await accountInstance.createEmailSession(
        email: email,
        password: password,
      );

      return '201';
    } catch (e) {
      return e.toString().replaceAll(')', '').split('(')[1];
    }
  }

  Future<void> createPreferences({required String userId}) async {
    try {
      await databaseInstance.createDocument(
          databaseId: databaseId,
          collectionId: userInfoCollectionId,
          documentId: ID.unique(),
          data: {
            "userId": userId,
          });
    } catch (e) {}
  }

  Future<bool> registerAccount(
      {required String name,
      required String email,
      required String password}) async {
    try {
      var response = await accountInstance.create(
          userId: ID.unique(), name: name, email: email, password: password);

      await createPreferences(userId: response.$id);

      return true;
    } catch (e) {}

    return false;
  }

  Future<models.Document?> getUserPreferences() async {
    var account = await accountInstance.get();

    return (await databaseInstance.listDocuments(
      databaseId: databaseId,
      collectionId: userInfoCollectionId,
      queries: [
        Query.search('userId', account.$id),
      ],
    ))
        .documents[0];
  }

  Future<bool> updatePreferences(
      {required Map<String, dynamic> newPreferences}) async {
    try {
      var document = await getUserPreferences();

      await databaseInstance.updateDocument(
          databaseId: databaseId,
          collectionId: userInfoCollectionId,
          documentId: document!.$id,
          data: {
            if (newPreferences['cep'] != '') 'cep': newPreferences['cep'],
            if (newPreferences['city'] != '') 'city': newPreferences['city'],
            if (newPreferences['address'] != '')
              'address': newPreferences['address'],
            if (newPreferences['complement'] != '')
              'complement': newPreferences['complement'],
          });

      return true;
    } catch (e) {
      print(e);
    }

    return false;
  }

  Future<bool> updateEmail({
    required String newEmail,
    required String accountPassword,
  }) async {
    try {
      await accountInstance.updateEmail(
          email: newEmail, password: accountPassword);

      return true;
    } catch (e) {}

    return false;
  }

  Future<bool> updateTelephone({
    required String newPhone,
    required String accountPassword,
  }) async {
    try {
      await accountInstance.updatePhone(
          phone: newPhone, password: accountPassword);

      return true;
    } catch (e) {}

    return false;
  }

  Future<bool> updateName({
    required String newName,
  }) async {
    try {
      await accountInstance.updateName(
        name: newName,
      );

      return true;
    } catch (e) {}

    return false;
  }

  Future<bool> updatePassword(
      {required String newPassword, required String oldPassword}) async {
    try {
      await accountInstance.updatePassword(
          password: newPassword, oldPassword: oldPassword);

      return true;
    } catch (e) {}

    return false;
  }

  Future<List<dynamic>> getCurrentCart(
      {required String currentCartString}) async {
    try {
      List json = JsonDecoder().convert(currentCartString);

      return json;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> updateCart(
      {required List<dynamic> newCartItens, required String documentId}) async {
    try {
      String cartToUpload = JsonEncoder().convert(newCartItens);

      await databaseInstance.updateDocument(
          databaseId: databaseId,
          collectionId: userInfoCollectionId,
          documentId: documentId,
          data: {
            'cartItens': cartToUpload,
          });

      return true;
    } catch (e) {
      print(e);
    }

    return false;
  }
}
