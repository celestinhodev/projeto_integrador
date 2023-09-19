// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/models.dart' as models;

import 'package:pi/components/personal_data_textfield.dart';
import 'package:pi/components/register_template.dart';
import 'package:pi/components/submitt_button.dart';
import 'package:pi/constantes/appwrite_system.dart';
import '../constantes/cores.dart';

import '../components/booktok_appbar.dart';
import '../components/navigation_bar.dart';
import 'carrinho.dart';
import 'home.dart';
import 'profile.dart';
import 'search.dart';

// ignore: must_be_immutable
class PersonalData extends StatefulWidget {
  models.Document? userPrefs;

  PersonalData({
    super.key,
    this.userPrefs,
  });

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  // Declarations

  // Appwrite
  AppwriteSystem appwriteSystem = AppwriteSystem();

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

  Widget? statusShowing;

  Widget error = Container(
    color: Colors.redAccent,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Falha ao alterar as preferencias.'),
      ],
    ),
  );
  Widget success = Container(
    color: Colors.green,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Alterações alteradas com sucesso!!'),
      ],
    ),
  );

  // Methods
  showErrorMessage(atualError) async {
    setState(() {
      statusShowing = atualError;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      statusShowing = null;
    });
  }

  Future<bool> updatePersonalDataInDB() async {
    Map<String, dynamic> newPreferences = {};

    String newName = nameEditingController.text;
    String newEmail = emailEditingController.text;
    String newPassword = passwordEditingController.text;
    String newTelephone = telephoneEditingController.text;

    newPreferences["cep"] = cepEditingController.text;
    newPreferences["city"] = cityEditingController.text;
    newPreferences["address"] = addressEditingController.text;
    newPreferences["complement"] = complementEditingController.text;

    String oldPassword = oldPasswordEditingController.text;

    bool nameUpdateSuccess = true;
    bool emailUpdateSuccess = true;
    bool passwordUpdateSuccess = true;
    bool telephoneUpdateSuccess = true;
    bool preferencesUpdateSuccess = true;

    if (newName != '') {
      nameUpdateSuccess = await appwriteSystem.updateName(newName: newName);
    }

    if (newEmail != '') {
      emailUpdateSuccess = await appwriteSystem.updateEmail(
          newEmail: newEmail, accountPassword: oldPassword);
    }

    if (newTelephone != '') {
      telephoneUpdateSuccess = await appwriteSystem.updateTelephone(
          newPhone: newTelephone, accountPassword: oldPassword);
    }

    if (newPassword != '') {
      passwordUpdateSuccess = await appwriteSystem.updatePassword(
          newPassword: newPassword, oldPassword: oldPassword);
    }

    if (newPreferences.isNotEmpty) {
      preferencesUpdateSuccess = await appwriteSystem.updatePreferences(
          newPreferences: newPreferences);
      if (newPreferences['cep'] != null || newPreferences['cep'] != '') {
        widget.userPrefs!.data['cep'] = newPreferences['cep'];
      }

      if (newPreferences['city'] != null || newPreferences['city'] != '') {
        widget.userPrefs!.data['city'] = newPreferences['city'];
      }

      if (newPreferences['address'] != null ||
          newPreferences['address'] != '') {
        widget.userPrefs!.data['address'] = newPreferences['address'];
      }

      if (newPreferences['complement'] != null ||
          newPreferences['complement'] != '') {
        widget.userPrefs!.data['complement'] = newPreferences['complement'];
      }
    }

    if (emailUpdateSuccess &&
        nameUpdateSuccess &&
        telephoneUpdateSuccess &&
        passwordUpdateSuccess &&
        preferencesUpdateSuccess) {
      return true;
    } else {
      return false;
    }
  }

  void makePrefsUpdate() async {
    bool updateSuccess = await updatePersonalDataInDB();

    if (updateSuccess) {
      Navigator.of(context).pop();
      await showErrorMessage(success);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(userPrefs: widget.userPrefs),
        ),
      );
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      await showErrorMessage(error);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bookTokAppBar,
      backgroundColor: paletteBlack,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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

                  const Divider(
                    color: paletteWhite,
                  ),

                  // Elements
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: PersonalDataTextField(
                            hintText: 'Nome',
                            isPassword: false,
                            textEditingController: nameEditingController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: PersonalDataTextField(
                            hintText: 'Email',
                            isPassword: false,
                            textEditingController: emailEditingController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: PersonalDataTextField(
                            hintText: 'Senha',
                            isPassword: true,
                            textEditingController: passwordEditingController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Expanded(
                                child: PersonalDataTextField(
                                  hintText: 'CEP',
                                  isPassword: false,
                                  textEditingController: cepEditingController,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: PersonalDataTextField(
                                  hintText: 'Cidade',
                                  isPassword: false,
                                  textEditingController: cityEditingController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: PersonalDataTextField(
                            hintText: 'Endereço',
                            isPassword: false,
                            textEditingController: addressEditingController,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Row(
                            children: [
                              Expanded(
                                child: PersonalDataTextField(
                                  hintText: 'Complemento',
                                  isPassword: false,
                                  textEditingController:
                                      complementEditingController,
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: PersonalDataTextField(
                                  hintText: 'Telefone',
                                  isPassword: false,
                                  textEditingController:
                                      telephoneEditingController,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SubmittButton(
                          buttonText: 'Salvar Alterações',
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  'Deseja continuar? insira sua senha: ',
                                  style: TextStyle(
                                    color: paletteWhite,
                                    fontSize: 18,
                                  ),
                                ),
                                backgroundColor: paletteBlack,
                                content: RegisterTemplate(
                                  hintText: 'Senha Atual',
                                  isPassword: true,
                                  textEditingController:
                                      oldPasswordEditingController,
                                  needErrorVerification: true,
                                  submittField: (p0) {},
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('Continuar'),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Container(
                                          color:
                                              const Color.fromARGB(61, 0, 0, 0),
                                          child: Center(
                                            child: Image.asset(
                                              'images/loading.gif',
                                              width: 85,
                                              height: 85,
                                            ),
                                          ),
                                        ),
                                      );
                                      makePrefsUpdate();
                                    },
                                  ),
                                  CupertinoDialogAction(
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Profile(userPrefs: widget.userPrefs),
                              ),
                            );
                          },
                          child: Text(
                            'Cancelar e Voltar',
                            style: TextStyle(
                                fontSize: 18, color: Colors.blue.shade400),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      
      bottomSheet: statusShowing != null
          ? BottomSheet(onClosing: () {}, builder: (context) => statusShowing!)
          : null,

      bottomNavigationBar: BookTokNavigation(
        home: MyIconButtonNavigator(
          route: Home(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.home),
          current: false,
        ),
        search: MyIconButtonNavigator(
          route: SearchScreen(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.search),
          current: false,
        ),
        cart: MyIconButtonNavigator(
          route: Carrinho(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.shopping_cart),
          current: false,
        ),
        user: MyIconButtonNavigator(
          route: Profile(userPrefs: widget.userPrefs),
          icon: const Icon(Icons.person),
          current: true,
        ),
      ),
    );
  }
}
