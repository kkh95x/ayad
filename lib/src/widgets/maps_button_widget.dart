import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class MapButton extends ConsumerWidget {
  const MapButton({super.key, this.isCircle = false});
  final bool isCircle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    if (isCircle) {
      return InkWell(
        onTap: () async {
          final setting = await ref.read(getSettingFuture.future);
          if (setting != null) {
            double latitude = setting.landtute ?? 36.58365142557628;
            double longitude = setting.longtute ?? 37.04943860000036;
            String googleUrl =
                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
            if (await canLaunchUrl(Uri.parse(googleUrl))) {
              await launchUrl(Uri.parse(googleUrl));
            } else {}
          }
        },
        child: Container(
          height: 45.r,
          width: 45.r,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    color: appColor.blackish,
                    offset: const Offset(1, 1))
              ],
              color: appColor.greenish.shade100,
              border: Border.all(color: appColor.greenish.shade100)
              // borderRadius: BorderRadius.circular(4)
              ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            Assets.svg.map,
            width: 6.r,
            height: 6.r,
          ),
        ),
      );
    }

    return Container(
      height: 35.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: appColor.blackish.withOpacity(.4),
                offset: const Offset(1, 1))
          ],
          color: appColor.blueish.shade900,
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: InkWell(
        onTap: () async {
          final setting = await ref.read(getSettingFuture.future);
          if (setting != null) {
            double latitude = setting.landtute ?? 36.58365142557628;
            double longitude = setting.longtute ?? 37.04943860000036;
            String googleUrl =
                'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
            if (await canLaunchUrl(Uri.parse(googleUrl))) {
              await launchUrl(Uri.parse(googleUrl));
            } else {}
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              "عرض موقع",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: appColor.whiteish),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SvgPicture.asset(
                Assets.svg.map,
                width: 16.r,
                height: 16.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
