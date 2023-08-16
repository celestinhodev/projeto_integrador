import 'package:flutter/material.dart';

// Constants
import '../constantes/cores.dart';

var BookTokAppBar = PreferredSize(
  preferredSize: const Size(double.infinity, 45),
  child: Hero(
    tag: 'appbar',
    child: AppBar(
      title: Image.asset(
        'images/logo-appbar.png',
        height: 45,
      ),
      backgroundColor: paletteBlack,
      centerTitle: true,
    ),
  ),
);
