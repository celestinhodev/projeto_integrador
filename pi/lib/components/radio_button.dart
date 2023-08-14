import 'package:flutter/material.dart';

class MyRadioOption<T> extends StatelessWidget {

  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final Color selectedColor;
  final Color unselectedColor;
  final ValueChanged<T?> onChanged;

  const MyRadioOption({
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.selectedColor,
    required this.unselectedColor,
    required this.onChanged,
  });

  Widget _buildLabel() {
    final bool isSelected = value == groupValue;

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : unselectedColor,
        borderRadius: BorderRadius.circular(90),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onChanged(value),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(),
            ],
          ),
        ),
      ),
    );
  }
}