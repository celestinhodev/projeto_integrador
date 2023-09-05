import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import 'package:pi/components/personal_data_textfield.dart';
import 'package:pi/components/register_template.dart';
import 'package:pi/components/submitt_button.dart';
import 'package:pi/constantes/appwrite_constants.dart';
import '../components/drawer.dart';
import '../constantes/cores.dart';

import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';
import 'carrinho.dart';
import 'Home.dart';
import 'profile.dart';
import 'search.dart';

class PersonalData extends StatefulWidget {
  PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  // Declarations

  // Appwrite
  AppwriteConstants appwrite_constants = AppwriteConstants();

  // Text Editing Controler's
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController cepEditingController = TextEditingController();
  TextEditingController cityEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  TextEditingController complementEditingController = TextEditingController();
  TextEditingController telephoneEditingController = TextEditingController();
  TextEditingController oldPasswordEditingController = TextEditingController();

  // Methods

  Future<bool> updatePersonalDataInDB() async {
    String name = nameEditingController.text;
    String email = emailEditingController.text;
    String password = passwordEditingController.text;
    String cep = cepEditingController.text;
    String city = cityEditingController.text;
    String address = addressEditingController.text;
    String complement = complementEditingController.text;
    String telephone = telephoneEditingController.text;
    String oldPassword = oldPasswordEditingController.text;

    try {
      await appwrite_constants.updatePersonalData(
        name: name,
        email: email,
        password: password,
        cep: cep,
        city: city,
        address: address,
        complement: complement,
        telephone: telephone,
        oldPassword: oldPassword,
      );
      return true;
    } catch (e) {}
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookTokAppBar,
      drawer: MyDrawer(),
      backgroundColor: paletteBlack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 15, 20, 10),
            child: Text(
              'Dados Pessoais',
              style: TextStyle(
                fontSize: 20,
                color: paletteWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Divider(
            color: paletteWhite,
          ),

          // Elements
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  PersonalDataTextField(
                    hintText: 'Nome',
                    isPassword: false,
                    textEditingController: nameEditingController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PersonalDataTextField(
                    hintText: 'Email',
                    isPassword: false,
                    textEditingController: emailEditingController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PersonalDataTextField(
                    hintText: 'Senha',
                    isPassword: true,
                    textEditingController: passwordEditingController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 130,
                        ),
                        child: PersonalDataTextField(
                          hintText: 'CEP',
                          isPassword: false,
                          textEditingController: cepEditingController,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: PersonalDataTextField(
                          hintText: 'Cidade',
                          isPassword: false,
                          textEditingController: cityEditingController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PersonalDataTextField(
                    hintText: 'Endereço',
                    isPassword: false,
                    textEditingController: addressEditingController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 130,
                        ),
                        child: PersonalDataTextField(
                          hintText: 'Complemento',
                          isPassword: false,
                          textEditingController: complementEditingController,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 200,
                        ),
                        child: PersonalDataTextField(
                          hintText: 'Telefone',
                          isPassword: false,
                          textEditingController: telephoneEditingController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SubmittButton(
                    buttonText: 'Salvar Alterações',
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Deseja continuar? insira sua senha: ',
                            style: TextStyle(
                              color: paletteWhite,
                            ),
                          ),
                          backgroundColor: paletteBlack,
                          content: registerTemplate(
                            hintText: 'Senha Atual',
                            isPassword: true,
                            textEditingController: oldPasswordEditingController,
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text('Continuar'),
                              onPressed: () async {
                                var updateSuccess =
                                    await updatePersonalDataInDB();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ),
                      );
                    },
                    child: Text(
                      'Cancelar e Voltar',
                      style:
                          TextStyle(fontSize: 18, color: Colors.blue.shade400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
          route: Home(),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
          route: SearchScreen(),
          icon: const Icon(Icons.search),
          current: false,
        ),
        cart: MyIconButtonNavigator(
          route: Carrinho(),
          icon: const Icon(Icons.shopping_cart),
          current: false,
        ),
        user: MyIconButtonNavigator(
          route: Profile(),
          icon: const Icon(Icons.person),
          current: true,
        ),
      ),
    );
  }
}
