import 'dart:convert';
import 'package:http/http.dart' as http;

class VendaService {
  static const String baseUrl =
      'https://6a400abe9b6d371e838178e9.mockapi.io';

  static const String endpoint = 'vendas';

  static Future<List<Map<String, dynamic>>> listar() async {
    final res = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
    );

    if (res.statusCode == 200) {
      final List<dynamic> dados = json.decode(res.body);

      return dados
          .map((venda) => Map<String, dynamic>.from(venda))
          .toList();
    }

    throw Exception('Erro ao carregar vendas');
  }

  static Future<Map<String, dynamic>> criar(
    String nomeCliente,
    String nomeMedicamento,
    int quantidade,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nome_cliente': nomeCliente,
        'nome_medicamento': nomeMedicamento,
        'quantidade': quantidade,
      }),
    );

    if (res.statusCode == 201 || res.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(res.body));
    }

    throw Exception('Erro ao criar venda');
  }

  static Future<Map<String, dynamic>> atualizar(
    String id,
    String nomeCliente,
    String nomeMedicamento,
    int quantidade,
  ) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nome_cliente': nomeCliente,
        'nome_medicamento': nomeMedicamento,
        'quantidade': quantidade,
      }),
    );

    if (res.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(res.body));
    }

    throw Exception('Erro ao atualizar venda');
  }

  static Future<void> excluir(String id) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/$endpoint/$id'),
    );

    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Erro ao excluir venda');
    }
  }
}