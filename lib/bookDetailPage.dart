import 'package:flutter/material.dart';
import 'databaseHelper.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String authors;
  final String description;
  final String thumbnail;

  const BookDetailPage({
    super.key,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnail,
  });

  Future<void> _addToWishList() async {
    await DatabaseHelper().insertBook({
      'title': title,
      'authors': authors,
      'thumbnail': thumbnail,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnail.isNotEmpty)
              Center(
                child: Image.network(
                  thumbnail,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'Título: $title',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Autor(es): $authors',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descrição:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addToWishList();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Livro adicionado à lista de desejos!')),
                );
              },
              child: const Text('Adicionar à Lista de Desejos'),
            ),
          ],
        ),
      ),
    );
  }
}
