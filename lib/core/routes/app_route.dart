import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:port/core/layout/main_layout.dart';
import 'package:port/features/home/screen/home.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_route.g.dart';

final rootNavigation = GlobalKey<NavigatorState>();

BuildContext? get rootContext {
  return rootNavigation.currentContext;
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigation,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainLayout(child: HomeScreen()),
      ),
    ],
  );
}
