import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'aboutPage.dart'; // Importar a página Sobre
=======
>>>>>>> 32b33475b7bc458f64500ab69a59eb7e6a414408

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003F5C),
        title: Text(title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo ou Imagem de Cabeçalho
              ClipOval(
                child: SizedBox(
                  width: screenSize.width * 0.6, // Largura da imagem
                  height: screenSize.width * 0.6, // Altura da imagem
                  child: Image.asset(
                    'assets/images/logo4.jpeg', // Caminho do logotipo
                    fit: BoxFit.cover, // Ajusta a imagem
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Botão de Pesquisa de Livros
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/book-search');
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Pesquisar Livros'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003F5C),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Botão de Ver Lista de Desejos
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/wish-list');
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('Ver Lista de Desejos'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003F5C),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Botão Sobre o MindBox
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutPage()),
                    );
                  },
                  icon: const Icon(Icons.info),
                  label: const Text('Sobre o MindBox'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003F5C),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
=======
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/book-search');
              },
              child: const Text('Pesquisar Livros'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wish-list');
              },
              child: const Text('Ver Lista de Desejos'),
            ),
          ],
>>>>>>> 32b33475b7bc458f64500ab69a59eb7e6a414408
        ),
      ),
    );
  }
}
