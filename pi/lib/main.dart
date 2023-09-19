import 'package:flutter/material.dart';
import 'package:pi/pages/Home.dart';
import 'pages/login.dart';
import 'pages/payment.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
