import 'package:flutter/material.dart';

class WarningLoadWidget extends StatelessWidget {
  final String messageText;

  const WarningLoadWidget({super.key, required this.messageText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.production_quantity_limits, // Icono de carita triste
          size: 150.0, // Tamaño del icono
          color: Colors.white,
          shadows: [
            Shadow(color: Colors.black38, blurRadius: 5, offset: Offset(2, 2))
          ],
          // Color del icono
        ),
        Text(
          messageText,
          style: const TextStyle(color: Colors.white, fontSize: 20, shadows: [
            Shadow(color: Colors.black54, blurRadius: 2, offset: Offset(2, 2))
          ]),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}