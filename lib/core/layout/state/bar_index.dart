import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'bar_index.g.dart';

@riverpod
class BarIndex extends _$BarIndex {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}
