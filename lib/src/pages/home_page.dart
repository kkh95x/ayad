import 'package:ayad/src/pages/group_page.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/get_all_main_group_provider.dart';
import 'package:ayad/src/widgets/group_button_widget.dart';
import 'package:ayad/src/widgets/type_ahead_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
              const TextSearchWidget(),
              SizedBox(
                height: 50.h,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(getAllGroupProvider).when(
                      data: (data) {
                        return SingleChildScrollView(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.center,
                            children: data
                                .map((e) => GroupButtonWidget(
                                      group: e,
                                      onTap: () {
                                        context.push(SubGroupPage.routePath,extra: fakeGroups.first);
                                      },
                                    ))
                                .toList(),
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
                          child: CircularProgressIndicator(),
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
