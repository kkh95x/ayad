import 'package:ayad/src/models/group.dart';
import 'package:ayad/src/models/product.dart';
import 'package:ayad/src/providers/app_notification_provider.dart';
import 'package:ayad/src/providers/notification_provider.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/users/domain/user.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

final userFormNoification = Provider<FormGroup>((ref) => FormGroup({
      "title": FormControl<String>(validators: [Validators.required]),
      "body": FormControl<String>(validators: [Validators.required]),
      "isVistor": FormControl<bool>(),
      "isCustormer": FormControl<bool>(value: true),
    }));

class UserNotificationComponent extends ConsumerWidget {
  const UserNotificationComponent({super.key, this.productId, this.user});
  final AppUser? user;
  final Product? productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = ref.read(userFormNoification);
    return AlertDialog(
      title: const Text("إرسال إشعار"),
      content: ReactiveForm(
          formGroup: formGroup,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("العنوان"),
                MainTextFieldWidget(
                  placeholder: "",
                  control: "title",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("المحتوى"),
                MainTextFieldWidget(
                  placeholder: "",
                  control: "body",
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   "ملاحظة : حتى نتمكن من إرسال إشعار لجهاز المستخدم يجب عليه تسجيل الدخول أولاََ وإلا لن نتمكن من الوصول لمعلومات جهازه. ",
                //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
                //       color: ref.read(appColorLightProvider).greyish.shade400),
                // ),
                if (user == null && productId == null) ...[
                  Row(
                    children: [
                      ReactiveCheckbox(
                        formControlName: "isCustormer",
                      ),
                      const Text("الزبائن")
                    ],
                  ),
                  Row(
                    children: [
                      ReactiveCheckbox(
                        formControlName: "isVistor",
                      ),
                      const Text("الزورا")
                    ],
                  ),
                ],
                const SizedBox(
                  height: 30,
                ),
                if (user == null)
                  ReactiveFormConsumer(builder: (context, formGroup, child) {
                    final isVisor = formGroup.control("isVistor").value as bool?;
                    final isCustormer =
                        formGroup.control("isCustormer").value as bool?;
                    final isAll = isVisor == true && isCustormer == true;
                    final userType =
                        isVisor == true ? UserType.anon : UserType.customer;
                    return DynamicButton(
                      isDisabled: formGroup.invalid ||
                          (isVisor == false && isCustormer == false),
                      title: "إرسال",
                      onPressed: () async {
                        BotToast.showLoading();
                        if (productId == null) {
                          await ref
                              .read(appNotificationHelperProvider)
                              .sendToAllUsersNotification(
                                  formGroup.control("title").value,
                                  formGroup.control("body").value,
                                  isAll: isAll,
                                  userType: userType,
                                  productId: null);
                        } else {
                          await ref
                              .read(appNotificationHelperProvider)
                              .sendToAllUsersNotification(
                                  formGroup.control("title").value,
                                  formGroup.control("body").value,
                                  isAll: false,
                                  userType:
                                      productId?.groupType == GroupType.vistor
                                          ? UserType.anon
                                          : UserType.customer,
                                  productId: productId?.id ?? "");
                        }
                        if (productId == null) {
                          await ref
                              .read(notificationProviider)
                              .callOnFcmApiSendPushNotifications(
                                  isAll: isAll,
                                  userType: userType,
                                  title: formGroup.control("title").value,
                                  body: formGroup.control("body").value);
                          BotToast.closeAllLoading();
                          BotToast.showText(text: "تم إرسال الأشعار بنجاح");
                          formGroup.reset();
                          if (context.mounted) {
                            context.pop();
                          }
                        } else {
                          await ref
                              .read(notificationProviider)
                              .callOnFcmApiSendPushNotifications(
                                  isAll: false,
                                  userType:
                                      productId?.groupType == GroupType.vistor
                                          ? UserType.anon
                                          : UserType.customer,
                                  title: formGroup.control("title").value,
                                  body: formGroup.control("body").value);
                          BotToast.closeAllLoading();
                          BotToast.showText(text: "تم إرسال الأشعار بنجاح");
                          formGroup.reset();
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      },
                    );
                  })
                else
                  ReactiveFormConsumer(builder: (context, formGroup, child) {
                    return DynamicButton(
                      isDisabled: formGroup.invalid,
                      title: "إرسال",
                      onPressed: () async {
                        BotToast.showLoading();
                        await ref
                            .read(appNotificationHelperProvider)
                            .sendToUserNotification(
                                formGroup.control("title").value,
                                formGroup.control("body").value,
                                user!);
                        await ref
                            .read(notificationProviider)
                            .singleCallOnFcmApiSendPushNotifications(
                                appUser: user!,
                                title: formGroup.control("title").value,
                                body: formGroup.control("body").value);
                        BotToast.closeAllLoading();
                        BotToast.showText(text: "تم إرسال الأشعار بنجاح");
                        formGroup.reset();
                        if (context.mounted) {
                          context.pop();
                        }
                      },
                    );
                  })
              ],
            ),
          )),
    );
  }
}
