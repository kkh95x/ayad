import 'package:ayad/src/data/supabase_app_notification_repoository.dart';
import 'package:ayad/src/data/supabase_product_repository.dart';
import 'package:ayad/src/pages/page_template.dart';
import 'package:ayad/src/pages/product_page.dart';
import 'package:ayad/src/providers/my_notification_provider.dart';
import 'package:ayad/theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class MyNotificationPage extends ConsumerWidget {
  const MyNotificationPage({super.key});
  static String get routeName => "notification-page";
  static String get routePath => "/$routeName";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColor = ref.read(appColorLightProvider);
    return PageTemplate(
        title: "الإشعارات",
        child: Column(
          children: [
            Expanded(child: Consumer(
              builder: (context, ref, child) {
                final myNotification =
                    ref.watch(notificationPaginationProvider);
                return myNotification.when(
                  data: (data) {
                    if (data.$1.isEmpty) {
                      return const Center(
                        child: Text("لاتوجد إشعارات حالياََ"),
                      );
                    }
                    final isHaveMore = data.$1.length < data.$2;
                    return ListView.builder(
                      padding: EdgeInsets.only(top: 100.h),
                      itemCount: data.$1.length + (isHaveMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        final notification = data.$1[index];
                        return Card(
                          color: notification.isSeen
                              ? appColor.greyish
                              : appColor.whiteish,
                          child: ListTile(
                            onTap: () async {
                              if (!notification.isSeen) {
                                await ref
                                    .read(supabaseAppNotificationProvider)
                                    .update(
                                        notification.copyWith(isSeen: true));
                              }
                              if (notification.productId != null) {
                                BotToast.showLoading();
                                final produtct = await ref
                                    .read(supabaseProductRepositoryProvider)
                                    .get(notification.productId ?? "");
                                BotToast.closeAllLoading();
                                if (produtct == null) {
                                  BotToast.showText(
                                      text: "المنتج غير متوفر حالياََ");
                                } else {
                                  if (context.mounted) {
                                    context.push(ProductPage.routePath,
                                        extra: produtct);
                                  }
                                }
                              }
                            },
                            leading: notification.productId!=null?const Icon(Icons.notifications_none_outlined):null,
                            title: Text(notification.title),
                            subtitle: Text(notification.body),
                            trailing: Text(DateFormat.yMMMd("ar")
                                .format(notification.createAt)),
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) {
                    return const Center(
                      child: Text("خدث خطأ"),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ))
          ],
        ));
  }
}
