import 'package:flutter/material.dart';

class ProdutoCard extends StatelessWidget {
  final String nome;
  final String preco;
  final String imagem;

  const ProdutoCard({
    super.key,
    required this.nome,
    required this.preco,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
  width: 150,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 84, 25, 25),
    borderRadius: BorderRadius.circular(20),
  ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              imagem,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            nome,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            preco,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}