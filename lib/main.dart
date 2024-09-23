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
      title: 'MindBox',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF003F5C),
          primary: Color(0xFF003F5C),
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF003F5C),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF003F5C),
            foregroundColor: Colors.white, // Corrigido de onPrimary para foregroundColor
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'MindBox'),
        '/book-search': (context) => const BookSearchPage(),
        '/wish-list': (context) => const WishListPage(),
      },
    );
  }
}
