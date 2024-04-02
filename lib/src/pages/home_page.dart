import 'package:ayad/src/components/home_list_component.dart';
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

             
              SizedBox(
                height: 4.h,
              ),
             const Expanded(child:  HomeListComponent()),
               ],
          ),
        ));
  }
}
