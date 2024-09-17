import 'package:flutter/material.dart';
import 'databaseHelper.dart'; // Certifique-se de que o caminho está correto

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
    final wishList = await DatabaseHelper().getBooks();
    setState(() {
      _wishList = wishList;
    });
  }

  Future<void> _deleteBook(int id) async {
    await DatabaseHelper().deleteBook(id);
    _loadWishList(); // Recarregar a lista após a exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Desejos'),
      ),
      body: ListView.builder(
        itemCount: _wishList.length,
        itemBuilder: (context, index) {
          final book = _wishList[index];
          final int id = book['id'];
          final String title = book['title'] ?? 'Título desconhecido';
          final String authors = book['authors'] ?? 'Autor desconhecido';
          final String thumbnail = book['thumbnail'] ?? '';

          return ListTile(
            title: Text(title),
            subtitle: Text(authors),
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
        },
      ),
    );
  }
}
