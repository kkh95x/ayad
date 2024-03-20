import 'package:ayad/src/models/product.dart';
import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends ConsumerWidget {
  const WhatsAppButton({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return Container(
      height: 35.h,
      decoration: BoxDecoration(
          color: appColor.greenish, borderRadius: BorderRadius.circular(8.r)),
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: InkWell(
        onTap: () async {
          final link = WhatsAppUnilink(
            phoneNumber: '+31637031781',
            text: "مرحبا\nأرغب بشراء المنتج *${product.nameEnglis}*\n من المجموعة *${product.groupName}* \nذو المعرف *${product.productCode}* \n${product.description??""}",
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
              "طلب عبر الوتساب",
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
