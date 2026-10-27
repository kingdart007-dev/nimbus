import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final surface = color ?? Theme.of(context).colorScheme.surfaceContainerLow;
    final radius = BorderRadius.circular(24);
    if (onTap == null) {
      return Container(
        decoration: BoxDecoration(color: surface, borderRadius: radius),
        padding: padding,
        child: child,
      );
    }
    return Material(
      color: surface,
      borderRadius: radius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
