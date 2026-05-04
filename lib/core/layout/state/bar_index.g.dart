// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bar_index.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BarIndex)
final barIndexProvider = BarIndexProvider._();

final class BarIndexProvider extends $NotifierProvider<BarIndex, int> {
  BarIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'barIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$barIndexHash();

  @$internal
  @override
  BarIndex create() => BarIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$barIndexHash() => r'35f9623d5c9974a55d538cca6562ea407502cc81';

abstract class _$BarIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
