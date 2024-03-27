import 'package:ayad/src/models/product.dart';
import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsListTileWidget extends ConsumerWidget {
  const ProductsListTileWidget(
      {super.key, required this.product, this.onTap, this.onLongPress});
  final void Function()? onTap;
  final Product product;
  final void Function()? onLongPress;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return GestureDetector(
      onLongPress: () {
        onLongPress?.call();
      },
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.h),
        decoration: BoxDecoration(
            color: appColor.whiteish, borderRadius: BorderRadius.circular(4.r)),
        height: 77.h,
        child: Stack(
          children: [
            _buildBackgroundWidget(context, appColor),
            _buildForcegroundWidget(context, appColor),
          ],
        ),
      ),
    );
  }

  Container _buildBackgroundWidget(BuildContext context, AppColor appColor) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 77.h,
      decoration: BoxDecoration(
          color: appColor.whiteish,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: [
            BoxShadow(
                color: appColor.greyish,
                offset: const Offset(0, 5),
                blurRadius: 5,
                blurStyle: BlurStyle.normal)
          ],
          border: Border.all(
            color: appColor.greyish.shade600,
          )),
    );
  }

  Container _buildForcegroundWidget(BuildContext context, AppColor appColor) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 77.h,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          left: 20.w,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildImageWidget(appColor),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(),
                      Text(
                        product.productName,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: appColor.blackish),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.productFullName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: appColor.greyish),
                            ),
                          ),
                          InkWell(
                            onTap: () => onTap?.call(),
                            borderRadius: BorderRadius.circular(4.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5.h, horizontal: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: appColor.redish),
                              child: Text(
                                "عرض التفاصيل",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: appColor.whiteish,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // if(showReportButton && isScrollshep||eductionPlan !=null)
                      Text(
                        "السعر:   ${fixPrice(product.price)}\$",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: appColor.redish),
                      ),
                      const SizedBox(),
                    ],
                  ),
                )
              ],
            ),
            if (product.isHiden)
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
        ));
  }

  String fixPrice(double number) {
    if (number.toInt() == number) {
      return "${number.toInt()}";
    } else {
      return number.toString();
    }
  }

  Container _buildImageWidget(AppColor appColor) {
    return Container(
      width: 77.h,
      height: 77.h,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: appColor.redish, width: 2.0),
          color: appColor.redish.shade200),
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(16.r),
        child: product.imageUrl != null
            ? Hero(
                tag: product.imageUrl!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: CachedNetworkImage(
                    imageUrl: product.imageUrl ?? Assets.png.logoWhite.path,
                    width: 67.h,
                    height: 69.h,
                    fit: BoxFit.cover,
                    // progressIndicatorBuilder: (context, url, progress) {
                    //   if (progress.totalSize == null) {
                    //     return const Center(child: CircularProgressIndicator());
                    //   }
                    //   final pr =
                    //       (progress.downloaded) / (progress.totalSize ?? 1);
                    //   return Center(
                    //     child: CircularProgressIndicator(
                    //       value: pr,
                    //     ),
                    //   );
                    // },
                    errorWidget: (context, error, stackTrace) {
                      return Image.asset(
                        Assets.png.logoWhite.path,
                        width: 67.h,
                        height: 69.h,
                      );
                    },
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: Assets.png.logoWhite.image(
                  width: 67.h,
                  height: 69.h,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
