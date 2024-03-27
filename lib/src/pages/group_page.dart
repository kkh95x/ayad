import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/components/products_component.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/get_sub_groub_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/group_button_widget.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/type_ahead_widget.dart';
import 'package:ayad/theme.dart';
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
                  if (group.subType == SubType.groups)
                    Expanded(
                      child: DynamicButton(
                        type: ButtonTypes.Secondary,
                        title: "إضافة مجموعة جديدة",
                        onPressed: () async {
                          await DilogsHelper.showGroupForm(context,
                              parentGroup: group, isMain: false);
                        },
                      ),
                    ),
                  if (group.subType == SubType.products) ...[
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: DynamicButton(
                        type: ButtonTypes.Secondary,
                        title: "إضافة منتج جديد",
                        onPressed: () async {
                          await DilogsHelper.showProductForm(context,parentGroup: group);
                        },
                      ),
                    )
                  ]
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              if (group.subType == SubType.groups)
                GroupsComponent(parentGroup: group, routePath: routePath),
              if (group.subType == SubType.products)
                ProductsComponent(
                  parentGroup: group,
                )
            ],
          ),
        ));
  }
}

class GroupsComponent extends StatelessWidget {
  const GroupsComponent({
    super.key,
    required this.parentGroup,
    required this.routePath,
  });

  final Group parentGroup;
  final String routePath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(getSubGroupProvider(parentGroup)).when(
            data: (data) {
              if (data.isEmpty) {
                return const Center(
                  child: Text("المجموعة فارغة حالياََ"),
                );
              }
              return Center(
                child: SingleChildScrollView(
                  child: RefreshIndicator(
                    backgroundColor: ref.read(appColorLightProvider).whiteish,
                    onRefresh: () async {
                      ref
                          .read(getSubGroupProvider(parentGroup).notifier)
                          .init();
                    },
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: data
                          .map((e) => GroupButtonWidget(
                                group: e,
                                onLongPress: () async {
                                  await DilogsHelper.showGroupForm(context,
                                      group: e,
                                      parentGroup: parentGroup,
                                      isMain: false);
                                },
                                onTap: () {
                                  // if (group == fakeGroups.first) {
                                  // if (group == fakeSub2Group.first) {
                                  //   context.push(ProductsPage.routePath,
                                  //       extra: data.first);
                                  // } else {
                                  // if (e.subType == SubType.groups) {
                                    context.push(routePath, extra: e);
                                  // } else {
                                  //   //TODO push products
                                  // }
                                  // }
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("حدث خطأ أثناء الإتصال بالسيرفر"),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(getSubGroupProvider(parentGroup).notifier)
                            .init();
                      },
                      icon: const Icon(Icons.refresh),
                    )
                  ],
                ),
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
    );
  }
}
