import 'package:port/features/_share_feature/mockup/user_mock.dart';
import 'package:port/features/home/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

// @riverpod
// UserModel user(UserRef ref) {
//   return mockUser;
// }

@riverpod
Future<UserModel> userProject(Ref ref) async {
  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 500));
  return mockUser;
}
