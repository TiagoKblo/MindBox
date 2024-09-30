import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/bookDetailPage.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({super.key});

  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final TextEditingController _controller = TextEditingController();
  List books = [];
  Set<String> favoriteBooks = Set<String>(); // Conjunto para armazenar IDs dos livros favoritos

  Future<void> _searchBooks(String query) async {
    final url = 'https://www.googleapis.com/books/v1/volumes?q=$query';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          books = data['items'] ?? [];
        });
        print('Resposta da API: $data'); // Log para depuração
      } else {
        print('Erro na requisição: ${response.statusCode}');
        throw Exception('Erro ao buscar livros');
      }
    } catch (e) {
      print('Exceção ao buscar livros: $e');
    }
  }

  void _toggleFavorite(String bookId) {
    setState(() {
      if (favoriteBooks.contains(bookId)) {
        favoriteBooks.remove(bookId);
      } else {
        favoriteBooks.add(bookId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003F5C), // Cor do AppBar
        title: const Text('Pesquisar Livros'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Pesquisar livro',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchBooks(_controller.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? Center(child: Text('Nenhum livro encontrado', style: TextStyle(color: Colors.blueGrey)))
                : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index]['volumeInfo'];
                final String bookId = books[index]['id'];
                final String title = book['title'] ?? 'Título desconhecido';
                final String authors = book['authors']?.join(', ') ?? 'Autor desconhecido';
                final String description = book['description'] ?? 'Sem descrição disponível';
                final String thumbnail = book['imageLinks']?['thumbnail'] ?? '';

                final bool isFavorite = favoriteBooks.contains(bookId);

                return ListTile(
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
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      _toggleFavorite(bookId);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(
                          title: title,
                          authors: authors,
                          description: description,
                          thumbnail: thumbnail,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
