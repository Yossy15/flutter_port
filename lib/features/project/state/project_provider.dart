import 'package:port/features/_share_feature/mockup/project_mock.dart';
import 'package:port/features/project/models/project_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_provider.g.dart';

@riverpod
Future<List<ProjectModel>> projectList(Ref ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 500));
  return mockProjects;
}
