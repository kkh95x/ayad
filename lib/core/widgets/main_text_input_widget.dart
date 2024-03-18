import 'package:ayad/theme.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class MainTextFieldWidget extends ConsumerWidget {
  MainTextFieldWidget({
    super.key,
    this.placeholderIcon,
    this.radius = 10,
    this.width = 335,
    this.height = 38,
    required this.placeholder,
    this.control,
    this.numreicFormat,
    this.dateFormat,
    this.multiLine = false,
    this.type = Type.text,
    this.obscure = false,
    this.textInputAction = TextInputAction.next,
    this.autoFoucs = false,
    this.isDisabled = false,
    this.onchange,
    this.validationMessages,
    this.readOnly = false,
    this.keyboardType,
    this.style,
    this.isRequired = false,
    this.inputFormatters,
    this.suffixIcon,
    this.reactiveDatePickerFieldType = ReactiveDatePickerFieldType.date,
    this.onSubmitted,
    this.focusNode,
    this.label,
  });
  final String? control;
  final String? label;
  final Widget? placeholderIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final double radius;
  final double width;
  final double height;
  final String placeholder;
  final intl.NumberFormat? numreicFormat;
  final intl.DateFormat? dateFormat;
  final bool? multiLine;
  final Type type;
  final bool obscure;
  final TextInputAction? textInputAction;
  final void Function(FormControl)? onchange;
  final bool autoFoucs;
  final bool readOnly;
  final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();
  final TextInputType? keyboardType;
  final bool isDisabled;
  final TextStyle? style;
  final bool isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final ReactiveDatePickerFieldType reactiveDatePickerFieldType;
  final void Function(FormControl<dynamic>)? onSubmitted;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);

    return Container(
      padding: EdgeInsets.only(top: 10.h),
      // constraints: BoxConstraints(maxHeight: height.h + 20.h),
      //height:45.h,
      width: width,

      child: ReactiveFormConsumer(
        builder: (BuildContext context, FormGroup formGroup, Widget? child) {
          bool enable = ref.watch(toggleProvider);

          return type == Type.phoneNumber
              ? ReactivePhoneFormField<PhoneNumber>(
                  readOnly: readOnly,
                  enabled: !isDisabled,
                  formControlName: control,
                  focusNode: FocusNode(),
                  style: style ??
                      Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: colorProvider.greyish.shade400),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                        fontSize: 12),
                    prefixIcon: placeholderIcon,
                    prefixStyle: textThemeLight.labelSmall!
                        .copyWith(color: colorProvider.greyish.shade400),
                    suffixStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: colorProvider.greyish.shade400,
                            ),
                    errorMaxLines: 1,
                    fillColor: colorProvider.whiteish,
                    contentPadding: EdgeInsets.only(right: 50.w),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorProvider.greyish),
                        borderRadius: BorderRadius.circular(
                          radius,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorProvider.greyish),
                        borderRadius: BorderRadius.circular(
                          radius,
                        )),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colorProvider.greyish),
                        borderRadius: BorderRadius.circular(
                          radius,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide( color: colorProvider.redish.shade200),
                        borderRadius: BorderRadius.circular(
                          radius,
                        )),
                    filled: true,
                    hintText: placeholder,
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: colorProvider.greyish.shade400,
                        ),
                  ),
                  textInputAction: textInputAction,
                )
              : type == Type.date
                  ? Theme(
                      data: ThemeData.light(),
                      child: ReactiveDateTimePicker(
                        type: reactiveDatePickerFieldType,
                        dateFormat: dateFormat,
                        formControlName: control,
                        getInitialDate:
                            (DateTime? selectedDate, DateTime? currentDate) =>
                                DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        style: style ??
                            textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400),
                        validationMessages: validationMessages ??
                            {
                              ValidationMessage.required: (error) =>
                                  "required" ,
                              ValidationMessage.mustMatch: (error) =>
                                  "Must match" ,
                              ValidationMessage.minLength: (error) =>
                                  "MinLength 8" ,
                              ValidationMessage.email: (error) =>
                                  "Email format error" ,
                            },
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              color: Colors.red,
                              fontStyle: FontStyle.italic,
                              fontSize: 12),
                          suffixIconColor: colorProvider.greyish.shade400,
                          prefixIcon: placeholderIcon,
                          prefixStyle: textThemeLight.labelSmall!
                              .copyWith(color: colorProvider.greyish.shade400),
                          // contentPadding: const EdgeInsets.symmetric(
                          //   horizontal: 14,
                          // ),
                          fillColor: colorProvider.whiteish,
                          hintText: placeholder,
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: colorProvider.greyish.shade400,
                                  ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: colorProvider.greyish),
                            borderRadius: BorderRadius.circular(
                              radius,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorProvider.greyish),
                              borderRadius: BorderRadius.circular(
                                radius,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                   color: colorProvider.redish.shade200),
                              borderRadius: BorderRadius.circular(
                                radius,
                              )),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: colorProvider.redish),
                              borderRadius: BorderRadius.circular(
                                radius,
                              )),
                          filled: true,
                        ),
                      ),
                    )
                  : obscure
                      ? ReactiveTextField(
                          readOnly: readOnly,
                          onChanged: onchange,
                          autofocus: autoFoucs,
                          maxLines: multiLine == true ? 4 : 1,
                          style: style ??
                              textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400,
                              ),
                          formControlName: control,
                          keyboardType: keyboardType ??
                              (type == Type.text
                                  ? TextInputType.text
                                  : TextInputType.number),
                          obscureText: obscure ? enable : false,                          
                          decoration: InputDecoration(
                            //label: Text(label??''),
                            errorStyle: const TextStyle(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                            isDense: true,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            hintText: placeholder,
                            hintStyle: textThemeLight.labelSmall!.copyWith(
                              color: colorProvider.greyish.shade400,
                            ),
                            contentPadding: const EdgeInsets.only(right: 50),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixStyle: textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400),
                            suffixIcon: obscure
                                ? Consumer(
                                    builder: (context, ref, child) {
                                      return GestureDetector(
                                          onTap: () {
                                            ref
                                                .read(toggleProvider.notifier)
                                                .toggle();
                                          },
                                          child: Icon(
                                            enable
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 16,
                                            color:
                                                colorProvider.greyish.shade400,
                                          ));
                                    },
                                  )
                                : null,
                            prefixStyle: textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400),
                            prefixIcon: placeholderIcon,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorProvider.greyish),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorProvider.redish),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorProvider.greyish),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colorProvider.redish.shade200),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            fillColor: colorProvider.whiteish,
                            filled: true,
                          ),
                          validationMessages: validationMessages ??
                              {
                                ValidationMessage.required: (error) =>
                                    "required" ,
                                ValidationMessage.mustMatch: (error) =>
                                    "Must match" ,
                                ValidationMessage.minLength: (error) =>
                                    "MinLength 8" ,
                                ValidationMessage.email: (error) =>
                                    "Email format error" ,
                              },
                          textInputAction: textInputAction,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                        )
                      : ReactiveTextField(
                          readOnly: readOnly,
                          onChanged: onchange,
                          autofocus: autoFoucs,
                          focusNode: focusNode,                          
                          onSubmitted: onSubmitted,
                          inputFormatters: inputFormatters,
                          maxLines: multiLine == true ? 4 : 1,
                          style: style ??
                              textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400,
                              ),
                          formControlName: control,
                          keyboardType: keyboardType ??
                              (type == Type.text
                                  ? TextInputType.text
                                  : TextInputType.number),
                          decoration: InputDecoration(
                            labelText: label,
                            labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: colorProvider.blackish),
                            //label:title==null? null: Text(title!,style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colorProvider.blackish)),
                            errorStyle: const TextStyle(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                            isDense: true,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            hintText: placeholder,
                            hintStyle:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: colorProvider.greyish.shade400,
                                      height: enable
                                          ? null
                                          : multiLine == true
                                              ? 4
                                              : 1,
                                    ),
                            //floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixStyle: textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400),
                            suffixIcon: (suffixIcon != null)
                                ? suffixIcon
                                : obscure
                                    ? Consumer(
                                        builder: (context, ref, child) {
                                          return GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(
                                                        toggleProvider.notifier)
                                                    .toggle();
                                              },
                                              child: Icon(
                                                  enable
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  size: 16,
                                                  color: colorProvider
                                                      .greyish.shade400));
                                        },
                                      )
                                    : null,
                            prefixStyle: textThemeLight.labelSmall!.copyWith(
                                color: colorProvider.greyish.shade400),
                            prefixIcon: placeholderIcon,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorProvider.greyish),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorProvider.redish),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorProvider.greyish),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colorProvider.redish.shade200),
                                borderRadius: BorderRadius.circular(
                                  radius,
                                )),
                            fillColor: colorProvider.whiteish,
                            filled: true,
                          ),
                          validationMessages: validationMessages ??
                              {
                                ValidationMessage.required: (error) =>
                                    "required" ,
                                ValidationMessage.mustMatch: (error) =>
                                    "Must match" ,
                                ValidationMessage.minLength: (error) =>
                                    "MinLength 8" ,
                                ValidationMessage.email: (error) =>
                                    "Email format error" ,
                              },
                          textInputAction: textInputAction,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                        );
        },
      ),
    );
  }
}

class ToggleState extends StateNotifier<bool> {
  ToggleState() : super(true);

  void toggle() {
    state = !state;
  }
}

final toggleProvider =
    StateNotifierProvider<ToggleState, bool>((ref) => ToggleState());

enum Type {
  text,
  number,
  double,
  phoneNumber,
  date,
}
