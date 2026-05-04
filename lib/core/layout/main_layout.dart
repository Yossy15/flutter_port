import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port/core/layout/state/bar_index.dart';
import 'package:port/core/layout/widgets/bottom_bar.dart';
import 'package:port/core/layout/widgets/header_bar.dart';
import 'package:port/core/layout/widgets/slide_bar.dart';
import 'package:port/core/responsive/enum/size.dart';
import 'package:port/core/responsive/screen_size_state.dart';
import 'package:port/features/contact/screen/contact.dart';
import 'package:port/features/home/screen/home.dart';
import 'package:port/features/project/screen/project.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key, required this.child});

  final Widget child;

  static const _pages = [HomeScreen(), ProjectScreen(), ContactScreen()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = ref.watch(screenSizeStateProvider);
    final index = ref.watch(barIndexProvider);

    if (!screenSize.ready) return const SizedBox.shrink();

    return switch (screenSize.size) {
      ViewSize.lg || ViewSize.md => SideBar(child: _pages[index]),
      ViewSize.sm => HeaderBar(child: _pages[index]),
      ViewSize.xs => BottomBar(child: _pages[index]),
    };
  }
}
