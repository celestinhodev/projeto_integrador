import 'package:flutter/material.dart';
import 'constantes/appwrite_system.dart';
import 'pages/admin/book_page_admin.dart';
import 'pages/carrinho.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register.dart';

import 'pages/admin/home_admin.dart';
import 'pages/personal_data.dart';
import 'pages/search.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
