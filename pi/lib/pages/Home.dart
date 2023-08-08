import 'package:flutter/material.dart';
import 'package:pi/components/book_template.dart';
import 'package:pi/components/booktok_appbar.dart';

// Constantes
import '../components/drawer.dart';
import '../constantes/cores.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Comum Component App Bar 
      appBar: BookTokAppBar,

      drawer: MyDrawer(),

      backgroundColor: paletteBlack,
      body: SingleChildScrollView(
      child: Column(
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
          //const SizedBox(height: 20),
          Row(
            children: [
              BookTemplate(caminhoImagem: 'images/livros/livro.png', nomeLivro: 'aaaaaa')
            ],
          ),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 1',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 2',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 3',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 4',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 1',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 2',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 3',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 4',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 1',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 2',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 3',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 4',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 1',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 2',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 50, 5, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 3',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 50, 10, 10),
                      child: Image.asset(
                        'images/livros/livro.png',
                        height: 120,
                      ),
                    ),
                    const Text(
                      'Livro 4',
                      style: TextStyle(
                        color: paletteWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      )
    );
  }
}
