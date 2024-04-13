import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/pages/group_page.dart';
import 'package:ayad/src/pages/service_part_page.dart';
import 'package:ayad/src/providers/get_all_main_group_provider.dart';
import 'package:ayad/src/widgets/child_warpper_animation_widget.dart';
import 'package:ayad/src/widgets/group_button_widget.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/theme.dart';
import 'package:ayad/users/auth/auth_notifier.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CoustomerHomeListComponent extends ConsumerWidget {
  const CoustomerHomeListComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(authNotifierProvider).value?.currentUser?.type ==
        UserType.admin;

    return Column(
      children: [
        if (isAdmin)
          TextButton(
            child: const Text("إضافة قسم جديد"),
            onPressed: () async {
              if (isAdmin) {
                await DilogsHelper.showGroupForm(context,
                    isMain: true, groupType: GroupType.customer);
              }
            },
          ),
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              return ref.watch(getAllGroupProvider(GroupType.customer)).when(
                data: (data) {
                  return RefreshIndicator(
                    backgroundColor: ref.read(appColorLightProvider).whiteish,
                    onRefresh: () async {
                      ref
                          .read(
                              getAllGroupProvider(GroupType.customer).notifier)
                          .init();
                    },
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 5,
                              childAspectRatio: (3 / 2),
                              crossAxisCount: 2),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // if (index == data.length) {
                        //   return GroupButtonWidget(
                        //     group: Group(
                        //         type: GroupType.customer,
                        //         parentGroupId: "",
                        //         subType: SubType.groups,
                        //         createdAt: DateTime.now(),
                        //         isMainGroup: true,
                        //         name: "التوصية على قطع غير موجودة",
                        //         isHiden: false),
                        //     onTap: () {
                        //       context.push(ServicePartPage.routePath,
                        //           );
                        //     },
                        //   );
                        // }
                        return  ChildWrpperWithAnimation(
                          animationTypes:const {
                            AnimationType.slide,
                            AnimationType.fade,
                            AnimationType.scall
                          },
                          wantKeepAlive: true,
                          child: GroupButtonWidget(
                            group: data[index],
                            onLongPress: () async {
                              if (isAdmin) {
                                await DilogsHelper.showGroupForm(context,
                                    groupType: GroupType.customer,
                                    group: data[index],
                                    isMain: true);
                              }
                            },
                            onTap: () {
                              if (data[index].isSeivce == true) {
                                context.push(ServicePartPage.routePath,extra: false);
                              } else {
                                context.push(SubGroupPage.routePath,
                                    extra: data[index]);
                              }
                            },
                          ),
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
        ),
      ],
    );
  }
}
