import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/remedio.dart';

//GERAR BANCO DE DADOS
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

//ARMAZENA A CONEXAO DO BANCO PARA REUTILIZAR DURANTE A EXECUCAO DO APLICATIVO.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('farmacia.db');
    return _database!;
  }
// Inicializa o banco de dados SQLite
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
// Criação da tabela de medicamentos
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE remedios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        descricao TEXT NOT NULL,
        preco REAL NOT NULL,
        categoria TEXT NOT NULL
      )
    ''');
  }

      //CREATE
  Future<int> inserirRemedio(Remedio remedio) async {
    final db = await database;

    return await db.insert(
      'remedios',
      remedio.toMap(),
    );
  }
// READ - Lista os medicamentos por categoria
  Future<List<Remedio>> listarRemedios(
    String categoria,
  ) async {
    final db = await database;

    final resultado = await db.query(
      'remedios',
      where: 'categoria = ?',
      whereArgs: [categoria],
    );

    return resultado
        .map((e) => Remedio.fromMap(e))
        .toList();
  }

    //UPDATE
  Future<int> atualizarRemedio(
    Remedio remedio,
  ) async {
    final db = await database;

    return await db.update(
      'remedios',
      remedio.toMap(),
      where: 'id = ?',
      whereArgs: [remedio.id],
    );
  }
// DELETE 
  Future<int> deletarRemedio(
    int id,
  ) async {
    final db = await database;

    return await db.delete(
      'remedios',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

