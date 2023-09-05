import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../constantes/cores.dart';

import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';
import 'carrinho.dart';
import 'home.dart';
import 'profile.dart';
import 'search.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      drawer: const MyDrawer(),
      backgroundColor: paletteBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 15, 20, 10),
            child: Text(
              'Dados Pessoais',
              style: TextStyle(
                fontSize: 20,
                color: paletteWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Divider(
            color: paletteWhite,
          ),

          // Elements
          Padding(
            padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
            child: Column(
              children: [

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
          route: const Home(),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
            route: const SearchScreen(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: const Carrinho(),
            icon: const Icon(Icons.shopping_cart),
            current: false),
        user: MyIconButtonNavigator(
            route: const Profile(),
            icon: const Icon(Icons.person),
            current: false),
      ),
    );
  }
}
