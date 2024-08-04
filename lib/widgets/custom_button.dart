import 'package:flutter/material.dart';

import '../config/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final bool showBorder;
  final double borderWidth;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? loadingColor;
  final Color? iconColor;
  final bool boldText;
  final bool isLoading;

  final Widget? image;
  const CustomButton(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.isLoading = false,
      this.transparent = false,
      this.margin = const EdgeInsets.symmetric(horizontal: 40),
      this.loadingColor,
      this.width = Dimensions.webMaxWidth,
      this.height = 45,
      this.fontSize,
      this.iconColor,
      this.radius = 5,
      this.icon,
      this.image,
      this.showBorder = false,
      this.borderWidth = 1,
      this.borderColor,
      this.textColor,
      this.backgroundColor,
      this.boldText = true});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      minimumSize: Size(width, height),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: showBorder
              ? BorderSide(
                  color: borderColor ?? Theme.of(context).primaryColor,
                  width: borderWidth)
              : const BorderSide(color: Colors.transparent)),
    );

    return Center(
      child: SizedBox(
        width: width,
        child: Padding(
          padding: margin,
          child: ElevatedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();

              onPressed?.call();
            },
            style: flatButtonStyle,
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSeven),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor:
                          loadingColor ?? backgroundColor ?? Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon != null
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  right: Dimensions.paddingSizeExtraSmall),
                              child: Icon(icon,
                                  color: transparent
                                      ? Theme.of(context).primaryColor
                                      : iconColor ?? Colors.white),
                            )
                          : image ?? const SizedBox(),
                      Text(
                        buttonText,
                        style: TextStyle(
                          color: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.textStyle
                              ?.resolve({})?.color,
                          fontSize: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.textStyle
                              ?.resolve({})?.fontSize,
                          fontWeight: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.textStyle
                              ?.resolve({})?.fontWeight,
                          fontFamily: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.textStyle
                              ?.resolve({})?.fontFamily,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
