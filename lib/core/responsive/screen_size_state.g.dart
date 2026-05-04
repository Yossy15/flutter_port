// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_size_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScreenSizeState)
final screenSizeStateProvider = ScreenSizeStateProvider._();

final class ScreenSizeStateProvider
    extends $NotifierProvider<ScreenSizeState, ScreenSize> {
  ScreenSizeStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenSizeStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenSizeStateHash();

  @$internal
  @override
  ScreenSizeState create() => ScreenSizeState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenSize value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenSize>(value),
    );
  }
}

String _$screenSizeStateHash() => r'227517c5328f27968a90825c341117f5559e722d';

abstract class _$ScreenSizeState extends $Notifier<ScreenSize> {
  ScreenSize build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ScreenSize, ScreenSize>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScreenSize, ScreenSize>,
              ScreenSize,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
