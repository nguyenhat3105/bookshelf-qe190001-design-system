import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';
import '../widgets/book_form.dart';
import '../widgets/design_components.dart';
import '../app/theme/app_theme.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.user,
    required this.initial,
    required this.books,
    required this.repository,
  });
  final User user;
  final Book initial;
  final Stream<List<Book>> books;
  final BookRepository repository;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String id;
  bool editing = false, deleting = false;
  @override
  void initState() {
    super.initState();
    id = widget.initial.id;
  }

  Future<void> delete(Book book) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete book?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => deleting = true);
    try {
      await widget.repository.delete(book);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() => deleting = false);
        notice(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    initialData: FirebaseAuth.instance.currentUser,
    builder: (context, auth) {
      if (auth.data?.uid != widget.user.uid) {
        return const Scaffold(
          body: Center(child: Text('Please log in to view this book.')),
        );
      }
      return Scaffold(
        appBar: AppBar(title: const Text('Detail')),
        body: StreamBuilder<List<Book>>(
          stream: widget.books,
          initialData: [widget.initial],
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Could not load book: ${snapshot.error}'),
              );
            }
            final matches = (snapshot.data ?? []).where((b) => b.id == id);
            if (matches.isEmpty) {
              return const Center(child: Text('This book no longer exists.'));
            }
            final book = matches.first;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: editing
                      ? BookForm(
                          initial: book.draft,
                          onCancel: () => setState(() => editing = false),
                          onSave: (draft) async {
                            final nextId = await widget.repository.save(
                              widget.user.uid,
                              draft,
                              original: book,
                            );
                            if (mounted && context.mounted) {
                              setState(() {
                                id = nextId;
                                editing = false;
                              });
                              notice(context, 'Book saved');
                            }
                          },
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              book.title,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book.author,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            AppCard(
                              child: Column(
                                children: [
                                  for (final entry in [
                                    ('Genre', book.genre),
                                    ('Status', book.status),
                                    (
                                      'Rating',
                                      book.rating == null
                                          ? 'Not rated'
                                          : '${book.rating} / 5',
                                    ),
                                  ])
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              entry.$1,
                                              style: const TextStyle(
                                                color: AppColors.secondary,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              entry.$2,
                                              textAlign: TextAlign.right,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Favorite'),
                                      FavoriteButton(
                                        favorite: book.favorite,
                                        onPressed: deleting
                                            ? null
                                            : () async {
                                                try {
                                                  await widget.repository
                                                      .favorite(book);
                                                } catch (e) {
                                                  if (context.mounted) {
                                                    notice(
                                                      context,
                                                      e.toString(),
                                                    );
                                                  }
                                                }
                                              },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            AppCard(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Notes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge,
                                  ),
                                  const SizedBox(height: 12),
                                  SelectableText(
                                    book.notes.isEmpty
                                        ? 'No notes'
                                        : book.notes,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            FilledButton(
                              onPressed: deleting
                                  ? null
                                  : () => setState(() => editing = true),
                              child: const Text('Edit'),
                            ),
                            const SizedBox(height: 12),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.error,
                              ),
                              onPressed: deleting ? null : () => delete(book),
                              child: Text(deleting ? 'Deleting…' : 'Delete'),
                            ),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
