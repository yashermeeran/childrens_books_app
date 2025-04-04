import 'package:childrens_book_app/models/app_state.dart';
import 'package:childrens_book_app/models/category.dart';
import 'package:childrens_book_app/screens/book_details_screen.dart';
import 'package:childrens_book_app/screens/book_list_screen.dart';
import 'package:childrens_book_app/screens/bookmarks_screen.dart';
import 'package:childrens_book_app/screens/home_screen.dart';
import 'package:childrens_book_app/screens/profile_screen.dart';
import 'package:childrens_book_app/screens/reader_screen.dart';
import 'package:childrens_book_app/widgets/main_navigation.dart';
import 'package:childrens_book_app/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Children\'s Book App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.orange,
          tertiary: Colors.green,
        ),
        fontFamily: 'Quicksand',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainNavigation(),
        '/book-list': (context) => const BookListScreen(),
        '/book-detail': (context) => const BookDetailScreen(),
        '/bookmarks': (context) => const BookmarksScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/category': (context) => const CategoryScreen(),
        '/reader': (context) => const ReaderScreen(),
      },
    );
  }
}
