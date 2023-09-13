import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pi/constantes/cores.dart';

class PayTemplate extends StatefulWidget {
  String Text1;
  String Text2;

  PayTemplate({super.key, required this.Text1, required this.Text2});

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
  bool isChecked = false;
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
                              child: Checkbox(
                              checkColor: paletteBlack,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
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
                        child: Text(widget.Text2,
                          
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
