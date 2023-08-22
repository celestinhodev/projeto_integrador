import 'dart:io';

import 'package:appwrite/appwrite.dart';

const String databaseId = '64e4007617e6f144bc02';
const String bucketId = '64e4007617e6f144bc02';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
    .setProject(databaseId);

Databases database = Databases(client);
Storage storage = Storage(client);

class AppwriteModule {
  void uploadImage() async {
    try {
      var file = InputFile.fromPath(
        path: '.../images/livros/livro.png',
        filename: 'image.png',
      );
      var upload = await storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(bytes: file.bytes!, filename: 'image.png'),
      );
      print('foi');
    } catch (e) {
      print('Erro foi: $e');
    }
  }
}
