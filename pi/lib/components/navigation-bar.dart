import 'package:flutter/material.dart';

import '../constantes/cores.dart';

class MyNavigationBar extends StatelessWidget {
  MyIconButtonNavigator home;
  MyIconButtonNavigator search;
  MyIconButtonNavigator cart;
  MyIconButtonNavigator user;

  MyNavigationBar({
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
