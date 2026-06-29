import 'package:app_farmacia/views/medicamentos_page.dart';
import 'package:app_farmacia/bloc/widgets/barra_pesquisa.dart';
import 'package:app_farmacia/bloc/widgets/cabecalho_home.dart';
import 'package:app_farmacia/views/vendas_page.dart';
import 'package:flutter/material.dart';
import '../bloc/widgets/botao.dart';
import '../bloc/widgets/produ_populares.dart';


class HomePagina extends StatelessWidget {
  const HomePagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Acessar vendas',
        backgroundColor: const Color(0xFF8A2A25),
        foregroundColor: Colors.white,
        child: const Icon(Icons.receipt_long),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VendasPage()),
          );
        },
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF2B0000), Color(0xFF6A1F1B)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CabecalhoHome(),
                  const SizedBox(height: 25),
                  //barra de pesquisa
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    child: const BarraPesquisa(),
                  ),

                  //botoes de categorias
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoriaButton(
                          texto: "Vitaminas",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MedicamentosPage(),
                                ),
                              );
                            
                          },
                        ),

                        CategoriaButton(
                          texto: "Dor",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (_) => const MedicamentosPage(),
                              ),
                            );
                          },
                        ),

                        CategoriaButton(
                          texto: "Gripe",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_)  => const MedicamentosPage(),
                              ),
                            );
                          },
                        ),

                        CategoriaButton(
                          texto: "Infantil",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                               builder: (_) => const MedicamentosPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Produtos Populares",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const ProduPopulares(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
