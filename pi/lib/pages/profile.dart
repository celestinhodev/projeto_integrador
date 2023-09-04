import 'package:flutter/material.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/search.dart';

import '../components/book_template.dart';
import '../components/drawer.dart';
import '../components/navigation_bar.dart';
import 'Home.dart';
import 'carrinho.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      drawer: const MyDrawer(),
      body: Container(
        color: paletteBlack,
        child: Column(
          children: [
            const SizedBox(height: 16), // Espaçamento entre os botões
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centraliza os botões horizontalmente
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    // Borda arredondada
                    shape: RoundedRectangleBorder(
                      // Controla o arredondamento
                      borderRadius: BorderRadius.circular(50),
                    ),
                    foregroundColor: paletteWhite,
                    // Cor do background
                    backgroundColor: paletteGrey,
                    // Espaçamento dentro do botão
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16, // Reduz o espaço vertical
                    ),
                  ),
                  onPressed: () {
                    // Lógica para o primeiro botão aqui
                  },
                  child: const Text(
                    'Dados Pessoais',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 27), // Espaçamento entre os botões
                TextButton(
                  style: TextButton.styleFrom(
                    // Borda arredondada
                    shape: RoundedRectangleBorder(
                      // Controla o arredondamento
                      borderRadius: BorderRadius.circular(50),
                    ),
                    foregroundColor: paletteWhite,
                    // Cor do background
                    backgroundColor: paletteGrey,
                    // Espaçamento dentro do botão
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16, // Reduz o espaço vertical
                    ),
                  ),
                  onPressed: () {
                    // Lógica para o segundo botão aqui
                  },
                  child: const Text(
                    'Configurações',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 320, 0),
              child: Text(
                'Seus Pedidos',
                style: TextStyle(
                  fontSize: 20,
                  color: paletteWhite,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 12, 0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  mainAxisExtent: 225,
                ),
                shrinkWrap: true,
                children: [
                  
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
        route: const Home(), icon: const Icon(Icons.home),
        current: false,
        ),
        search: MyIconButtonNavigator(
          route: const SearchScreen(),
          icon: const Icon(Icons.search),
          current: false,
        ),
        cart: MyIconButtonNavigator(
          route: const Carrinho(),
          icon: const Icon(Icons.shopping_cart),
          current: false,
          ),
        user: MyIconButtonNavigator(
          route: const Profile(),
          icon: const Icon(Icons.person),
          current: true,
        ),
      ),
    );
  }
}
