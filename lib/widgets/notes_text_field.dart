

import 'package:flutter/material.dart';

import '../config/dimensions.dart';
import '../global/theme/app-text-styles/app_text_styles.dart';


class NotesTextField extends StatelessWidget {
  const NotesTextField({
    super.key,
    required this.hint,
    required this.textEditingController,
  });

  final  hint;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      maxLines: 5,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).hintColor.withOpacity(.1),
      hintText: hint,
      hintStyle:AppTextStyle.text14Reg .copyWith(color: Theme.of(context).hintColor.withOpacity(.5)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        borderSide:  BorderSide(width: 0.5,
            color: Theme.of(context).hintColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        borderSide:  BorderSide(width: 0.5,
            color: Theme.of(context).primaryColor.withOpacity(0.5)),
      ),


    ),

    );
  }
}