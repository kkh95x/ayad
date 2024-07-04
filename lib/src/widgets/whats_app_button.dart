import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class WhatsAptButton extends ConsumerWidget {
  const WhatsAptButton(
      {super.key,
      this.title = "إرسال طلب عبر الوتساب",
      this.message = "",
      this.color,
      required this.isFirstNumber,
      this.isCircle = false});
  final String title;
  final String message;
  final Color? color;
  final bool isFirstNumber;
  final bool isCircle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    if (isCircle) {
      return InkWell(
        onTap: () async {
          final setting = await ref.watch(getSettingFuture.future);
          if (setting != null) {
            final link = WhatsAppUnilink(
              phoneNumber:isFirstNumber? setting.whatsAppPhone: setting.whatsAppPhone2,
              text: message,
            );
            if (true) {
              launchUrl(link.asUri());
            }
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
              color: color ?? appColor.whiteish,
              border: Border.all(color: color ?? appColor.whiteish)
              // borderRadius: BorderRadius.circular(4)
              ),
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            Assets.svg.whatsappWhiteIcon,
            width: 6.r,
            height: 6.r,
            color: appColor.whiteish,
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
          color: color ?? appColor.greenish,
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: InkWell(
        onTap: () async {
          final setting = await ref.watch(getSettingFuture.future);
          if (setting != null) {
            final link = WhatsAppUnilink(
              phoneNumber:isFirstNumber? setting.whatsAppPhone: setting.whatsAppPhone2,
              text: message,
            );
            if (true) {
              launchUrl(link.asUri());
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: appColor.whiteish),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SvgPicture.asset(
                Assets.svg.whatsappWhiteIcon,
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
