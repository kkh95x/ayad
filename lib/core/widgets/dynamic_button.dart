import 'package:ayad/theme.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DynamicButton extends ConsumerWidget {
  const DynamicButton({
    super.key,
    this.title,
    this.icon,
    this.iconPosition = IconPosition.end,
    required this.onPressed,
    this.radius = 8,
    this.height = 40,
    this.type = ButtonTypes.Primary,
    this.isDisabled = false,
    this.style,
    this.fontSize = 14,
    this.heightButton,
    this.shape,
  });

  final String? title;
  final Widget? icon;
  final VoidCallback onPressed;
  final double radius;
  final double height;
  final ButtonTypes type;
  final IconPosition iconPosition;
  final bool isDisabled;
  final TextStyle? style;
  final double fontSize;
  final double? heightButton;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context, ref) {
    final colorProvider = ref.read(appColorLightProvider);
    return Container(
      height: heightButton,
      constraints: const BoxConstraints(
        maxWidth: 335,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // fixedSize height),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          elevation: 5,
          backgroundColor: customButtonColor(colorProvider) ??
              colorProvider.greenish.shade100,
          shape: shape ??
              RoundedRectangleBorder(
                side: (type == ButtonTypes.Secondary ||
                        type == ButtonTypes.onPrimary
                    ? BorderSide(
                        width: 2, color: colorProvider.greyish.shade700)
                    : type == ButtonTypes.Natural
                        ? BorderSide(
                            width: 1, color: colorProvider.greenish.shade200)
                        : BorderSide.none),
                borderRadius: BorderRadius.all(
                  Radius.circular(type == ButtonTypes.onPrimary ||
                          type == ButtonTypes.Alternative
                      ? 20
                      : radius),
                ),
              ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: title != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (iconPosition == IconPosition.start && icon != null)
                    const Spacer(),
                  if (iconPosition == IconPosition.start && icon != null) icon!,
                  if (iconPosition == IconPosition.start && icon != null)
                    SizedBox(width: 2.w),
                  Expanded(
                    flex: 7,
                    child: Text(
                      title ?? '',
                      style: style ??
                          Theme.of(context).textTheme.labelSmall?.copyWith(
                                fontSize: fontSize,
                                color: type == ButtonTypes.Secondary
                                    ? colorProvider.greyish.shade100
                                    : type == ButtonTypes.onPrimary
                                        ? colorProvider.blueish.shade100
                                        : type == ButtonTypes.Natural
                                            ? colorProvider.greenish.shade200
                                            : colorProvider.whiteish,
                              ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (iconPosition == IconPosition.end && icon != null)
                    SizedBox(width: 2.w),
                  if (iconPosition == IconPosition.end && icon != null)
                    Expanded(child: icon!),
                  if (iconPosition == IconPosition.end && icon != null)
                    const Spacer()
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Expanded(child: icon ?? const SizedBox())],
              ),
      ),
    );
  }

  Color? customButtonColor(AppColor colorProvider) {
    switch (type) {
      case ButtonTypes.Primary:
        return colorProvider.redish.shade200;
      case ButtonTypes.Secondary:
        return colorProvider.whiteish;
      case ButtonTypes.Natural:
        return colorProvider.whiteish;
      case ButtonTypes.Alternative:
        return colorProvider.purpleish.shade100;
      case ButtonTypes.onPrimary:
        return colorProvider.whiteish;

      case ButtonTypes.Remove:
        return colorProvider.redish;
    }
  }
}

enum ButtonTypes {
  Primary,
  Secondary,
  Natural,
  Alternative,
  onPrimary,
  Remove,
}

enum IconPosition {
  end,
  start,
}
