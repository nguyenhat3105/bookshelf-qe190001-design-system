import 'package:flutter/material.dart';

import '../app/theme/app_theme.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key, required this.child});
  final String text;
  final Widget child;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(text, style: Theme.of(context).textTheme.titleSmall),
      const SizedBox(height: 8),
      child,
    ],
  );
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });
  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: padding, child: child),
  );
}

class ErrorState extends StatelessWidget {
  const ErrorState(this.message, {super.key});
  final String message;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: AppColors.errorSurface,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.error_outline, size: 20, color: AppColors.error),
        const SizedBox(width: 8),
        Expanded(
          child: Text(message, style: const TextStyle(color: AppColors.error)),
        ),
      ],
    ),
  );
}

class BookChip extends StatelessWidget {
  const BookChip(this.text, {super.key, this.status = false});
  final String text;
  final bool status;
  @override
  Widget build(BuildContext context) {
    final colors = !status
        ? (AppColors.background, AppColors.secondary)
        : switch (text) {
            'Reading' => (AppColors.warningSurface, AppColors.warning),
            'Finished' => (AppColors.successSurface, AppColors.success),
            _ => (AppColors.infoSurface, AppColors.info),
          };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colors.$2,
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.favorite,
    required this.onPressed,
  });
  final bool favorite;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: favorite ? 'Remove from favorites' : 'Add to favorites',
    onPressed: onPressed,
    icon: AnimatedSwitcher(
      duration: const Duration(milliseconds: 180),
      child: Icon(
        favorite ? Icons.star_rounded : Icons.star_border_rounded,
        key: ValueKey(favorite),
        size: 24,
        color: favorite ? AppColors.accent : AppColors.muted,
      ),
    ),
  );
}
