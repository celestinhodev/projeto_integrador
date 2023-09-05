// Packages
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

// Constants
import '../constantes/cores.dart';

// Pages
import '../pages/carrinho.dart';
import '../pages/Home.dart';


class MyDrawer extends StatefulWidget {
  MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  TextStyle? textStylePages = const TextStyle(
    color: paletteBlack,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  TextStyle? textStyleCategories = const TextStyle(
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
              decoration: const BoxDecoration(
                color: paletteBlack,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: paletteWhite,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'images/logo-transparent.png',
                        height: 40,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        'Bem vindo Leitor!',
                        style: TextStyle(
                          color: paletteYellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('Home', style: textStylePages),
            contentPadding: const EdgeInsets.only(left: 35),
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
            contentPadding: const EdgeInsets.only(left: 35),
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
            contentPadding: const EdgeInsets.only(left: 35),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const MySeparator(
            color: Colors.grey,
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 20, 35, 5),
            child: Text(
              'Categorias',
              style: textStylePages,
            ),
          ),
          ListTile(
            title: Text('> Terror', style: textStyleCategories),
            contentPadding: const EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('> Romance', style: textStyleCategories),
            contentPadding: const EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('> Fantasia', style: textStyleCategories),
            contentPadding: const EdgeInsets.only(left: 45),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('> Infantil', style: textStyleCategories),
            contentPadding: const EdgeInsets.only(left: 45),
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
