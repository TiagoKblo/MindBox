import 'package:flutter/material.dart';
import 'databaseHelper.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<Map<String, dynamic>> _wishList = [];

  @override
  void initState() {
    super.initState();
    _loadWishList();
  }

  Future<void> _loadWishList() async {
    try {
      final wishList = await DatabaseHelper().getBooks();
      setState(() {
        _wishList = List.from(wishList); // Assegure-se de que seja uma lista mutável
      });
      print('Lista de desejos carregada: $_wishList'); // Log para depuração
    } catch (e) {
      print('Erro ao carregar a lista de desejos: $e');
    }
  }

  Future<void> _deleteBook(int id) async {
    try {
      await DatabaseHelper().deleteBook(id);
      _loadWishList(); // Recarregar a lista após a exclusão
    } catch (e) {
      print('Erro ao deletar livro: $e');
    }
  }

  Future<void> _updateBookOrder() async {
    try {
      final db = await DatabaseHelper().database;
      for (var i = 0; i < _wishList.length; i++) {
        await db.update(
          'books',
          {'order': i},
          where: 'id = ?',
          whereArgs: [_wishList[i]['id']],
        );
      }
    } catch (e) {
      print('Erro ao atualizar a ordem dos livros: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003F5C),
        title: const Text('Lista de Desejos'),
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) async {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }

          final item = _wishList.removeAt(oldIndex);
          final newList = List.of(_wishList); // Crie uma nova lista mutável
          newList.insert(newIndex, item);

          setState(() {
            _wishList = newList;
          });

          // Atualize a ordem no banco de dados
          await _updateBookOrder();
        },
        children: _wishList.map((book) {
          final int id = book['id'];
          final String title = book['title'] ?? 'Título desconhecido';
          final String authors = book['authors'] ?? 'Autor desconhecido';
          final String thumbnail = book['thumbnail'] ?? '';

          return ListTile(
            key: ValueKey(id), // Adicione uma chave única para cada item
            title: Text(title, style: TextStyle(color: Colors.blueGrey)),
            subtitle: Text(authors, style: TextStyle(color: Colors.blueGrey[600])),
            leading: thumbnail.isNotEmpty
                ? Image.network(
              thumbnail,
              width: 50,
              height: 75,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported);
              },
            )
                : const Icon(Icons.image_not_supported),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteBook(id);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
