import 'package:port/core/responsive/enum/size.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_size_state.g.dart';

@Riverpod(keepAlive: true)
class ScreenSizeState extends _$ScreenSizeState {
  @override
  ScreenSize build() {
    return const ScreenSize(width: 1, ready: false);
  }

  /// เรียกครั้งแรกหลังเฟรมแรกตอนเปิดแอพ
  /// ✅ ใช้ state.ready แทน _inited เพราะ Riverpod อาจ recreate notifier ได้
  void initFromContext(BuildContext context) {
    if (state.ready) return;
    setWidth(MediaQuery.sizeOf(context).width, ready: true);
  }

  /// เรียกเวลา resize / rotate / web resize
  void updateFromContext(BuildContext context) {
    setWidth(MediaQuery.sizeOf(context).width, ready: true);
  }

  void setWidth(double width, {required bool ready}) {
    // ✅ required แทน optional กัน caller ลืมส่ง ready
    if ((state.width - width).abs() < 0.5 && state.ready == ready) return;
    state = ScreenSize(width: width, ready: ready);
  }
}

@immutable
class ScreenSize {
  final double width;
  final bool ready;

  const ScreenSize({required this.width, required this.ready});

  ViewSize get size {
    if (width < 600) return ViewSize.xs;
    if (width < 900) return ViewSize.sm;
    if (width < 1200) return ViewSize.md;
    return ViewSize.lg;
  }

  bool get isMobile => size == ViewSize.xs;
  bool get isTablet => size == ViewSize.sm;
  bool get isDesktop => size == ViewSize.md || size == ViewSize.lg;
}
