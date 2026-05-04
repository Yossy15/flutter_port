import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen_size_state.dart';

class ResponsiveScope extends ConsumerStatefulWidget {
  final Widget child;
  const ResponsiveScope({super.key, required this.child});

  @override
  ConsumerState<ResponsiveScope> createState() => _ResponsiveScopeState();
}

class _ResponsiveScopeState extends ConsumerState<ResponsiveScope> {
  double? _lastWidth;

  void _setWidthLater(double width) {
    if (_lastWidth == width) return;
    _lastWidth = width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(screenSizeStateProvider.notifier).setWidth(width, ready: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _setWidthLater(constraints.maxWidth);
        return widget.child;
      },
    );
  }
}
