import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/models/slides.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/slides_admin_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlidesPage extends ConsumerWidget {
  const SlidesPage({super.key});
  static String get routeName => "slides";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return PageTemplate(
        child: Column(
      children: [
        DynamicButton(
          title: "إضافة إعلان جديد",
          onPressed: () async {
            await DilogsHelper.showSlides(context);
          },
        ),
        SizedBox(
          height: 10.h,
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ref.watch(slideNotiferProvider).when(
                    data: (data) {
                      if (data.isEmpty) {
                        return const Center(
                          child: Text("لا توجد إعلانات"),
                        );
                      }
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onLongPress: () async {
                                await DilogsHelper.showSlides(context,
                                    slide: data[index]);
                              },
                              onTap: () async {
                                await DilogsHelper.showSlides(context,
                                    slide: data[index]);
                              },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                              decoration: BoxDecoration(
                                  color: appColor.whiteish,
                                  boxShadow: [
                                    BoxShadow(
                                        color: appColor.greyish.shade400,
                                        blurRadius: 9,
                                        spreadRadius: 2,
                                        offset: const Offset(1, 1))
                                  ],
                                  borderRadius: BorderRadius.circular(4)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * .9,
                                      height: 150,
                                      child: CachedNetworkImage(
                                        imageUrl: data[index].imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  _buildTitlteInfoWidget(context, appColor,
                                      "العنون الرئيسي", data[index].title),
                                  _buildTitlteInfoWidget(
                                      context,
                                      appColor,
                                      "عنوان فرعي أيمين",
                                      data[index].right ?? "-"),
                                  _buildTitlteInfoWidget(context, appColor,
                                      "عنوان فرعي أيسر", data[index].left ?? "-"),
                                  _buildTitlteInfoWidget(
                                      context,
                                      appColor,
                                      "الحالة",
                                      data[index].isHiden ? "مخفي" : "غير مخفي"),
                                  _buildTitlteInfoWidget(
                                      context,
                                      appColor,
                                      "الجمهور",
                                      getStringFromSlideType(
                                          data[index].slidesType)),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(error.toString()),
                      );
                    },
                    loading: () => const Center(
                      child: LoadingWidget(),
                    ),
                  ),
            ))
      ],
    ));
  }

  String getStringFromSlideType(SlidesType slidesType) {
    if (slidesType == SlidesType.customer) {
      return "الزبائن فقط";
    } else if (slidesType == SlidesType.vistor) {
      return "الزوار فقط";
    } else if (slidesType == SlidesType.all) {
      return "الكل";
    } else {
      return "-";
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
