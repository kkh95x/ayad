import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAptButton extends ConsumerWidget {
  const WhatsAptButton(
      {super.key, this.title = "إرسال طلب عبر الوتساب", this.message = ""});
  final String title;
  final String message;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return Container(
      height: 35.h,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 3,
            color: appColor.blackish.withOpacity(.4),
            offset: const Offset(1, 1))
      ], color: appColor.greenish, borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: InkWell(
        onTap: () async {
          final link = WhatsAppUnilink(
            phoneNumber: '+31637031781',
            text: message,
          );
          if (await canLaunchUrl(link.asUri())) {
            launchUrl(link.asUri());
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
