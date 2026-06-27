import 'package:flutter/material.dart';
import 'package:app_farmacia/services/cliente_service.dart';
import 'package:app_farmacia/views/usuario_page.dart';

class CabecalhoHome extends StatefulWidget {
  const CabecalhoHome({super.key});

  @override
  State<CabecalhoHome> createState() => _CabecalhoHomeState();
}

class _CabecalhoHomeState extends State<CabecalhoHome> {
  String _nomeCliente = 'Usuario';

  @override
  void initState() {
    super.initState();
    _carregarNome();
  }

  Future<void> _carregarNome() async {
    final cliente = await ClienteService.buscarPrimeiro();
    if (cliente != null && mounted) {
      setState(() {
        _nomeCliente = cliente['name'] ?? 'Usuario';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá, $_nomeCliente",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              "Bem-vindo a UperFarma",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ClientePage()),
            );
          },
          child: const CircleAvatar(radius: 24, child: Icon(Icons.person)),
        ),
      ],
    );
  }
}
