import 'package:app_farmacia/bloc/gradiente.dart';
import 'package:flutter/material.dart';
import '../services/venda_service.dart';

class VendasPage extends StatefulWidget {
  const VendasPage({super.key});

  @override
  State<VendasPage> createState() => _VendasPageState();
}

class _VendasPageState extends State<VendasPage> {
  List<Map<String, dynamic>> _vendas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    try {
      _vendas = await VendaService.listar();
    } catch (_) {
      _vendas = [];
    }

    if (mounted) {
      setState(() => _carregando = false);
    }
  }

  void _abrirFormulario({Map<String, dynamic>? venda}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _FormularioVenda(venda: venda, aoSalvar: _carregar),
      ),
    );
  }

  Future<void> _excluirVenda(String id) async {
    try {
      await VendaService.excluir(id);
      await _carregar();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Venda excluída com sucesso.')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível excluir a venda.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vendas')),
      body: Container(
        decoration: const BoxDecoration(gradient: GradienteFarmacia.gradient),
        child: _carregando
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : _vendas.isEmpty
            ? const Center(
                child: Text(
                  'Nenhuma venda cadastrada',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              )
            : RefreshIndicator(
                onRefresh: _carregar,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 90),
                  itemCount: _vendas.length,
                  itemBuilder: (context, index) {
                    final venda = _vendas[index];

                    final nomeCliente =
                        venda['nome_cliente']?.toString() ??
                        'Cliente não informado';

                    final nomeMedicamento =
                        venda['nome_medicamento']?.toString() ??
                        'Medicamento não informado';

                    final quantidade = venda['quantidade']?.toString() ?? '0';

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      color: Colors.white.withOpacity(0.12),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF8A2A25),
                          child: Icon(Icons.receipt_long, color: Colors.white),
                        ),
                        title: Text(
                          nomeMedicamento,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Cliente: $nomeCliente\nQuantidade: $quantidade',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                _abrirFormulario(venda: venda);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                _excluirVenda(venda['id'].toString());
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nova venda',
        backgroundColor: const Color(0xFF8A2A25),
        foregroundColor: Colors.white,
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FormularioVenda extends StatefulWidget {
  final Map<String, dynamic>? venda;
  final VoidCallback aoSalvar;

  const _FormularioVenda({this.venda, required this.aoSalvar});

  @override
  State<_FormularioVenda> createState() => _FormularioVendaState();
}

class _FormularioVendaState extends State<_FormularioVenda> {
  final _formKey = GlobalKey<FormState>();

  final _nomeClienteController = TextEditingController();
  final _nomeMedicamentoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  bool _salvando = false;

  @override
  void initState() {
    super.initState();

    if (widget.venda != null) {
      _nomeClienteController.text =
          widget.venda!['nome_cliente']?.toString() ?? '';

      _nomeMedicamentoController.text =
          widget.venda!['nome_medicamento']?.toString() ?? '';

      _quantidadeController.text =
          widget.venda!['quantidade']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _nomeClienteController.dispose();
    _nomeMedicamentoController.dispose();
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);

    final nomeCliente = _nomeClienteController.text.trim();
    final nomeMedicamento = _nomeMedicamentoController.text.trim();
    final quantidade = int.parse(_quantidadeController.text.trim());

    try {
      if (widget.venda == null) {
        await VendaService.criar(nomeCliente, nomeMedicamento, quantidade);
      } else {
        await VendaService.atualizar(
          widget.venda!['id'].toString(),
          nomeCliente,
          nomeMedicamento,
          quantidade,
        );
      }

      widget.aoSalvar();

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao salvar a venda.')),
        );
      }
    }

    if (mounted) {
      setState(() => _salvando = false);
    }
  }

  InputDecoration _decoracaoCampo(String texto) {
    return InputDecoration(
      labelText: texto,
      labelStyle: const TextStyle(color: Colors.white70),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white54),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.venda != null;

    return Scaffold(
      appBar: AppBar(title: Text(editando ? 'Editar Venda' : 'Nova Venda')),
      body: Container(
        decoration: const BoxDecoration(gradient: GradienteFarmacia.gradient),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeClienteController,
                style: const TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.words,
                decoration: _decoracaoCampo('Nome do cliente'),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome do cliente';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nomeMedicamentoController,
                style: const TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.words,
                decoration: _decoracaoCampo('Nome do medicamento'),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o nome do medicamento';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantidadeController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: _decoracaoCampo('Quantidade'),
                validator: (valor) {
                  final quantidade = int.tryParse(valor?.trim() ?? '');

                  if (quantidade == null || quantidade <= 0) {
                    return 'Informe uma quantidade maior que zero';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 30),
              _salvando
                  ? const CircularProgressIndicator(color: Colors.white)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF8A2A25),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _salvar,
                      child: Text(editando ? 'Salvar alterações' : 'Salvar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
