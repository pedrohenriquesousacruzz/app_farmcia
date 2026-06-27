import 'package:app_farmacia/views/cadastro_remedios.dart';
import 'package:app_farmacia/views/carrinho_pagina.dart';
import 'package:flutter/material.dart';

import '../models/remedio.dart';
import 'cadastro_remedios.dart';

class RemediosPagina extends StatefulWidget {
  final String categoria;

  const RemediosPagina({super.key, required this.categoria});

  @override
  State<RemediosPagina> createState() => _RemediosPaginaState();
}

class _RemediosPaginaState extends State<RemediosPagina> {
  //LISTA DE MEDICAMENTOS CARREGADOS DO BANCO
  List<Remedio> remedios = [];

  // MEDICAMENTOS SELECIONAS PARA O CARRINHO
  List<int> remediosSelecionados = [];

  //RETORNAR A IMAGEM DOS MEDICAMENTOS
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

  @override
  //EXECUTA QUANDO ABRIR A TELA
  //READ
  void initState() {
    super.initState();
    carregarRemedios();
  }

  //MEDICAMENTOS DA CATEGORIA SELECIONADA
  Future<void> carregarRemedios() async {}

  //DELETA UM MEDICAMENTO DO BANCO
  Future<void> excluirRemedio(int id) async {}

  //CONSTROI A INTERFACE DA TELA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoria,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 86, 35, 30),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CadastroRemedioPage(categoria: widget.categoria),
                ),
              ).then((_) {
                carregarRemedios();
              });
            },
          ),
        ],
      ),

      //DEGRADE DA TELA
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF2B0000), Color(0xFF6A1F1B)],
          ),
        ),

        //APARECE QUANDO TEM NENHUM REMEDIO
        child: remedios.isEmpty
            ? const Center(
                child: Text(
                  "Nenhum medicamento cadastrado",
                  style: TextStyle(color: Colors.white),
                ),
              )
            // Lista os medicamentos cadastrados
            : ListView.builder(
                itemCount: remedios.length,
                itemBuilder: (context, index) {
                  final remedio = remedios[index];

                  //Cartão de exibição de cada medicamento
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.asset(
                        obterImagem(remedio.nome),
                        width: 50,
                        height: 50,
                      ),

                      //NOME DO REMEDIO
                      title: Text(remedio.nome),

                      //DESCRICAO E PRECO DO REMEDIO
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(remedio.descricao),
                          Text("R\$ ${remedio.preco.toStringAsFixed(2)}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //CAIXA DE CECK PARA ADCIONAR AO CARRINHO
                          Checkbox(
                            value: remediosSelecionados.contains(remedio.id),
                            onChanged: (value) {
                              setState(() {
                                if (value == true) {
                                  remediosSelecionados.add(remedio.id!);
                                } else {
                                  remediosSelecionados.remove(remedio.id);
                                }
                              });
                            },
                          ),

                          //BOTAO PARA EXCLUIR REMEDIO
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              excluirRemedio(remedio.id!);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

        //BOTAO DO CARRINHO DE COMPRAS
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          //FLITRAR OS REMEDIOS MARCADOS
          final selecionados = remedios
              .where((r) => remediosSelecionados.contains(r.id))
              .toList();

          //ABRIR A TELA DO CARRINHO
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CarrinhoPagina(remedios: selecionados),
            ),
          );
        },
      ),
    );
  }
}
