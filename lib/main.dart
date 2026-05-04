import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port/core/responsive/responsive_scope.dart';
import 'package:port/core/routes/app_route.dart';
import 'package:port/core/themes/app_theme.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

void main() {
  runApp(const ProviderScope(child: ResponsiveScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);
    return MaterialApp.router(
      title: 'Portfolio',
      theme: AppTheme.getTheme(),
      scrollBehavior: MyCustomScrollBehavior(),
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      debugShowCheckedModeBanner: false,
    );
  }
}
