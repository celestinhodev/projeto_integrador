import 'package:flutter/material.dart';
import 'package:pi/pages/carrinho.dart';
import 'package:pi/pages/home.dart';
import '../constantes/cores.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  TextStyle? textStylePages = TextStyle(
    color: paletteBlack,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  TextStyle? textStyleCategories = TextStyle(
    color: paletteBlack,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: paletteWhite,
      child: ListView(
        children: [
          SizedBox(
            height: 56,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: paletteBlack,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo-transparent.png',
                    height: 40,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Bem vindo Leitor!',
                    style: TextStyle(
                      color: paletteYellow,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Home', style: textStylePages),
            contentPadding: EdgeInsets.only(left: 35),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Meus Pedidos', style: textStylePages),
            contentPadding: EdgeInsets.only(left: 35),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Carrinho(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Meu perfil', style: textStylePages),
            contentPadding: EdgeInsets.only(left: 35),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          SizedBox(
            height: 5,
          ),
          MySeparator(
            color: Colors.grey,
            height: 3,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(35, 20, 35, 5),
            child: Text(
              'Categorias',
              style: textStylePages,
            ),
          ),
          ListTile(
            title: Text('> Terror', style: textStyleCategories),
            contentPadding: EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('> Romance', style: textStyleCategories),
            contentPadding: EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('> Fantasia', style: textStyleCategories),
            contentPadding: EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('> Infantil', style: textStyleCategories),
            contentPadding: EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
