import 'package:ayad/src/components/slides_component.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/group_page.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/pages/service_part_page.dart';
import 'package:ayad/src/providers/get_all_main_group_provider.dart';
import 'package:ayad/src/widgets/group_button_widget.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/src/widgets/type_ahead_widget.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:marquee/marquee.dart';

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
              Container(
                height: 40,
                decoration: BoxDecoration(
                    color: ref.read(appColorLightProvider).redish,
                    borderRadius: BorderRadius.circular(4)),
                child: Marquee(
                    style: TextStyle(
                        color: ref.read(appColorLightProvider).whiteish),
                    blankSpace: MediaQuery.of(context).size.width,
                    text:
                        "بسم الله الرحمن الرحيم , الحمد لله رب العالمين , الرحمن الرحيم , مالك يوم الدين , إياك نعبد وإياك نستعين "),
              ),
               SizedBox(
                height: 10.h,
              ),
              const SlidesComponent(),
              SizedBox(
                height: 10.h,
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
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(getAllGroupProvider).when(
                      data: (data) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3,
                                  crossAxisCount: 2),
                          itemCount: data.length + 1,
                          itemBuilder: (context, index) {
                            if (index == data.length) {
                             return GroupButtonWidget(
                                group: const Group(
                                    isMainGroup: true,
                                    name: "التواصي للقطع الغير موجودة",
                                    name2: "",
                                    isHiden: false),
                                onTap: () {
                                  context.push(ServicePartPage.routePath,
                                      extra: fakeGroups.first);
                                },
                              );
                            }
                            return GroupButtonWidget(
                              group: data[index],
                              onTap: () {
                                context.push(SubGroupPage.routePath,
                                    extra: fakeGroups.first);
                              },
                            );
                          },
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
