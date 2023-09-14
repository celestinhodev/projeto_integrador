import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi/constantes/cores.dart';

class PayTemplate extends StatefulWidget {
  String Text1;
  String Text2;
  int value;
  int groupValue;
  void Function(Object?) onChanged;

  PayTemplate({
    super.key,
    required this.Text1,
    required this.Text2,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  @override
  State<PayTemplate> createState() => _PayTemplateState();
}

class _PayTemplateState extends State<PayTemplate> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    return paletteGrey;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: paletteGrey,
          width: 2,
        ),
      ),
      child: Container(
        color: palettWhiteGrey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Transform.scale(
                      scale: 1.5,
                      child: Radio(
                        groupValue: widget.groupValue,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: widget.value,
                        onChanged: widget.onChanged,
                      ),
                    ),
                  ),
                  Text(
                    widget.Text1,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 0, 8),
                child: Text(
                  widget.Text2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 99,
                  style: const TextStyle(
                    fontSize: 16,
                    color: paletteBlack,
                    height: 1.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
