import 'package:flutter/material.dart';
import 'package:pi/components/payment_template.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/carrinho.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

import '../components/navigation_bar.dart';
import '../components/submitt_button.dart';
import 'Home.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    return paletteYellow;
  }

  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: paletteYellow2,
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              //cor do foregroud
              foregroundColor: paletteWhite,
            ),
            onPressed: () {
              
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontSize: 18,
                color: paletteBlack,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Selecione uma forma de pagamento',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PayTemplate(
                    Text1: 'Boleto',
                    Text2:
                        'Vencimento em 1 dia útil. A data de entrega será alterada devido ao tempo de processamento do boleto. Veja mais na próxima página.',
                  ),
                  PayTemplate(
                    Text1: 'Pix',
                    Text2:
                        'O código Pix gerado para pagamento é válido por 30 minutos após a finalização do pedido.',
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: palettWhiteGrey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.fromLTRB(30, 5, 0, 5),
                          child: Row(
                            children: [
                              const Text(
                                'Adicionar outra forma de pagamento',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              ),
                              const SizedBox(width: 25),
                              ClipOval(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  color: paletteYellow,
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.add,
                                        size: 15, // Tamanho para o ícone
                                        color: paletteDarkGrey,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 1,
                          ), // Margem apenas nos lados
                          decoration: const BoxDecoration(
                            color: paletteYellow,
                          ),
                          child: SizedBox(
                            height: 50, // Ajuste a altura conforme necessário
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Continuar',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: paletteBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      //Barra de navegação ------------------------------------------------------
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: Home(), icon: const Icon(Icons.home), current: true),
        search: MyIconButtonNavigator(
            route: SearchScreen(),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: Carrinho(),
            icon: const Icon(Icons.shopping_cart),
            current: false),
        user: MyIconButtonNavigator(
            route: Profile(),
            icon: const Icon(Icons.person),
            current: false),
      ),
    );
  }
}
