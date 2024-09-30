import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'pages/bookSearchPage.dart';
import 'pages/wishListPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindBox',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF003F5C),
          primary: const Color(0xFF003F5C),
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF003F5C),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF003F5C),
            foregroundColor: Colors.white,
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
