import 'package:flutter/material.dart';
import '../services/cliente_service.dart';
import '../utils/gradiente.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({super.key});

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  Map<String, dynamic>? _cliente;
  bool _carregando = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _salvando = false;
  bool _editando = false;

  @override
  void initState() {
    super.initState();
    _verificarCliente();
  }

  Future<void> _verificarCliente() async {
    setState(() => _carregando = true);
    try {
      _cliente = await ClienteService.buscarPrimeiro();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao carregar dados')));
    }
    if (!mounted) return;
    setState(() => _carregando = false);
  }

  Future<void> _criarOuAtualizar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);
    final name = _nameController.text;
    try {
      if (_editando && _cliente != null) {
        _cliente = await ClienteService.atualizar(_cliente!['id'], name);
      } else {
        _cliente = await ClienteService.criar(name);
      }
      _editando = false;
      _nameController.clear();
      setState(() {});
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao salvar')));
    }
    if (!mounted) return;
    setState(() => _salvando = false);
  }

  Future<void> _excluir() async {
    if (_cliente == null) return;
    try {
      await ClienteService.excluir(_cliente!['id']);
      if (!mounted) return;
      setState(() {
        _cliente = null;
        _editando = false;
        _nameController.clear();
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Erro ao excluir')));
    }
  }

  void _habilitarEdicao() {
    if (_cliente != null) {
      _nameController.text = _cliente!['name'] ?? '';
      setState(() => _editando = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Perfil')),
      body: Container(
        decoration: const BoxDecoration(gradient: GradienteFarmacia.gradient),
        child: _carregando
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : _editando || _cliente == null
            ? _buildFormulario()
            : _buildDadosCliente(),
      ),
    );
  }

  Widget _buildFormulario() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Nome do cliente',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              validator: (v) => v!.isEmpty ? 'Informe o nome' : null,
            ),
            const SizedBox(height: 30),
            _salvando
                ? const CircularProgressIndicator(color: Colors.white)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color(0xFF8A2A25),
                    ),
                    onPressed: _criarOuAtualizar,
                    child: Text(
                      _editando ? 'Atualizar' : 'Criar',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDadosCliente() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            Text(
              _cliente!['name'] ?? 'Sem nome',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cliente #${_cliente!['id']}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A2A25),
                  ),
                  onPressed: _habilitarEdicao,
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[800],
                  ),
                  onPressed: _excluir,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
