import 'package:flutter/material.dart';
import 'databaseHelper.dart'; // Certifique-se de que o caminho está correto

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
        backgroundColor: Color(0xFF003F5C), // Mantenha a cor azul escura
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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Text(
              'Autor(es): $authors',
              style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descrição:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 8),
            Text(description, style: TextStyle(color: Colors.blueGrey[700])),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _addToWishList();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Livro adicionado à lista de desejos!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003F5C), // Cor do botão
              ),
              child: const Text('Adicionar à Lista de Desejos'),
            ),
          ],
        ),
      ),
    );
  }
}
