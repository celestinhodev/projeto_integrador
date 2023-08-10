// Packages
import 'package:flutter/material.dart';

// Constants
import '../constantes/cores.dart';

class BookTokNavigation extends StatelessWidget {
  final MyIconButtonNavigator home;
  final MyIconButtonNavigator search;
  final MyIconButtonNavigator cart;
  final MyIconButtonNavigator user;

  const BookTokNavigation({
    super.key,
    required this.home,
    required this.search,
    required this.cart,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: paletteBlack,
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          home,
          search,
          cart,
          user,
        ],
      ),
    );
  }
}

class MyIconButtonNavigator extends StatelessWidget {
  dynamic route;
  Icon icon;
  bool current;

  MyIconButtonNavigator({
    required this.route, 
    required this.icon, 
    required this.current,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if(current == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ),
          );
        }
      },
      icon: icon,
      isSelected: false,

      color: paletteWhite,
    );
  }
}
