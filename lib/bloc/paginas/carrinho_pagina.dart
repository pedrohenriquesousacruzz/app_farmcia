import 'package:flutter/material.dart';
import '../../models/remedio.dart';

class CarrinhoPagina extends StatelessWidget {
  final List<Remedio> remedios;

  const CarrinhoPagina({
    super.key,
    required this.remedios,
  });

  String obterImagem(String nome) {
    switch (nome.toLowerCase()) {
      case 'dorflex':
        return 'assets/Image/dorflex.png';

      case 'dipirona':
        return 'assets/Image/dipirona.png';

      case 'benegrip':
        return 'assets/Image/benegripe.png';

      case 'expec':
        return 'assets/Image/expec.png';

      case 'vitamina c':
        return 'assets/Image/vitamina_c_sf.png';

      case 'omega 3':
        return 'assets/Image/omega3.png';

      default:
        return 'assets/Image/dorflex.png';
    }
  }

  double get total {
    return remedios.fold(
      0,
      (soma, item) => soma + item.preco,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
//degrade
      body: Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black,
        Color(0xFF2B0000),
        Color(0xFF6A1F1B),
      ],
    ),
  ),
     child:  remedios.isEmpty
          ? const Center(
              child: Text(
          "Carrinho vazio",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
              
            
          : Column(
              children: [
                Expanded(
                  //exibir
                  child: ListView.builder(
                    itemCount: remedios.length,
                    itemBuilder: (context, index) {
                      final r = remedios[index];

                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.asset(
                            obterImagem(r.nome),
                            width: 50,
                            height: 50,
                          ),

                          title: Text(r.nome),

                          subtitle: Text(
                            "R\$ ${r.preco.toStringAsFixed(2)}",
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Total: R\$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
    )
    );
  }
}