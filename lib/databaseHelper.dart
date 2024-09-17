import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'books_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE books(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, authors TEXT, thumbnail TEXT, \"order\" INTEGER)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE books ADD COLUMN "order" INTEGER');
        }
      },
      version: 2,
    );
  }

  Future<void> insertBook(Map<String, dynamic> book) async {
    final db = await database;
    try {
      await db.insert(
        'books',
        book,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Erro ao inserir livro: $e');
    }
  }

  Future<void> deleteBook(int id) async {
    final db = await database;
    try {
      await db.delete(
        'books',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Erro ao deletar livro: $e');
    }
  }

  Future<void> updateBookOrder(List<Map<String, dynamic>> books) async {
    final db = await database;
    try {
      for (var i = 0; i < books.length; i++) {
        await db.update(
          'books',
          {'order': i},
          where: 'id = ?',
          whereArgs: [books[i]['id']],
        );
      }
    } catch (e) {
      print('Erro ao atualizar a ordem dos livros: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> result = await db.query('books', orderBy: '"order" ASC');
      print('Livros retornados: $result'); // Log para depuração
      return result;
    } catch (e) {
      print('Erro ao obter livros: $e');
      return [];
    }
  }
}
