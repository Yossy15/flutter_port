import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port/core/extensions/theme_data.dart';
import 'package:port/core/layout/state/bar_index.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HeaderBar extends ConsumerWidget {
  const HeaderBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(barIndexProvider);
    final activeColor = Theme.of(context).appColors.primaryPressed;

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withOpacity(0.92),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.outline.withOpacity(0.15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: PhosphorIcons.house(),
                      selectedIcon: PhosphorIcons.house(
                        PhosphorIconsStyle.fill,
                      ),
                      label: 'Home',
                      isSelected: selectedIndex == 0,
                      activeColor: activeColor,
                      onTap: () =>
                          ref.read(barIndexProvider.notifier).setIndex(0),
                    ),
                    _NavItem(
                      icon: PhosphorIcons.briefcase(),
                      selectedIcon: PhosphorIcons.briefcase(
                        PhosphorIconsStyle.fill,
                      ),
                      label: 'Projects',
                      isSelected: selectedIndex == 1,
                      activeColor: activeColor,
                      onTap: () =>
                          ref.read(barIndexProvider.notifier).setIndex(1),
                    ),
                    _NavItem(
                      icon: PhosphorIcons.user(),
                      selectedIcon: PhosphorIcons.user(PhosphorIconsStyle.fill),
                      label: 'Contact',
                      isSelected: selectedIndex == 2,
                      activeColor: activeColor,
                      onTap: () =>
                          ref.read(barIndexProvider.notifier).setIndex(2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  final PhosphorIconData icon;
  final PhosphorIconData selectedIcon;
  final String label;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _bounceAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.35,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.35,
          end: 0.9,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.9,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    // Bounce ลงแทนขึ้น เพราะอยู่ด้านบน
    _bounceAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 8.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 8.0,
          end: -2.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -2.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(_NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inactiveColor = Theme.of(
      context,
    ).colorScheme.onSurface.withOpacity(0.45);

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? widget.activeColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _bounceAnim.value),
              child: Transform.scale(
                scale: widget.isSelected ? _scaleAnim.value : 1.0,
                child: child,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: PhosphorIcon(
                  widget.isSelected ? widget.selectedIcon : widget.icon,
                  key: ValueKey(widget.isSelected),
                  color: widget.isSelected ? widget.activeColor : inactiveColor,
                  size: 22,
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: widget.isSelected
                    ? Row(
                        children: [
                          const SizedBox(width: 6),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: widget.activeColor,
                            ),
                            child: Text(widget.label),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
