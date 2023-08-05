import 'package:flutter/material.dart';

// Constantes
import '../constantes/cores.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookTok'),
        backgroundColor: Colors.yellow,
      ),
      backgroundColor: paletteBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: Text(
              'Lançamentos',
              style: TextStyle(
                fontSize: 20,
                color: paletteWhite,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              'images/livros/livro.png',
            ),
          ),
        ],
      ),
    );
  }
}
