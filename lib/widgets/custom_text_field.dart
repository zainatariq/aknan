import '../localization/change_language.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/dimensions.dart';
import '../global/theme/app-text-styles/app_text_styles.dart';
import 'country_picker.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final bool isAmount;
  final Function(String text)? onChanged;
  final Function(String text)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final double borderRadius;
  final String? prefixIcon;
  final String? suffixIcon;
  final bool showBorder;
  final String? countryDialCode;
  final double prefixHeight;
  final Color? fillColor;
  final bool prefix;
  final bool suffix;
  final Function()? onPressedSuffix;
  final Function(CountryCode countryCode)? onCountryChanged;
  final Function()? onTap;
  final bool readOnly;
  final bool isLtr;
  const CustomTextField({
    super.key,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.onTap,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.isLtr = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.isAmount = false,
    this.borderRadius = 50,
    this.showBorder = true,
    this.prefixHeight = 50,
    this.countryDialCode,
    this.onCountryChanged,
    this.fillColor,
    this.prefix = true,
    this.suffix = true,
    this.suffixIcon,
    this.onPressedSuffix,
    this.validator,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    // if (widget.countryDialCode != null) {
    //   // widget.controller?.text = widget.countryDialCode!;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLtr) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: child(context),
      );
    } else {
      return child(context);
    }
  }

  TextFormField child(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      validator: widget.validator,
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: AppTextStyle.text16Reg,
      textInputAction: widget.inputAction,
      keyboardType: (widget.isAmount || widget.inputType == TextInputType.phone)
          ? const TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            )
          : widget.inputType,
      cursorColor: Theme.of(context).primaryColor,
      textCapitalization: widget.capitalization,
      enabled: widget.isEnabled,
      autofocus: false,
      autofillHints: _autofillHints(),
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputType == TextInputType.phone
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))
            ]
          : widget.isAmount
              ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
              : null,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
              width: widget.showBorder ? 1 : 0.5,
              color: Theme.of(context)
                  .primaryColor
                  .withOpacity(widget.showBorder ? 0.5 : 0.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
              width: widget.showBorder ? 0.5 : 0.5,
              color: Theme.of(context).primaryColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
              width: widget.showBorder ? 0.5 : 0.5,
              color: Theme.of(context).primaryColor.withOpacity(0.5)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
              width: widget.showBorder ? 0.5 : 0.5,
              color: Theme.of(context).colorScheme.error.withOpacity(0.5)),
        ),
        hintText: widget.hintText,
        fillColor:
            widget.fillColor ?? Theme.of(context).scaffoldBackgroundColor,
        hintStyle: Theme.of(context).textTheme.displaySmall,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.prefix
              ? Dimensions.paddingSizeExtraSmall
              : Dimensions.paddingSizeDefault,
          vertical: 10,
        ),
        prefixIcon: widget.prefix == false
            ? null
            : widget.prefixIcon != null
                ? Container(
                    margin: EdgeInsetsDirectional.only(
                        end: widget.fillColor != null ? 0 : 10),
                    width: widget.prefixHeight,
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: widget.fillColor != null
                          ? Colors.transparent
                          : Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.1),
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(widget.borderRadius),
                        bottomStart: Radius.circular(widget.borderRadius),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        widget.prefixIcon!,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  )
                // : Container(
                //     width: 70,
                //     decoration: BoxDecoration(
                //       color: widget.fillColor ??
                //           Theme.of(context)
                //               .scaffoldBackgroundColor
                //               .withOpacity(0.1),
                //       borderRadius: BorderRadiusDirectional.only(
                //         topStart: Radius.circular(widget.borderRadius),
                //         bottomStart: Radius.circular(widget.borderRadius),
                //       ),
                //     ),
                //     // margin: const EdgeInsets.only(right: 10),
                //     padding: const EdgeInsetsDirectional.only(start: 15),
                //     child: Center(
                //       child: CodePickerWidget(
                //         flagWidth: 25,
                //         enabled: false,
                //         onChanged: (code) {
                //           widget.controller?.text = code.dialCode.toString();
                //           widget.onCountryChanged?.call(code);
                //         },
                //         initialSelection: widget.countryDialCode,
                //         favorite: [widget.countryDialCode!],
                //         showDropDownButton: true,
                //         showCountryOnly: true,
                //         showOnlyCountryWhenClosed: true,
                //         showFlagDialog: true,
                //         hideMainText: true,
                //         showFlagMain: true,
                //         dialogBackgroundColor: Theme.of(context).cardColor,
                //         // barrierColor: Get.isDarkMode
                //         //     ? Colors.black.withOpacity(0.4)
                //         //     : null,
                //         textStyle: AppTextStyle.text16Reg,
                //       ),
                //     )),
                : const SizedBox(),
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.onPressedSuffix != null
                    ? widget.onPressedSuffix!
                    : null,
                child: Container(
                  margin:
                      EdgeInsets.only(right: widget.fillColor != null ? 0 : 10),
                  width: 40,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: widget.fillColor != null
                        ? Colors.transparent
                        : Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.1),
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(widget.borderRadius),
                      bottomStart: Radius.circular(widget.borderRadius),
                    ),
                  ),
                  child: Center(
                      child: Image.asset(widget.suffixIcon!,
                          height: 20, width: 20)),
                ),
              )
            : widget.isPassword
                ? IconButton(
                    icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color:
                            Theme.of(context).highlightColor.withOpacity(0.5)),
                    onPressed: _toggle,
                  )
                : null,
      ),
      onFieldSubmitted: (text) {
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        } else {
          FocusScope.of(context).unfocus();
        }
        widget.onFieldSubmitted?.call(text);
      },
      onChanged: widget.onChanged,
    );
  }

  List<String>? _autofillHints() {
    return widget.inputType == TextInputType.name
        ? [AutofillHints.name]
        : widget.inputType == TextInputType.emailAddress
            ? [AutofillHints.email]
            : widget.inputType == TextInputType.phone
                ? [AutofillHints.telephoneNumber]
                : widget.inputType == TextInputType.streetAddress
                    ? [AutofillHints.fullStreetAddress]
                    : widget.inputType == TextInputType.url
                        ? [AutofillHints.url]
                        : widget.inputType == TextInputType.visiblePassword
                            ? [AutofillHints.password]
                            : null;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
