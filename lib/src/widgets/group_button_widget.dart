import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text_plus/auto_size_text.dart';

class GroupButtonWidget extends ConsumerWidget {
  const GroupButtonWidget(
      {super.key, required this.group, this.onTap, this.onLongPress});
  final Group group;
  final void Function()? onTap;
  final void Function()? onLongPress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      onLongPress: () {
        onLongPress?.call();
      },
      child: Container(
          height: group.isMainGroup ? 100 : null,
          margin: EdgeInsets.all(4.r),
          padding: group.isMainGroup
              ? null
              : EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    // spreadRadius: 2,
                    color: (group.isMainGroup || group.hexColor == null)
                        ? appColor.blackish.withOpacity(.4)
                        : getColorFromHex(group.hexColor ?? "#fffff")
                                ?.withAlpha(200) ??
                            Colors.black,
                    offset: const Offset(1.5, 2))
              ],
              color: group.isMainGroup
                  ? appColor.blackish
                  : group.hexColor != null
                      ? getColorFromHex(group.hexColor!)
                      : appColor.redish,
              borderRadius: BorderRadius.circular(4)),
          child: group.isMainGroup
              ? Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (group.isMainGroup)
                      if (group.imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              imageUrl: group.imageUrl!),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Assets.png.groupDefault.image(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                    if (group.isMainGroup)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // boxShadow: [BoxShadow(
                            //   blurRadius:2,
                            //   spreadRadius: -1,
                            //   color: appColor.blackish.withOpacity(.4),offset: const Offset(0, -2))],
                            color: appColor.whiteish,
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(4)),
                          ),
                          child: AutoSizeText(
                            group.name,
                            maxLines: 1,
                            maxFontSize: 16,
                            minFontSize: 7,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: appColor.redish),
                          ),
                        ),
                      ),

                    // if (group.name2.isNotEmpty) ...[
                    //   SizedBox(
                    //     height: 10.h,
                    //   ),
                    //   Text(
                    //     group.name2,
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .bodyMedium
                    //         ?.copyWith(color: appColor.whiteish, fontSize: 12),
                    //   ),
                    // ]
                    if (group.isHiden)
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: appColor.blackish.withOpacity(.3)),
                            child: Icon(
                              Icons.visibility_off,
                              color: appColor.redish,
                            )),
                      )
                  ],
                )
              : Column(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                group.name,
                                maxLines: 1,
                                // maxFontSize: 16,
                                // minFontSize: 7,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: appColor.whiteish,
                                        shadows: [
                                      BoxShadow(
                                          color:
                                              appColor.blackish.withOpacity(.6),
                                          spreadRadius: 1.5,
                                          blurRadius: 2)
                                    ]),
                              ),
                              if (group.isHiden)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: appColor.blackish
                                              .withOpacity(.3)),
                                      child: Icon(
                                        Icons.visibility_off,
                                        color: appColor.whiteish,
                                      )),
                                )
                            ],
                          ),
                          if (group.name2?.isNotEmpty == true) ...[
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              group.name2 ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(shadows: [
                                BoxShadow(
                                    color: appColor.blackish.withOpacity(.6),
                                    spreadRadius: 1.5,
                                    blurRadius: 2)
                              ], color: appColor.whiteish, fontSize: 12),
                            ),
                          ],
                        ]),
                  ],
                )),
    );
  }

  Color? getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }

    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    return null;
  }
}
