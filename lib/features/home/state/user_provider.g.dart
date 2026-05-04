// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userProject)
final userProjectProvider = UserProjectProvider._();

final class UserProjectProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserModel>,
          UserModel,
          FutureOr<UserModel>
        >
    with $FutureModifier<UserModel>, $FutureProvider<UserModel> {
  UserProjectProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProjectProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userProjectHash();

  @$internal
  @override
  $FutureProviderElement<UserModel> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<UserModel> create(Ref ref) {
    return userProject(ref);
  }
}

String _$userProjectHash() => r'33d8e0341f8da190b25c4b91d381dbd930d708bc';
