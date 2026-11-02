import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../core/validators.dart';
import '../models/book.dart';
import 'design_components.dart';

class BookForm extends StatefulWidget {
  const BookForm({
    super.key,
    this.initial,
    required this.onSave,
    this.onCancel,
  });
  final BookDraft? initial;
  final Future<void> Function(BookDraft) onSave;
  final VoidCallback? onCancel;
  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final form = GlobalKey<FormState>();
  late final TextEditingController title, author, rating, notes;
  String? genre, status, error;
  bool submitted = false, busy = false;
  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    title = TextEditingController(text: initial?.title);
    author = TextEditingController(text: initial?.author);
    rating = TextEditingController(text: initial?.rating?.toString());
    notes = TextEditingController(text: initial?.notes);
    genre = initial?.genre;
    status = initial?.status;
  }

  @override
  void dispose() {
    for (final c in [title, author, rating, notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> save() async {
    setState(() {
      submitted = true;
      error = null;
    });
    if (!form.currentState!.validate()) return;
    setState(() => busy = true);
    try {
      await widget.onSave(
        BookDraft(
          title: title.text,
          author: author.text,
          genre: genre!,
          status: status!,
          rating: rating.text.trim().isEmpty
              ? null
              : int.parse(rating.text.trim()),
          notes: notes.text,
        ),
      );
      if (!mounted) return;
      if (widget.initial == null) {
        setState(() {
          submitted = false;
          for (final c in [title, author, rating, notes]) {
            c.clear();
          }
          genre = null;
          status = null;
          form.currentState!.reset();
        });
      }
    } on FirebaseException catch (e) {
      if (mounted) setState(() => error = e.message ?? e.code);
    } catch (e) {
      if (mounted) setState(() => error = e.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  Widget dropdown(
    String label,
    String hint,
    String? value,
    List<String> options,
    ValueChanged<String?> change,
  ) => DropdownButtonFormField<String>(
    key: ValueKey('$label-$value'),
    initialValue: value,
    isExpanded: true,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 0),
    ),
    icon: const Icon(Icons.keyboard_arrow_down_rounded),
    hint: Text(hint),
    items: [
      DropdownMenuItem<String>(value: null, child: Text(hint)),
      ...options.map((s) => DropdownMenuItem(value: s, child: Text(s))),
    ],
    onChanged: busy ? null : change,
    validator: (v) =>
        v == null ? 'Please choose a ${label.toLowerCase()}' : null,
  );

  @override
  Widget build(BuildContext context) => Form(
    key: form,
    autovalidateMode: submitted
        ? AutovalidateMode.onUserInteraction
        : AutovalidateMode.disabled,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FieldLabel(
          'Title',
          child: TextFormField(
            controller: title,
            enabled: !busy,
            decoration: const InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(fontSize: 0),
              hintText: 'Enter book title',
            ),
            validator: Validators.title,
          ),
        ),
        const SizedBox(height: 16),
        FieldLabel(
          'Author',
          child: TextFormField(
            controller: author,
            enabled: !busy,
            decoration: const InputDecoration(
              labelText: 'Author',
              labelStyle: TextStyle(fontSize: 0),
              hintText: 'Enter author name',
            ),
            validator: Validators.author,
          ),
        ),
        const SizedBox(height: 16),
        FieldLabel(
          'Genre',
          child: dropdown(
            'Genre',
            'Choose genre',
            genre,
            genres,
            (v) => setState(() => genre = v),
          ),
        ),
        const SizedBox(height: 16),
        FieldLabel(
          'Status',
          child: dropdown(
            'Status',
            'Choose status',
            status,
            statuses,
            (v) => setState(() => status = v),
          ),
        ),
        const SizedBox(height: 16),
        FieldLabel(
          'Rating',
          child: TextFormField(
            controller: rating,
            enabled: !busy,
            decoration: const InputDecoration(
              labelText: 'Rating',
              labelStyle: TextStyle(fontSize: 0),
              hintText: '0 to 5',
              helperText: 'Optional · whole number from 0 to 5',
            ),
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            validator: Validators.rating,
          ),
        ),
        const SizedBox(height: 16),
        FieldLabel(
          'Notes',
          child: TextFormField(
            controller: notes,
            enabled: !busy,
            decoration: const InputDecoration(
              labelText: 'Notes',
              labelStyle: TextStyle(fontSize: 0),
              hintText: 'Your thoughts on this book',
              helperText: 'Optional · at most 300 characters',
            ),
            minLines: 4,
            maxLines: 6,
            validator: Validators.notes,
          ),
        ),
        const SizedBox(height: 24),
        if (widget.onCancel != null) ...[
          OutlinedButton(
            onPressed: busy ? null : widget.onCancel,
            child: const Text('Cancel'),
          ),
          const SizedBox(height: 12),
        ],
        FilledButton(
          onPressed: busy ? null : save,
          child: busy
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.initial == null ? 'Add Book' : 'Save'),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ErrorState(error!),
          ),
      ],
    ),
  );
}
