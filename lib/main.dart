import 'package:flutter/material.dart';
import 'homePage.dart';
import 'bookSearchPage.dart';
import 'wishListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesquisa de Livros',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'Tela Inicial'),
        '/book-search': (context) => const BookSearchPage(),
        '/wish-list': (context) => const WishListPage(),
      },
    );
  }
}
