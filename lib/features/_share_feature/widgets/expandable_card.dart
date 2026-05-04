import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:port/core/extensions/theme_data.dart';

class ExpandableCard extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  /// เปิดมาให้ expand เลยไหม
  final bool initialExpanded;

  /// อนุญาตให้กดเพื่อ expand/collapse ไหม
  final bool isExpandable;

  const ExpandableCard({
    super.key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.initialExpanded = false,
    this.isExpandable = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpandableNotifier(
      initialExpanded: initialExpanded,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ExpandableTheme(
            data: const ExpandableThemeData(
              hasIcon: false,
              animationDuration: Duration(milliseconds: 250),
              crossFadePoint: 0,
            ),
            child: Builder(
              builder: (context) {
                final controller = ExpandableController.of(
                  context,
                  required: true,
                )!;

                return Column(
                  children: [
                    /// HEADER
                    InkWell(
                      onTap: isExpandable ? controller.toggle : null,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: padding,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: theme.appTexts.bodyLargeBold,
                              ),
                            ),

                            /// แสดง icon เฉพาะตอนกดได้
                            if (isExpandable)
                              AnimatedRotation(
                                turns: controller.expanded ? 0.5 : 0,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                child: const Icon(Icons.keyboard_arrow_down),
                              ),
                          ],
                        ),
                      ),
                    ),

                    /// CONTENT (มีเสมอ แต่แค่ expand/collapse)
                    Expandable(
                      collapsed: const SizedBox.shrink(),
                      expanded: Padding(padding: padding, child: child),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
