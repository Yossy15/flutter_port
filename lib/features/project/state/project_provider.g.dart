// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(projectList)
final projectListProvider = ProjectListProvider._();

final class ProjectListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProjectModel>>,
          List<ProjectModel>,
          FutureOr<List<ProjectModel>>
        >
    with
        $FutureModifier<List<ProjectModel>>,
        $FutureProvider<List<ProjectModel>> {
  ProjectListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectListHash();

  @$internal
  @override
  $FutureProviderElement<List<ProjectModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProjectModel>> create(Ref ref) {
    return projectList(ref);
  }
}

String _$projectListHash() => r'cc9422ffd96172113c5c79745678b1309ceb480d';
