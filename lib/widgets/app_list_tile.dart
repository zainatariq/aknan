// app_list_tile
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../global/theme/app-colors/app_colors_light.dart';
import '../localization/change_language.dart';
import 'generic_dropdown.dart';

class AppListTile extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onTap;

  const AppListTile({
    super.key,
    this.title,
    this.trailing,
    this.onTap,
    this.leading,
  });
  factory AppListTile.switcher({
    String? title,
    String? leadingSvgPath,
    required bool value,
    Function(bool value)? onChange,
    Function()? onTap,
  }) {
    return AppListTile(
      title: title,
      onTap: onTap,
      leading: leadingSvgPath != null ? SvgPicture.asset(leadingSvgPath) : null,
      trailing: Switch(value: value, onChanged: onChange),
    );
  }
  factory AppListTile.leadingSvg({
    String? title,
    String? leadingSvgPath,
    Function()? onTap,
  }) {
    return AppListTile(
      title: title,
      onTap: onTap,
      leading: leadingSvgPath != null ? SvgPicture.asset(leadingSvgPath) : null,
      trailing: null,
    );
  }

  factory AppListTile.trailingSvg({
    String? title,
    String? leadingSvgPath,
    String? trailingSvgPath,
    Function()? onTap,
  }) {
    return AppListTile(
      title: title,
      onTap: onTap,
      leading: leadingSvgPath != null ? SvgPicture.asset(leadingSvgPath) : null,
      trailing: SvgPicture.asset(trailingSvgPath!),
    );
  }

  factory AppListTile.elevator({
    String? title,
    String? leadingSvgPath,
    String? trailingSvgPath,
    Function()? onTap,
  }) {
    return AppListTile(
      title: title,
      onTap: onTap,
      leading: null,
      trailing:
          // Row(
          Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("2"),
          SvgPicture.asset(trailingSvgPath!),
        ],
      ),
      //   children: [
      //   ],
      // ),
    );
  }

  factory AppListTile.langDropDown({
    String? title,
    String? leadingSvgPath,
    void Function(Lang? lang)? onSelectLang,
    Function()? onTap,
    Lang? selectedValue,
  }) {
    return AppListTile(
      title: title,
      onTap: onTap,
      leading: leadingSvgPath != null ? SvgPicture.asset(leadingSvgPath) : null,
      trailing: GenericDropdown<Lang>.icoStyle(
        Lang.values,
        itemToString: (p0) => p0.name.tre,
        onChanged: onSelectLang,
        selectedValue: selectedValue,
        selectStyle: TextStyle(
          color: AppColorsLight.instance.primaryColorBlue,
        ),
        unSelectStyle: TextStyle(
          color: AppColorsLight.instance.primaryColorBlack.withOpacity(0.6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ListTile(
        onTap: onTap,
        title: Text(
          "${title?.tre}",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: leading,
        trailing: trailing,

        // trailing: ,
      );
    });
  }
}
