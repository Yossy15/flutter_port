import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:port/core/extensions/theme_data.dart';

class CustomDialog extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool scrollable;
  final EdgeInsetsGeometry insetPadding;
  final double maxWidth;
  final double maxHeightFactor;
  final bool showCloseButton;

  const CustomDialog({
    super.key,
    required this.child,
    this.title,
    this.scrollable = true,
    this.insetPadding = const EdgeInsets.all(20),
    this.maxWidth = 960,
    this.maxHeightFactor = 0.92,
    this.showCloseButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = mediaQuery.viewInsets;
    final safePadding = mediaQuery.padding;

    final resolvedInsetPadding = insetPadding.resolve(Directionality.of(context));
    final horizontalPadding = resolvedInsetPadding.left + resolvedInsetPadding.right;
    final verticalPadding = resolvedInsetPadding.top + resolvedInsetPadding.bottom;
    final availableWidth = math.max(0.0, mediaQuery.size.width - horizontalPadding);
    final safeHeight = mediaQuery.size.height - safePadding.vertical - verticalPadding;
    final maxDialogHeight = math.max(0.0, safeHeight * maxHeightFactor);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: SafeArea(
        minimum: resolvedInsetPadding,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: math.min(maxWidth, availableWidth),
              maxHeight: maxDialogHeight,
            ),
            child: Material(
              color: Colors.white,
              elevation: 24,
              shadowColor: Colors.black.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(24),
              clipBehavior: Clip.antiAlias,
              child: _DialogScaffold(
                title: title,
                scrollable: scrollable,
                showCloseButton: showCloseButton,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool scrollable;
  final bool showCloseButton;

  const _DialogScaffold({
    required this.child,
    required this.title,
    required this.scrollable,
    required this.showCloseButton,
  });

  @override
  Widget build(BuildContext context) {
    final hasTitle = (title ?? '').trim().isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: hasTitle
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
                        child: Text(
                          title!,
                          style: Theme.of(context).appTexts.headingLargeBold?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              if (showCloseButton)
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  icon: const Icon(Icons.close),
                ),
            ],
          ),
        ),
        if (hasTitle) const Divider(height: 1),
        Flexible(
          child: scrollable
              ? ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    overscroll: false,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    child: child,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: child,
                ),
        ),
      ],
    );
  }
}

extension DialogExtension on BuildContext {
  Future<T?> showCustomDialog<T>({
    required Widget child,
    String? title,
    bool barrierDismissible = true,
    bool scrollable = true,
    EdgeInsetsGeometry insetPadding = const EdgeInsets.all(20),
    double maxWidth = 960,
    double maxHeightFactor = 0.92,
    bool showCloseButton = true,
  }) {
    return showGeneralDialog<T>(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(this).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 220),
      barrierColor: Colors.black54,
      pageBuilder: (context, animation, secondaryAnimation) {
        return WillPopScope(
          onWillPop: () async => barrierDismissible,
          child: CustomDialog(
            title: title,
            scrollable: scrollable,
            insetPadding: insetPadding,
            maxWidth: maxWidth,
            maxHeightFactor: maxHeightFactor,
            showCloseButton: showCloseButton,
            child: child,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.96, end: 1).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
