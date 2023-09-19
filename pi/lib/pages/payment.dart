import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;
import 'package:pi/components/payment_template.dart';
import 'package:pi/constantes/cores.dart';
import 'package:pi/pages/carrinho.dart';
import 'package:pi/pages/profile.dart';
import 'package:pi/pages/search.dart';

import '../components/navigation_bar.dart';
import 'Home.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget {
  models.Document? userPrefs;
  Payment({Key? key, this.userPrefs}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Color getColor(Set<MaterialState> states) {
    return paletteYellow;
  }

  bool isChecked = true;
  int groupValue = 0;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Carrinho(userPrefs: widget.userPrefs,),));
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Selecione uma forma de pagamento',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PayTemplate(
                            value: 0,
                            groupValue: groupValue,
                            onChanged: (p0) {
                              setState(() {
                                groupValue = 0;
                              });
                            },
                            text1: 'Boleto',
                            text2:
                                'Vencimento em 1 dia útil. A data de entrega será alterada devido ao tempo de processamento do boleto. Veja mais na próxima página.',
                          ),
                          PayTemplate(
                            value: 1,
                            groupValue: groupValue,
                            onChanged: (p0) {
                              setState(() {
                                groupValue = 1;
                              });
                            },
                            text1: 'Pix',
                            text2:
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
                                            fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      const SizedBox(width: 15),
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
                                          fontSize: 20,
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
            ),
          ),
        ],
      ),
      //Barra de navegação ------------------------------------------------------
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
            route: Home(userPrefs: widget.userPrefs,), icon: const Icon(Icons.home), current: true),
        search: MyIconButtonNavigator(
            route: SearchScreen(userPrefs: widget.userPrefs,),
            icon: const Icon(Icons.search),
            current: false),
        cart: MyIconButtonNavigator(
            route: Carrinho(userPrefs: widget.userPrefs,),
            icon: const Icon(Icons.shopping_cart),
            current: false),
        user: MyIconButtonNavigator(
            route: Profile(userPrefs: widget.userPrefs,),
            icon: const Icon(Icons.person),
            current: false),
      ),
    );
  }
}
