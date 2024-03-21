import 'package:ayad/gen/assets.gen.dart';
import 'package:ayad/src/components/dialogs.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/providers/get_all_users_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/loading_widget.dart';
import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});
  static String get routeName => "users";
  static String get routePath => "/$routeName";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return PageTemplate(
        child: Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        _buildSearchWidget(ref, context),
        SizedBox(
          height: 30.h,
        ),
        DynamicButton(
          type: ButtonTypes.Alternative,
          title: "إضافة زبون جديد",
          onPressed: () async {
            await DilogsHelper.showUserForm(
              context,
            );
          },
        ),
        SizedBox(
          height: 20.h,
        ),
        Expanded(child: Consumer(builder: (context, ref, child) {
          return ref.watch(getAllUserProvider).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("لايوجد زبائن"),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      return Card(
                        color: appColor.whiteish,
                        surfaceTintColor: appColor.whiteish,
                        child: ListTile(
                          onTap: () async {
                            await DilogsHelper.showUserForm(context,
                                user: user);
                          },
                          trailing: user.isAdmin
                              ? Icon(
                                  Icons.policy_sharp,
                                  color: appColor.redish,
                                )
                              : null,
                          leading: CircleAvatar(
                            backgroundImage: Assets.png.person.image().image,
                          ),
                          title: Text.rich(
                            TextSpan(
                                text: user.fullName,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: " - ${user.username}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              color: appColor.greyish.shade400))
                                ]),
                          ),
                          subtitle: Text(
                            user.phone,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: appColor.greyish),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: LoadingWidget(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
              );
        }))
      ],
    ));
  }

  Widget _buildSearchWidget(WidgetRef ref, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      height: 40.h,
      child: TextField(
        onChanged: (value) {},
        decoration: InputDecoration(
          fillColor: ref.read(appColorLightProvider).whiteish,
          filled: true,
          label: Text(
            "البحث",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ref.read(appColorLightProvider).greyish.shade400),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ref.read(appColorLightProvider).greyish.shade400,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: ref.read(appColorLightProvider).greyish.shade400),
              borderRadius: BorderRadius.circular(
                16.r,
              )),
        ),
      ),
    );
  }
}
