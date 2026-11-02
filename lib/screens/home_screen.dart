import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';
import '../widgets/design_components.dart';
import 'auth_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    void open(bool register) => Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => AuthScreen(register: register)));
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookShelf'),
        actions: [
          TextButton(onPressed: () => open(false), child: const Text('Login')),
          TextButton(
            onPressed: () => open(true),
            child: const Text('Register'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: AppColors.hero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'YOUR PERSONAL LIBRARY',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.5,
                          color: AppColors.primary700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('BookShelf', style: text.displayMedium),
                      const SizedBox(height: 12),
                      Text(
                        'A little space for your next great read.',
                        style: text.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Keep your books, reading plans and favorite stories together in a library that is just yours.',
                        style: TextStyle(color: AppColors.secondary),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () => open(true),
                        child: const Text('Register'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => open(false),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Make every read count', style: text.headlineSmall),
                      const SizedBox(height: 16),
                      for (final feature in [
                        (
                          Icons.library_books_outlined,
                          'Track your books',
                          'Keep the books you own and the ones you want to read in one place.',
                        ),
                        (
                          Icons.bookmark_border_rounded,
                          'Sort by status',
                          'From To Read to Reading to Finished, find your next chapter.',
                        ),
                        (
                          Icons.star_border_rounded,
                          'Rate your favorites',
                          'Remember the stories you love with stars, ratings and personal notes.',
                        ),
                      ])
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    feature.$1,
                                    color: AppColors.primary700,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(feature.$2, style: text.titleLarge),
                                const SizedBox(height: 8),
                                Text(
                                  feature.$3,
                                  style: const TextStyle(
                                    color: AppColors.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        'Your next chapter starts here.',
                        style: text.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => open(true),
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
