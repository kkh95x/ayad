import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/pages/products_page.dart';
import 'package:ayad/src/providers/get_sub_groub_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/group_button_widget.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/type_ahead_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubGroupPage extends ConsumerWidget {
  const SubGroupPage({super.key, required this.group});
  static String get routeName => "sub-group-page";
  static String get routePath => "/$routeName";
  final Group group;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
        title: group.name,
        child: Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Column(
            children: [
              const TextSearchWidget(),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: DynamicButton(
                      type: ButtonTypes.Secondary,
                      title: "إضافة مجموعة جديدة",
                      onPressed: () async {
                        await DilogsHelper.showGroupForm(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: DynamicButton(
                      type: ButtonTypes.Secondary,
                      title: "إضافة منتج جديد",
                      onPressed: () async{ await DilogsHelper.showProductForm(context);},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(getSubGroupProvider(group)).when(
                      data: (data) {
                        return Center(
                          child: SingleChildScrollView(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: data
                                  .map((e) => GroupButtonWidget(
                                        group: e,
                                        onTap: () {
                                          // if (group == fakeGroups.first) {
                                          if (group == fakeSub2Group.first) {
                                            context.push(ProductsPage.routePath,
                                                extra: data.first);
                                          } else {
                                            context.push(routePath,
                                                extra: data.first);
                                          }
                                        },
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return const Center(
                          child: Text("Error"),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: LoadingWidget(),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
