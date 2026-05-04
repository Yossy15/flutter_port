import 'package:flutter/material.dart';
import 'package:port/core/extensions/colors/app_color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppRefresher extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onRefresh;
  final VoidCallback? onLoading;
  final bool enablePullUp;
  final Widget child;

  const AppRefresher({
    super.key,
    required this.controller,
    required this.onRefresh,
    this.onLoading,
    this.enablePullUp = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      enablePullUp: enablePullUp,
      header: WaterDropMaterialHeader(
        backgroundColor: context.appColors.neutral.shade40,
        color: context.appColors.primary,
        offset: 0,
      ),
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text(
              "ดึงขึ้นเพื่อโหลดต่อ",
              style: TextStyle(color: context.appColors.primary, fontSize: 12),
            );
          } else if (mode == LoadStatus.loading) {
            body = SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.appColors.primary,
              ),
            );
          } else if (mode == LoadStatus.failed) {
            body = Text(
              "การโหลดล้มเหลว คลิกเพื่อลองใหม่",
              style: TextStyle(color: context.appColors.error, fontSize: 12),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = Text(
              "ปล่อยเพื่อโหลดต่อ",
              style: TextStyle(color: context.appColors.primary, fontSize: 12),
            );
          } else {
            body = Text(
              "ไม่มีข้อมูลเพิ่มเติม",
              style: TextStyle(color: context.appColors.primary, fontSize: 12),
            );
          }
          return Container(height: 60.0, child: Center(child: body));
        },
      ),
      child: child,
    );
  }
}
