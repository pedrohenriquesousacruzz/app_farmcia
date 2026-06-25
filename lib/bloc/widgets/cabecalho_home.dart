import 'package:flutter/material.dart';

class CabecalhoHome extends StatelessWidget {
  const CabecalhoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Olá, Usuario",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "Bem-vindo a UperFarma",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}