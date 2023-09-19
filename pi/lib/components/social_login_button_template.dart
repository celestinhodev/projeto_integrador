import 'package:flutter/material.dart';
import 'package:pi/constantes/cores.dart';

// ignore: must_be_immutable
class SocialLoginButton extends StatefulWidget {
  void Function() onTap;
  String socialImagePath;
  String socialText;
  SocialLoginButton({
    super.key,
    required this.socialImagePath,
    required this.socialText,
    required this.onTap,
  });

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 350,
        height: 50,
        color: palettWhiteGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 0, 7),
              child: Image.asset(widget.socialImagePath),
            ),
            Center(
              child: Text(
                widget.socialText,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: SizedBox(
                width: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
