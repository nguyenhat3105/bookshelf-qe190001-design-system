import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import '../app/theme/app_theme.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';
import '../widgets/book_form.dart';
import '../widgets/design_components.dart';
import 'detail_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.user});
  final User user;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final repository = BookRepository();
  final search = TextEditingController();
  late final Stream<List<Book>> books;
  String genre = 'All', status = 'All';
  bool favoritesOnly = false, loggingOut = false;
  @override
  void initState() {
    super.initState();
    books = repository.watch(widget.user.uid);
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  Future<void> logout() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() => loggingOut = true);
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (mounted) notice(context, e.toString());
    } finally {
      if (mounted) setState(() => loggingOut = false);
    }
  }

  Widget filter(
    String label,
    String selected,
    List<String> choices,
    ValueChanged<String?> onChanged,
  ) => FieldLabel(
    label,
    child: DropdownButtonFormField<String>(
      key: ValueKey('$label-$selected'),
      initialValue: selected,
      decoration: InputDecoration(),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      items: [
        'All',
        ...choices,
      ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
      onChanged: onChanged,
    ),
  );
  void open(Book book) => Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => DetailScreen(
        user: widget.user,
        initial: book,
        books: books,
        repository: repository,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookShelf'),
        actions: [
          TextButton(
            onPressed: loggingOut ? null : logout,
            child: const Text('Logout'),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Signed in as ${widget.user.email ?? ''}',
                style: text.bodySmall,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Your bookshelf', style: text.headlineMedium),
                const SizedBox(height: 8),
                const Text(
                  'A place for every chapter of your reading life.',
                  style: TextStyle(color: AppColors.secondary),
                ),
                const SizedBox(height: 24),
                Card(
                  child: ExpansionTile(
                    title: Text('Add a book', style: text.titleLarge),
                    leading: const Icon(Icons.add, size: 24),
                    initiallyExpanded: false,
                    shape: const Border(),
                    collapsedShape: const Border(),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    children: [
                      BookForm(
                        onSave: (draft) async {
                          await repository.save(widget.user.uid, draft);
                          if (context.mounted) notice(context, 'Book added');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Find your next read', style: text.titleLarge),
                      const SizedBox(height: 16),
                      FieldLabel(
                        'Search',
                        child: TextField(
                          key: const ValueKey('Search'),
                          controller: search,
                          decoration: const InputDecoration(
                            hintText: 'Search by title or author',
                            prefixIcon: Icon(Icons.search, size: 20),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                      ),
                      const SizedBox(height: 16),
                      filter(
                        'Genre filter',
                        genre,
                        genres,
                        (v) => setState(() => genre = v!),
                      ),
                      const SizedBox(height: 16),
                      filter(
                        'Status filter',
                        status,
                        statuses,
                        (v) => setState(() => status = v!),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Favorites only'),
                        value: favoritesOnly,
                        onChanged: (v) => setState(() => favoritesOnly = v),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () => setState(() {
                            genre = 'All';
                            status = 'All';
                            favoritesOnly = false;
                            search.clear();
                          }),
                          child: const Text('Clear'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                StreamBuilder<List<Book>>(
                  stream: books,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return ErrorState(
                        'Could not load books: ${snapshot.error}',
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      );
                    }
                    final visible = BookFilter(
                      genre: genre,
                      status: status,
                      favoritesOnly: favoritesOnly,
                      search: search.text,
                    ).apply(snapshot.data!);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Summary', style: text.titleLarge),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 24,
                                runSpacing: 8,
                                children: [
                                  Text(
                                    'Books: ${visible.length}',
                                    style: text.titleMedium,
                                  ),
                                  Text(
                                    'Favorites: ${visible.where((b) => b.favorite).length}',
                                    style: text.titleMedium,
                                  ),
                                ],
                              ),
                              if (visible.isNotEmpty)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                  child: Divider(height: 1),
                                ),
                              for (final row in statusBreakdown(visible))
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BookChip(row.key, status: true),
                                      Text(
                                        '${row.value}',
                                        style: text.titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text('Your books', style: text.headlineSmall),
                        const SizedBox(height: 16),
                        if (visible.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 48),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.menu_book_outlined,
                                  size: 48,
                                  color: AppColors.muted,
                                ),
                                const SizedBox(height: 16),
                                Text('No books found', style: text.titleLarge),
                                const SizedBox(height: 8),
                                const Text(
                                  'Try adjusting your filters or add a new book.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.secondary),
                                ),
                              ],
                            ),
                          ),
                        for (final book in visible)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Card(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => open(book),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  book.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: text.titleMedium,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  book.author,
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: AppColors.secondary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          FavoriteButton(
                                            favorite: book.favorite,
                                            onPressed: () async {
                                              try {
                                                await repository.favorite(book);
                                              } catch (e) {
                                                if (context.mounted) {
                                                  notice(context, e.toString());
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: [
                                          BookChip(book.genre),
                                          BookChip(book.status, status: true),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () => open(book),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text('View'),
                                              Icon(
                                                Icons.chevron_right,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
