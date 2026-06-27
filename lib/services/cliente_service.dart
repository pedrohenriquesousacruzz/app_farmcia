import 'package:http/http.dart' as http;
import 'dart:convert';

class ClienteService {
  static const String baseUrl = 'https://6a400abe9b6d371e838178e9.mockapi.io';
  static const String endpoint = 'clientes';

  static Future<Map<String, dynamic>?> buscarPrimeiro() async {
    final res = await http.get(Uri.parse('$baseUrl/$endpoint'));
    if (res.statusCode == 200) {
      final List<dynamic> lista = json.decode(res.body);
      if (lista.isNotEmpty) return lista.first as Map<String, dynamic>;
    }
    return null;
  }

  static Future<Map<String, dynamic>> criar(String name) async {
    final res = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return json.decode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Erro ao criar cliente');
  }

  static Future<Map<String, dynamic>> atualizar(String id, String name) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    if (res.statusCode == 200) {
      return json.decode(res.body) as Map<String, dynamic>;
    }
    throw Exception('Erro ao atualizar cliente');
  }

  static Future<void> excluir(String id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$endpoint/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Erro ao excluir cliente');
    }
  }
}
