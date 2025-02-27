import 'package:ayad/src/components/user_notification_component.dart';
import 'package:ayad/src/data/supabase_product_repository.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/currency_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/maps_button_widget.dart';
import 'package:ayad/src/widgets/whats_app_product_button.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as init;

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key, required this.product});
  final Product product;

  static String get routeName => "product-page";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    final isAdmin = ref.watch(authNotifierProvider).value?.currentUser?.type ==
        UserType.admin;

    return PageTemplate(
        title: product.productFullName,
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
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
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
                            Expanded(
                              child: Text(
                                product.productFullName,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: appColor.redish, fontSize: 26),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        _buildTitlteInfoWidget(context, appColor, "اسم المنتج",
                            product.productFullName),
                        // _buildTitlteInfoWidget(context, appColor,
                        //     "اسم المنتج بالعربي", product.nameArabic),
                        // _buildTitlteInfoWidget(context, appColor,
                        //     "اسم المنتج بالأنجليزية", product.nameEnglis),
                        // if (product.productCode != null)
                        //   _buildTitlteInfoWidget(context, appColor,
                        //       "كود المنتج", product.productCode ?? "-"),
                        if (product.newPrice == null && product.newPrice != 0.0)
                          Row(
                            children: [
                              Text(
                                "سعر المنتج ",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                             Text(
                               ref.read(currencyFormatProvider(product.price)),
                                 textDirection: TextDirection.ltr,
                                 style: Theme.of(context)
                                     .textTheme
                                     .labelMedium
                                     ?.copyWith(color: appColor.redish))
                            ],
                          )
                        // _buildTitlteInfoWidget(context, appColor,
                        //     "سعر المنتج", init..currency(symbol: "\$").format(product.price))

                        else
                          _buildTitltePricesWidget(context, appColor),
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
                        const MapButton(),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (isAdmin)
                          DynamicButton(
                            title: "حذف",
                            onPressed: () async {
                              if (isAdmin) {
                                return await showDialog(
                                  context: context,
                                  builder: (context2) {
                                    return AlertDialog(
                                      title: const Text("تحذير"),
                                      content: const Text(
                                          "أنت على وشك حذف المنتج نهائياََ , هل تريد المتابعة؟"),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              BotToast.showLoading();
                                              await ref
                                                  .read(
                                                      supabaseProductRepositoryProvider)
                                                  .delete(product.id ?? "");
                                              BotToast.closeAllLoading();
                                              if (context2.mounted) {
                                                context2.pop();
                                              }
                                              if (context.mounted) {
                                                context.pop(true);
                                              }
                                            },
                                            child: const Text("نعم")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text("لا"))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (isAdmin)
                          DynamicButton(
                            type: ButtonTypes.Alternative,
                            title:
                                "إرسال إشعار منتج لكافة ${product.groupType == GroupType.vistor ? "الزوار" : "الزبائن"}",
                            onPressed: () async {
                              if (isAdmin) {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return UserNotificationComponent(
                                      productId: product,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        SizedBox(
                          height: 20.h,
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

  Widget _buildTitltePricesWidget(BuildContext context, AppColor appColor) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          children: [
            Text(
              "السعر : ",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              "${fixPrice(product.price)}\$",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: appColor.redish,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              Icons.new_releases,
              color: appColor.greenish,
              size: 10,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              "${fixPrice(product.newPrice ?? 0.0)}\$",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: appColor.greenish,
                    fontSize: 18,
                  ),
            ),
          ],
        ));
  }
}
