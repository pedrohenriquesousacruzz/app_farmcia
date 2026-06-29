import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicamentoService {
  static const String baseUrl =
      'https://6a400abe9b6d371e838178e9.mockapi.io';
  static const String endpoint = 'medicamentos';

  static Future<List<Map<String, dynamic>>> listar() async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
    );

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .cast<Map<String, dynamic>>();
    }

    throw Exception('Erro ao carregar medicamentos');
  }

  static Future<Map<String, dynamic>> criar(
    String nome,
    double preco,
    int quantidade,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nome': nome,
        'preco': preco,
        'quantidade': quantidade,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    throw Exception('Erro ao criar medicamento');
  }

  static Future<Map<String, dynamic>> atualizar(
    String id,
    String nome,
    double preco,
    int quantidade,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'nome': nome,
        'preco': preco,
        'quantidade': quantidade,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('Erro ao atualizar medicamento');
  }

  static Future<void> excluir(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$endpoint/$id'),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 204) {
      throw Exception('Erro ao excluir medicamento');
    }
  }
}