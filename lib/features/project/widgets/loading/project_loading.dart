import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:port/core/responsive/enum/size.dart';
import 'package:port/core/responsive/screen_size_state.dart';
import 'package:port/core/widgets/shimmer/shimmer.dart';

class ProjectLoading extends ConsumerWidget {
  const ProjectLoading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = ref.watch(screenSizeStateProvider);
    final config = _getConfig(screenSize.size);

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: config.crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: config.aspectRatio,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withOpacity(0.85),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 30,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🖼 Image Shimmer
                AppShimmer(
                  width: double.infinity,
                  height: 160,
                  borderRadius: 0,
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title Shimmer
                      AppShimmer(width: 150, height: 18),
                      const Gap(12),

                      /// Description Shimmer
                      AppShimmer(width: double.infinity, height: 14),
                      const Gap(8),
                      AppShimmer(width: 200, height: 14),
                      const Gap(16),

                      /// Tags Shimmer
                      Row(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AppShimmer(
                              width: 60,
                              height: 24,
                              borderRadius: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _GridConfig _getConfig(ViewSize size) {
    switch (size) {
      case ViewSize.lg:
        return _GridConfig(3, 0.98);
      case ViewSize.md:
        return _GridConfig(2, 1);
      case ViewSize.sm:
        return _GridConfig(2, 0.9);
      default:
        return _GridConfig(1, 0.9);
    }
  }
}

class _GridConfig {
  final int crossAxisCount;
  final double aspectRatio;

  _GridConfig(this.crossAxisCount, this.aspectRatio);
}
