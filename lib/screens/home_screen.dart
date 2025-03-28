import 'package:childrens_book_app/models/app_state.dart';
import 'package:childrens_book_app/models/category.dart' as app_models;
import 'package:childrens_book_app/widgets/book_card.dart';
import 'package:childrens_book_app/widgets/category_card.dart';
import 'package:childrens_book_app/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _openBookDetails(Book book) {
    Navigator.of(context).pushNamed(
      '/book-detail',
      arguments: book,
    );
  }
   void _openCategoryBooks(app_models.Category category) {
    Navigator.of(context).pushNamed(
      '/book-list',
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = appState.currentUser;
    final isLoading = appState.isLoading;
    final books = appState.books;
    final categories = appState.categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Children\'s Book App'),
        centerTitle: true,
      ),
      body: isLoading
          ? const LoadingIndicator()
          : RefreshIndicator(
              onRefresh: appState.fetchInitialData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${user?.userName ?? 'Reader'}!',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Categories',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) {
                        return CategoryCard
                        (
                          category: categories[index],
                          onTap: () => _openCategoryBooks(categories[index]),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Recently Added',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7, 
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: books.length > 4 ? 4 : books.length,
                      itemBuilder: (ctx, index) {
                        return BookCard(
                          book: books[index],
                          onTap: () => _openBookDetails(books[index]),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

