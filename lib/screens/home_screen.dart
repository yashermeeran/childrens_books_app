import 'package:childrens_book_app/models/app_state.dart';
import 'package:childrens_book_app/models/category.dart' as app_models;
import 'package:childrens_book_app/widgets/book_cart.dart';
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
    final books = [
      Book(
        id: 1,
        title: 'The Magic Forest',
        author: 'Jane Smith',
        category: 'Fiction',
        coverImageUrl: 'https://picsum.photos/seed/book1/300/450',
        description:
            'Join Lucy on her adventure through the magical forest where she meets talking animals and discovers hidden treasures.',
      ),
      Book(
        id: 2,
        title: 'Dragon\'s Tale',
        author: 'Michael Johnson',
        category: 'Fiction',
        coverImageUrl: 'https://picsum.photos/seed/book2/300/450',
        description:
            'A young dragon learns to breathe fire and finds his place in the dragon community.',
      ),
      Book(
        id: 3,
        title: 'Fluffy\'s Adventure',
        author: 'Sarah Williams',
        category: 'Animals',
        coverImageUrl: 'https://picsum.photos/seed/book3/300/450',
        description:
            'Fluffy the cat gets lost in the big city and must find his way back home.',
      ),
      Book(
        id: 4,
        title: 'Bedtime for Teddy',
        author: 'Emma Thompson',
        category: 'Bedtime',
        coverImageUrl: 'https://picsum.photos/seed/book4/300/450',
        description:
            'Teddy the bear doesn\'t want to go to sleep and comes up with many excuses to stay awake.',
      ),
      Book(
        id: 5,
        title: 'Counting with Monkeys',
        author: 'David Brown',
        category: 'Educational',
        coverImageUrl: 'https://picsum.photos/seed/book5/300/450',
        description:
            'Learn to count from 1 to 10 with the help of playful monkeys.',
      ),
    ];
    final categories = [
      app_models.Category(id: 1, name: 'Fiction', color: 0xFFFF9800),
      app_models.Category(id: 2, name: 'Science', color: 0xFF4CAF50),
      app_models.Category(id: 3, name: 'Animals', color: 0xFF2196F3),
      app_models.Category(id: 4, name: 'Bedtime', color: 0xFF9C27B0),
      app_models.Category(id: 5, name: 'Educational', color: 0xFFE91E63),
    ];

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

