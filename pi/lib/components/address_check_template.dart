import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

// ignore: must_be_immutable
class AddressCheckTemplate extends StatefulWidget {
  String text1;
  String cep;
  String city;
  String address;
  String complement;

  AddressCheckTemplate({
    super.key,
    required this.text1,
    required this.cep,
    required this.city,
    required this.address,
    required this.complement,
  });

  @override
  State<AddressCheckTemplate> createState() => _AddressCheckTemplateState();
}

class _AddressCheckTemplateState extends State<AddressCheckTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 250, maxWidth: 200),
      decoration: BoxDecoration(
        color: palettWhiteGrey,
        border: Border.all(
          color: paletteGrey,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text1,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5,),
            const Text(
              'Cep: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
            Text(
              widget.cep,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
            const SizedBox(height: 5,),
            const Text(
              'Cidade: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(
                widget.city,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 16,
                  color: paletteBlack,
                ),
              ),
            ),
            const SizedBox(height: 5,),
            const Text(
              'Endereço: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
            Text(
              widget.address,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
            const SizedBox(height: 5,),
            const Text(
              'Complemento: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
            Text(
              widget.complement,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 16,
                color: paletteBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
