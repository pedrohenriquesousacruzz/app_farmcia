import 'package:flutter/material.dart';
import 'produto.dart';
class ProduPopulares extends StatelessWidget {
  const ProduPopulares({super.key});

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ProdutoCard(
          nome: "Dorflex",
          preco: "R\$ 24,90",
          imagem: "assets/Image/dorflex.png",
        ),

        ProdutoCard(
          nome: "Dipirona",
          preco: "R\$ 22,90",
          imagem: "assets/Image/dipirona.png",
        ),

        ProdutoCard(
          nome: "Benegrip",
          preco: "R\$ 23,90",
          imagem: "assets/Image/benegripe.png",
        ),

        ProdutoCard(
          nome: "Expec",
          preco: "R\$ 29,90",
          imagem: "assets/Image/expec.png",
        ),

        ProdutoCard(
          nome: "Vitamina C",
          preco: "R\$ 53,90",
          imagem: "assets/Image/vitamina_c_sf.png",
        ),

        ProdutoCard(
          nome: "Omega 3",
          preco: "R\$ 65,90",
          imagem: "assets/Image/omega3.png",
        ),
      ],
    ),
  );
}
}