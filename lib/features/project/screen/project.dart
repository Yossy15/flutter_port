import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:port/core/responsive/enum/size.dart';
import 'package:port/core/responsive/screen_size_state.dart';
import 'package:port/core/widgets/refresher/refresher.dart';
import 'package:port/features/project/state/project_provider.dart';
import 'package:port/features/project/widgets/card/project_card.dart';
import 'package:port/features/project/widgets/loading/project_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectScreen extends ConsumerWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RefreshController controller = RefreshController(
      initialRefresh: false,
    );
    final screenSize = ref.watch(screenSizeStateProvider);
    final projectList = ref.watch(projectListProvider);

    if (!screenSize.ready) return const SizedBox.shrink();

    return projectList.when(
      data: (projects) {
        final config = _getConfig(screenSize.size);

        return AppRefresher(
          controller: controller,
          onRefresh: () {
            ref.invalidate(projectListProvider);
            controller.refreshCompleted();
          },
          onLoading: () {
            ref.invalidate(projectListProvider);
            controller.loadComplete();
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: config.crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: config.aspectRatio,
            ),
            itemCount: projects.length + 1,
            itemBuilder: (context, index) {
              if (index == projects.length) {
                return const Gap(1);
              }

              return ProjectCard(project: projects[index]);
            },
          ),
        );
      },
      error: (e, _) => Center(child: Text("Error: $e")),
      loading: () => const ProjectLoading(),
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
