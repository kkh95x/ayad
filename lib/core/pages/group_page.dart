import 'package:ayad/core/models/group.dart';
import 'package:ayad/core/pages/page_template.dart';
import 'package:ayad/core/providers/get_sub_groub_provider.dart';
import 'package:ayad/core/widgets/group_button_widget.dart';
import 'package:ayad/core/widgets/type_ahead_widget.dart';
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
                                            context.push(routePath,
                                                extra: data.first);
                                          // }
                                          // else if (group ==
                                          //     fakeSubGroup.first) {
                                          //   context.push(routePath,
                                          //       extra: fakeSub2Group.first);
                                          // } else if (group ==
                                          //     fakeSub2Group.first) {
                                          //       context.push(routePath,
                                          //       extra: fakeSub3Group.first);
                                          // } else if (group ==
                                          //     fakeSub3Group.first) {
                                          //       //Push To List Proudects Page
                                          // }
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
