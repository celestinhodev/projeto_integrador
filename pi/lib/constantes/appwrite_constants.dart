import 'package:appwrite/appwrite.dart';

final Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('64e4007617e6f144bc02')
    .setSelfSigned(status: true);
