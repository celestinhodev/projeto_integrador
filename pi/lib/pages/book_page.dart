// Packages
import 'package:flutter/material.dart';

// Components
import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';

// Constants
import '../constantes/cores.dart';
import 'home.dart';


// BookDetail Page
class BookDetailsPage extends StatefulWidget {
  String nomeLivro;

  BookDetailsPage({
    super.key,
    required this.nomeLivro
  });

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState(nomeLivro: nomeLivro);
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  String nomeLivro;

  _BookDetailsPageState({
    required this.nomeLivro
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,

      
      body: Column(
        children: [


          

        ],
      ),


      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.home), current: false),
        search: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.search), current: false),
        cart: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.shopping_cart), current: false),
        user: MyIconButtonNavigator(
            route: Home(), icon: Icon(Icons.person), current: false),
      ),
    );
  }
}