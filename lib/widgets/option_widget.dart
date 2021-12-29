import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTapHandler;
  const OptionWidget({
    this.isSelected = false,
    required this.title,
    required this.onTapHandler,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        primary: isSelected ? Colors.white : Colors.transparent,
        onPrimary: isSelected ? Colors.black : Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(
          width: 1.5,
          color: Colors.white,
        ),
      ),
      onPressed: onTapHandler,
      child: Text(
        title,
      ),
    );
  }
}
