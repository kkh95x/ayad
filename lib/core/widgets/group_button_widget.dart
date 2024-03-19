import 'package:ayad/core/models/group.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupButtonWidget extends ConsumerWidget {
  const GroupButtonWidget({super.key, required this.group, this.onTap});
  final Group group;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return InkWell(
       borderRadius: BorderRadius.circular(8.r),
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.all(4.r),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 2,
              color: appColor.greyish,
              offset: const Offset(1, 1))
        ], color: appColor.redish, borderRadius: BorderRadius.circular(8.r)),
        child: Text(
          group.name,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: appColor.whiteish),
        ),
      ),
    );
  }
}
