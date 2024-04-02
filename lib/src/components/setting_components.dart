import 'package:ayad/src/data/supbase_settings_repository.dart';
import 'package:ayad/src/models/settings.dart';
import 'package:ayad/src/providers/get_settings_provider.dart';
import 'package:ayad/src/providers/setting_form_provider.dart';
import 'package:ayad/src/providers/version_helper.dart';
import 'package:ayad/src/widgets/dynamic_button.dart';
import 'package:ayad/src/widgets/main_text_input_widget.dart';
import 'package:ayad/theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class SettingsFormComponent extends ConsumerWidget {
  const SettingsFormComponent({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingNotifer = ref.watch(getSettingAdminFuture);
    return AlertDialog(
        title: const Text("الإعدادات"),
        content: settingNotifer.when(
          data: (data) {
            final formGroup = ref.read(settingsformProvider(data));

            return ReactiveForm(
                formGroup: formGroup,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const Row(
                        children: [Text("رقم الواتساب")],
                      ),
                      MainTextFieldWidget(
                          type: Type.phoneNumber,
                          control: "whatsAppPhone",
                          placeholder: ""),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Row(
                        children: [Text("الحد الأدنى لإصدار التطبيق")],
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final version=ref.watch(getCurrentVersion).value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainTextFieldWidget(
                                
                                  control: "minVersin", placeholder: "1.0.1"),
                            if(version!=null)
                            Text("الإصدار الحالي $version",style: TextStyle(fontSize: 10,color: ref.read(appColorLightProvider).greenish),)
                              
                            ],
                          );
                        }
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Row(
                        children: [Text("رابط تحميل التطبيق")],
                      ),
                      MainTextFieldWidget(
                        control: "apkUrl",
                        placeholder: "",
                        multiLine: true,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      const Row(
                        children: [
                          Text(
                            "نص الشريط المتحرك للزبائن",
                          )
                        ],
                      ),
                      MainTextFieldWidget(
                        control: "messageForCoustomer",
                        multiLine: true,
                        placeholder: "",
                      ),
                      const Row(
                        children: [
                          Text(
                            "نص الشريط المتحرك للزائرين",
                          )
                        ],
                      ),
                      MainTextFieldWidget(
                        control: "messageForVisotr",
                        multiLine: true,
                        placeholder: "",
                      ),
                      const Row(
                        children: [
                          Text(
                            "ملاحظات التوصية على القطع",
                          )
                        ],
                      ),
                      MainTextFieldWidget(
                        control: "noteForParts",
                        multiLine: true,
                        placeholder: "",
                      ),
                      const Row(
                        children: [
                          Text(
                            "موقع المتجر",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MainTextFieldWidget(
                              control: "longtute",
                               
                              placeholder: "طول",
                            ),
                          ),
                          Expanded(
                            child: MainTextFieldWidget(
                              control: "landtute",
                            
                              placeholder: "عرض",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      DynamicButton(
                        type: ButtonTypes.Alternative,
                        title: "تحديث",
                        radius: 8,
                        onPressed: ()async {

                          BotToast.showLoading();
                          final stting=Settings(
                            apkUrl: formGroup.control("apkUrl").value,
                             whatsAppPhone:( formGroup.control("whatsAppPhone").value as PhoneNumber?)?.international??"",
                              messageForCoustomer: formGroup.control("messageForCoustomer").value,
                               messageForVisotr: formGroup.control("messageForVisotr").value,
                               landtute:formGroup.control("landtute").value ,
                               longtute:formGroup.control("longtute").value ,
                               minVersion:formGroup.control("minVersin").value ,
                               noteForParts:formGroup.control("noteForParts").value 
                               );
                          await ref.read(supabaseSettingsRepositoryProvider).update(stting).then((value){
                            BotToast.closeAllLoading();
                            context.pop();
                          });

                        },
                      ),
                      DynamicButton(
                        title: "العودة",
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                ));
          },
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
