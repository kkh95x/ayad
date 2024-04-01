import 'package:ayad/src/components/slides_component.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/group_page.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/get_all_main_group_provider.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/src/widgets/group_button_widget.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/type_ahead_widget.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marquee/marquee.dart';
import '../components/dialogs.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static String get routeName => "home-page";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageTemplate(
        title: "الصفحة الرئيسية",
        child: Padding(
          padding: EdgeInsets.all(10.0.r),
          child: Column(
            children: [
              Consumer(builder: (context, ref, child) {
                final setting = ref.watch(getSettingFuture).value;
                final user = ref.watch(authNotifierProvider).value?.currentUser;
                String text = " ";
                if (user?.type == UserType.anon) {
                  text = setting?.messageForVisotr ?? " ";
                } else if (user?.type == UserType.customer) {
                  text = setting?.messageForCoustomer ?? " ";
                } else if (user?.type == UserType.admin) {
                  text="الزوار: ";
                  text += setting?.messageForVisotr ?? " ";
                  text += ", الزبائن:";
                  text += setting?.messageForCoustomer ?? " ";
                }
                return Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: ref.read(appColorLightProvider).redish,
                      borderRadius: BorderRadius.circular(4)),
                  child: Marquee(
                      style: TextStyle(
                          fontSize: 16,
                          color: ref.read(appColorLightProvider).whiteish),
                      blankSpace: MediaQuery.of(context).size.width,
                      text:text,
                ));
              }),
              SizedBox(
                height: 2.h,
              ),
              const SlidesComponent(),
              SizedBox(
                height: 2.h,
              ),
              const TextSearchWidget(),

              // SizedBox(
              //   height: 20.h,
              // ),
              // Row(
              //   children: [
              //     Text("الأقسام الرئيسية",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ref.read(appColorLightProvider).redish),)
              //   ],
              // ),
              TextButton(
                child: const Text("إضافة قسم جديد"),
                onPressed: () async {
                  await DilogsHelper.showGroupForm(context, isMain: true);
                },
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(getAllGroupProvider).when(
                      data: (data) {
                        return RefreshIndicator(
                          backgroundColor:
                              ref.read(appColorLightProvider).whiteish,
                          onRefresh: () async {
                            ref.read(getAllGroupProvider.notifier).init();
                          },
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: (3 / 2),
                                    crossAxisCount: 2),
                            itemCount: data.length + 1,
                            itemBuilder: (context, index) {
                              if (index == data.length) {
                                return GroupButtonWidget(
                                  group: Group(
                                      type: GroupType.customer,
                                      parentGroupId: "",
                                      subType: SubType.groups,
                                      createdAt: DateTime.now(),
                                      isMainGroup: true,
                                      name: "التوصية على قطع غير موجودة",
                                      isHiden: false),
                                  onTap: () {
                                    // context.push(ServicePartPage.routePath,
                                    //     extra: fakeGroups.first);
                                  },
                                );
                              }
                              return GroupButtonWidget(
                                group: data[index],
                                onLongPress: () async {
                                  //TODO just admin
                                  await DilogsHelper.showGroupForm(context,
                                      group: data[index], isMain: true);
                                },
                                onTap: () {
                                  context.push(SubGroupPage.routePath,
                                      extra: data[index]);
                                },
                              );
                            },
                          ),
                        );

                        // SingleChildScrollView(
                        //   child: Wrap(
                        //     crossAxisAlignment: WrapCrossAlignment.center,
                        //     alignment: WrapAlignment.center,
                        //     children: data
                        //         .map((e) => GroupButtonWidget(
                        //               group: e,
                        //               onTap: () {
                        //                 context.push(SubGroupPage.routePath,
                        //                     extra: fakeGroups.first);
                        //               },
                        //             ))
                        //         .toList(),
                        //   ),
                        // );
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
