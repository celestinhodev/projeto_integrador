import 'package:flutter/material.dart';
import 'package:pi/pages/admin/book_page_admin.dart';
import 'package:pi/pages/home.dart';
import 'package:pi/pages/login.dart';

import 'pages/admin/home_admin.dart';
import 'pages/search.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SearchScreen(),
      ),
    );
