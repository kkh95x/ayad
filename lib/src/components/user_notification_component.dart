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
      "body": FormControl<String>(validators: [Validators.required])
    }));

class UserNotificationComponent extends ConsumerWidget {
  const UserNotificationComponent(
      {super.key,  this.appUsers, this.productId});
  final List<AppUser>? appUsers;
  final String? productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = ref.read(userFormNoification);
    return AlertDialog(
      title: const Text("إرسال إشعار"),
      content: ReactiveForm(
          formGroup: formGroup,
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
              const SizedBox(
                height: 30,
              ),
              ReactiveFormConsumer(builder: (context, formGroup, child) {
                return DynamicButton(
                  isDisabled: formGroup.invalid,
                  title: "إرسال",
                  onPressed: () async {
                    BotToast.showLoading();
                    await ref
                        .read(appNotificationHelperProvider)
                        .sendToAllUsersNotification(
                            formGroup.control("title").value,
                            formGroup.control("body").value,
                            users: appUsers,
                            productId: productId);
                    await ref
                        .read(notificationProviider)
                        .callOnFcmApiSendPushNotifications(
                            appUsers
                                ?.where((element) => element.token != null)
                                .map((e) => e.token!)
                                .toList(),
                            formGroup.control("title").value,
                            formGroup.control("body").value);
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
          )),
    );
  }
}
