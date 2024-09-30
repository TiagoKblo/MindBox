import 'package:flutter/material.dart';
import '../pages/aboutPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
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

              ClipOval(
                child: SizedBox(
                  width: screenSize.width * 0.6,
                  height: screenSize.width * 0.6,
                  child: Image.asset(
                    'assets/images/logo4.jpeg',
                    fit: BoxFit.cover,
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
        ),
      ),
    );
  }
}
