import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/remedio.dart';

class CadastroRemedioPage extends StatefulWidget {
  final String categoria;

  const CadastroRemedioPage({
    super.key,
    required this.categoria,
  });

  @override
  State<CadastroRemedioPage> createState() =>
      _CadastroRemedioPageState();
}

class _CadastroRemedioPageState
    extends State<CadastroRemedioPage> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final precoController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    precoController.dispose();
    super.dispose();
  }

  Future<void> salvarRemedio() async {
    if (_formKey.currentState!.validate()) {
      final remedio = Remedio(
        nome: nomeController.text,
        descricao: descricaoController.text,
        preco: double.parse(precoController.text),
        categoria: widget.categoria,
      );

      await DatabaseHelper.instance
          .inserirRemedio(remedio);

      if (!mounted) return;

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar ${widget.categoria}',
        ),
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
      child:  Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: descricaoController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe a descrição';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: precoController,
                style: const TextStyle(color: Colors.white),
                keyboardType:
                    TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe o preço';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: salvarRemedio,
                child: const Text(
                  'Salvar',
                ),
              ),
            ],
          ),
        ),
      ),
    )
    );
  }
}