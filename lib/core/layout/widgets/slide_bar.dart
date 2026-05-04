import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port/core/extensions/theme_data.dart';
import 'package:port/core/layout/state/bar_index.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:gap/gap.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(barIndexProvider);
    final activeColor = Theme.of(context).appColors.primaryPressed;

    return Scaffold(
      body: Row(
        children: [
          SafeArea(
            right: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 0, 16),
              child: Container(
                width: 64,
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
                      offset: const Offset(4, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(20),
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
                    const Gap(40),
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
                    const Gap(40),
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

    // Bounce ไปทางขวา เพราะ sidebar อยู่ซ้าย
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

    return Tooltip(
      message: widget.label,
      preferBelow: false,
      verticalOffset: 0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onInverseSurface,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.activeColor.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                // Bounce แนวนอน (X) แทนแนวตั้ง
                offset: Offset(_bounceAnim.value, 0),
                child: Transform.scale(
                  scale: widget.isSelected ? _scaleAnim.value : 1.0,
                  child: child,
                ),
              );
            },
            child: Center(
              child: AnimatedSwitcher(
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
            ),
          ),
        ),
      ),
    );
  }
}
