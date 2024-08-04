import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenericDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final void Function(T? item)? onChanged;
  final String? Function(T)? itemToString;
  final bool showBorder;
  final bool withOutBg;
  final String? hintText;
  final TextStyle? selectStyle;
  final TextStyle? unSelectStyle;
  final String? prefixIconPath;
  final bool isInputStyle;
  const GenericDropdown({
    super.key,
    required this.items,
    this.selectedValue,
    this.withOutBg = false,
    this.isInputStyle = true,
    this.onChanged,
    this.itemToString,
    this.selectStyle,
    this.unSelectStyle,
    this.showBorder = true,
    this.hintText = '',
    this.prefixIconPath,
  });

  factory GenericDropdown.icoStyle(
    List<T> items, {
    T? selectedValue,
    void Function(T? item)? onChanged,
    String? Function(T)? itemToString,
    String? hintText,
    TextStyle? selectStyle,
    TextStyle? unSelectStyle,
    String? prefixIconPath,
  }) {
    return GenericDropdown(
      items: items,
      selectStyle: selectStyle,
      selectedValue: selectedValue,
      hintText: hintText,
      isInputStyle: false,
      itemToString: itemToString,
      onChanged: onChanged,
      prefixIconPath: prefixIconPath,
      showBorder: false,
      unSelectStyle: unSelectStyle,
      withOutBg: false,
    );
  }
  @override
  _GenericDropdownState<T> createState() => _GenericDropdownState<T>();
}

class _GenericDropdownState<T> extends State<GenericDropdown<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant GenericDropdown<T> oldWidget) {
    if (oldWidget.selectedValue != widget.selectedValue) {
      _selectedValue = widget.selectedValue;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        width: widget.showBorder ? 0.5 : 0.5,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInputStyle) {
      return InputDecorator(
        decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 55.h),
          border: inputBorder(),
          enabledBorder: inputBorder(),
          focusedBorder: inputBorder(),
          contentPadding: const EdgeInsets.all(10),
          // hintText: "jjjjj",
          prefixIcon: SizedBox(
            width: 45.w,
            child: Row(
              children: [
                widget.prefixIconPath != null
                    ? Container(
                        margin: const EdgeInsetsDirectional.only(start: 10),
                        width: 30,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: widget.withOutBg == true
                              ? Colors.transparent
                              : Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: SvgPicture.asset(
                          widget.prefixIconPath ?? '',
                          height: 20,
                          width: 20,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(width: 2),
                widget.prefixIconPath != null
                    ? Container(
                        height: 25,
                        width: 2,
                        color: Theme.of(context).hintColor.withOpacity(0.5),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        child: _child(),
      );
    } else {
      return SizedBox(
        height: 30,
        width: 75.w,
        child: _child(isIco: !widget.isInputStyle),
      );
    }
  }

  DropdownButton<T> _child({bool isIco = false}) {
    return DropdownButton<T>(
      dropdownColor: Colors.white,
      icon: isIco
          ? _selectedValue != null
              ? const SizedBox()
              : null
          : null,
      hint: isIco
          ? null
          : Builder(builder: (context) {
              return Text(
                "${widget.hintText}",
                style: Theme.of(context).textTheme.displaySmall,
              );
            }),
      //  SizedBox(
      //   width: max(Get.width - 120.w, Get.width / 2),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text("${widget.hintText}"),
      //       const Spacer(),
      //       const Icon(
      //         Icons.arrow_drop_down,
      //         color: Colors.grey,
      //       ),
      //     ],
      //   ),
      // ),
      // icon: const SizedBox(),
      isExpanded: true,
      // icon: const SizedBox(
      //   width: 100,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Icon(Icons.arrow_drop_down),
      //     ],
      //   ),
      // ),
      padding: const EdgeInsetsDirectional.only(start: 5),
      underline: const SizedBox(),
      value: _selectedValue,
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 300,
      items: widget.items.map((T item) {
        return DropdownMenuItem<T>(
          alignment: AlignmentDirectional.centerEnd,
          value: item,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.itemToString?.call(item) ?? item.toString(),
                style: (_selectedValue == item
                        ? widget.selectStyle
                        : widget.unSelectStyle) ??
                    TextStyle(
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor),
                // textAlign: TextAlign.center,

                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (T? newValue) {
        // setState(() {
        //   _selectedValue = newValue;
        // });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      onTap: null,
    );
  }
}
