import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/whats_app_product_button.dart';
import 'package:ayad/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key, required this.product});
  final Product product;

  static String get routeName => "product-page";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return PageTemplate(
        title: product.nameEnglis,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  // padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                      // border: Border.all(color: appColor.whiteish),
                      color: appColor.whiteish,
                      boxShadow: [
                        BoxShadow(
                            color: appColor.greyish,
                            offset: const Offset(1, 1),
                            blurRadius: 3)
                      ],
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.imageUrl != null)
                          Container(
                            height: 400,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                // border: Border.all(color: appColor.whiteish),
                                color: appColor.whiteish,
                                boxShadow: [
                                  BoxShadow(
                                      color: appColor.greyish,
                                      offset: const Offset(1, 1),
                                      blurRadius: 3)
                                ],
                                borderRadius: BorderRadius.circular(4.r)),
                            child: Hero(
                              tag: product.imageUrl!,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            progress) =>
                                        const Center(
                                          child: LoadingWidget(),
                                        ),
                                    width: MediaQuery.of(context).size.width,
                                    imageUrl: product.imageUrl!),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.nameEnglis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: appColor.redish, fontSize: 26),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildTitlteInfoWidget(
                            context, appColor, "المحموعة:", product.groupName),
                        _buildTitlteInfoWidget(context, appColor,
                            "اسم المنتج بالعربي", product.nameArabic),
                        _buildTitlteInfoWidget(context, appColor,
                            "اسم المنتج بالأنجليزية", product.nameEnglis),
                        if (product.productCode != null)
                          _buildTitlteInfoWidget(context, appColor,
                              "كود المنتج", product.productCode ?? "-"),
                        _buildTitlteInfoWidget(context, appColor, "سعر المنتج",
                            "${product.price}\$"),
                        if (product.type != null)
                          _buildTitlteInfoWidget(
                              context, appColor, "النوع", product.type ?? "-"),
                        if (product.count != null)
                          _buildTitlteInfoWidget(context, appColor,
                              "الكمية المتوفرة", fixPrice(product.count ?? 0)),
                        if (product.makfol != null)
                          if (product.makfol!)
                            _buildTitlteInfoWidget(
                                context, appColor, "الكفالة", "مكفول",
                                color: appColor.greenish)
                          else
                            _buildTitlteInfoWidget(
                                context, appColor, "الكفالة", "غير مكفول",
                                color: appColor.redish),
                        if (product.description != null)
                          _buildTitlteInfoWidget(context, appColor, "تفاصيل",
                              product.description ?? "-"),
                        SizedBox(
                          height: 40.h,
                        ),
                        WhatsAppProductButton(product: product),
                        SizedBox(
                          height: 10.h,
                        ),
                        DynamicButton(
                          title: "تحديث",
                          onPressed: () async {
                            await DilogsHelper.showProductForm(context,
                                product: product);
                          },
                        ),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  String fixPrice(double number) {
    if (number.toInt() == number) {
      return "${number.toInt()}";
    } else {
      return number.toString();
    }
  }

  Widget _buildTitlteInfoWidget(
      BuildContext context, AppColor appColor, String title, String info,
      {Color? color}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: RichText(
          text: TextSpan(
              text: "$title:",
              style: Theme.of(context).textTheme.labelLarge,
              children: [
            TextSpan(
                text: "  $info",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: color ?? appColor.redish))
          ])),
    );
  }
}
