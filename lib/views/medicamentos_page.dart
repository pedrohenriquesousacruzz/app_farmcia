import 'package:flutter/material.dart';
import '../services/medicamento_service.dart';
import '../utils/gradiente.dart';

class MedicamentosPage extends StatefulWidget {
  const MedicamentosPage({super.key});

  @override
  State<MedicamentosPage> createState() => _MedicamentosPageState();
}

class _MedicamentosPageState extends State<MedicamentosPage> {
  List<Map<String, dynamic>> _medicamentos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    try {
      _medicamentos = await MedicamentoService.listar();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    if (mounted) {
      setState(() => _carregando = false);
    }
  }

  void _abrirFormulario({Map<String, dynamic>? medicamento}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FormularioMedicamento(
          medicamento: medicamento,
          aoSalvar: _carregar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicamentos"),
        backgroundColor: const Color(0xFF8A2A25),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 165, 48, 42),
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: GradienteFarmacia.gradient),
        child: _carregando
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : ListView.builder(
                itemCount: _medicamentos.length,
                itemBuilder: (context, index) {
                  final medicamento = _medicamentos[index];

                  return Card(
                    color: Colors.white10,
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(
                        medicamento['nome'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Preço: R\$ ${medicamento['preco']}\nQuantidade: ${medicamento['quantidade']}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _abrirFormulario(medicamento: medicamento);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await MedicamentoService.excluir(
                                medicamento['id'],
                              );
                              if (mounted) _carregar();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _FormularioMedicamento extends StatefulWidget {
  final Map<String, dynamic>? medicamento;
  final VoidCallback aoSalvar;

  const _FormularioMedicamento({this.medicamento, required this.aoSalvar});

  @override
  State<_FormularioMedicamento> createState() => _FormularioMedicamentoState();
}

class _FormularioMedicamentoState extends State<_FormularioMedicamento> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  bool _salvando = false;

  @override
  void initState() {
    super.initState();

    if (widget.medicamento != null) {
      _nomeController.text = widget.medicamento!['nome'] ?? '';
      _precoController.text = widget.medicamento!['preco'].toString();
      _quantidadeController.text = widget.medicamento!['quantidade'].toString();
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _salvando = true;
    });

    try {
      if (widget.medicamento == null) {
        await MedicamentoService.criar(
          _nomeController.text,
          double.parse(_precoController.text),
          int.parse(_quantidadeController.text),
        );
      } else {
        await MedicamentoService.atualizar(
          widget.medicamento!['id'],
          _nomeController.text,
          double.parse(_precoController.text),
          int.parse(_quantidadeController.text),
        );
      }

      widget.aoSalvar();

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }

    if (mounted) {
      setState(() {
        _salvando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.medicamento == null
              ? "Novo Medicamento"
              : "Editar Medicamento",
        ),
        backgroundColor: const Color(0xFF8A2A25),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: GradienteFarmacia.gradient),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o nome";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _precoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Preço",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o preço";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quantidade",
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe a quantidade";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2A25),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _salvando ? null : _salvar,
                child: _salvando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
