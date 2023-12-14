import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Size size;
  final String value;
  const CardWidget({super.key, required this.size, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size.width * 0.22,
      width: size.width * 0.22,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.inversePrimary,
            blurRadius: 0.2,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Text(
        value,
        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
