import 'package:flutter/material.dart';
import '../services/medicamento_service.dart';
import '../utils/gradiente.dart';
import '../widgets/barra_pesquisa.dart';
import '../widgets/cabecalho_home.dart';
import 'medicamentos_page.dart';
import 'vendas_page.dart';

class HomePagina extends StatefulWidget {
  const HomePagina({super.key});

  @override
  State<HomePagina> createState() => _HomePaginaState();
}

class _HomePaginaState extends State<HomePagina> {
  List<Map<String, dynamic>> _medicamentos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
  }

  Future<void> _carregarMedicamentos() async {
    setState(() => _carregando = true);
    try {
      _medicamentos = await MedicamentoService.listar();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar medicamentos: $e')),
        );
      }
    }
    if (mounted) {
      setState(() => _carregando = false);
    }
  }

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
        decoration: const BoxDecoration(gradient: GradienteFarmacia.gradient),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CabecalhoHome(),
                  const SizedBox(height: 25),
                  // Barra de pesquisa (visual, não funcional)
                  const BarraPesquisa(),
                  const SizedBox(height: 20),
                  // Botão único para gerenciar medicamentos
                  ElevatedButton.icon(
                    icon: const Icon(Icons.medication, color: Colors.white),
                    label: const Text(
                      'Gerenciar Medicamentos',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2A25),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MedicamentosPage(),
                        ),
                      ).then(
                        (_) => _carregarMedicamentos(),
                      ); // atualiza ao voltar
                    },
                  ),
                  const SizedBox(height: 30),
                  // Título da seção de medicamentos reais
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Medicamentos Disponíveis',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Lista de medicamentos vindos da API
                  if (_carregando)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  else if (_medicamentos.isEmpty)
                    const Text(
                      'Nenhum medicamento cadastrado.',
                      style: TextStyle(color: Colors.white70),
                    )
                  else
                    ..._medicamentos.map(
                      (med) => Card(
                        color: Colors.white10,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text(
                            med['nome'] ?? 'Sem nome',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'R\$ ${med['preco']} | Estoque: ${med['quantidade']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
