import 'package:flutter/material.dart';
import 'package:pi/components/booktok_appbar.dart';
import 'package:pi/components/navigation_bar.dart';
import 'package:pi/constantes/cores.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar, 
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Área da pesquisa
            Container(
              width: double.infinity, // Ocupa toda a largura da tela (num consegui) 
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: const BoxDecoration(
                color: paletteGrey, 
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Lógica de pesquisa aqui
                    },
                    icon: const Icon(Icons.search),
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '',
                        border: InputBorder.none, // Remove a borda do TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
