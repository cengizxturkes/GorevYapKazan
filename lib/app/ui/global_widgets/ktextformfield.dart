// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/init/theme/color_manager.dart';

class KTextFormField {
  static final KTextFormField _instance = KTextFormField._init();
  static KTextFormField get instance => _instance;
  KTextFormField._init();

  Widget widget({
    required BuildContext context,
    bool? autoFocus,
    TextInputAction? textInputAction,
    List<TextInputFormatter>? mask,
    String? Function(String?)? validation,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onFieldSubmitted,
    TextEditingController? controller,
    TextInputType? keyboardType,
    int? minLines,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? border,
    InputBorder? disabledBorder,
    InputDecoration? decoration,
    TextStyle? style,
    TextStyle? labelStyle,
    BoxConstraints? boxConstraints,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    TextStyle? helperStyle,
    String? hintText,
    String? labelText,
    String? helperText,
    Widget? leadingIcon,
    Widget? suffixIcon,
    bool? obscureText,
    int? maxLength,
    int? maxLines,
    bool? enabled,
    bool? readOnly,
    bool allBorder = false,
    Color? cursorColor,
    AutovalidateMode? validateMode,
    double? fontSize,
    Color? borderColor,
    Color? fillColor,
    double? topPadding,
    FloatingLabelBehavior? floatingLabelBehavior,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: TextFormField(
        autofocus: autoFocus == null ? false : true,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        cursorColor: cursorColor ?? ColorManager.instance.darkGray,
        textInputAction: textInputAction,
        style: style != null
            ? style
            : TextStyle(
                color: ColorManager.instance.fourth,
                fontSize: fontSize ?? 14,
              ),
        scrollPadding: EdgeInsets.only(bottom: 100),
        inputFormatters: mask != null ? mask : [],
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText ?? false,
        controller: controller,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        autovalidateMode: validateMode != null ? validateMode : AutovalidateMode.disabled,
        keyboardType: keyboardType ?? TextInputType.text,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        minLines: minLines ?? 1,
        decoration: decoration ??
            InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(
                12,
                topPadding ?? 4,
                4,
                6,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: leadingIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.fourth,
                ),
              ),
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.fourth,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.fourth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 1,
                  color: ColorManager.instance.fourth,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              hintStyle: TextStyle(
                fontSize: 21,
                color: ColorManager.instance.darkGray,
              ),
              labelStyle: GoogleFonts.archivo(
                fontSize: 18,
                color: ColorManager.instance.black,
              ),
            ),
        validator: validation,
      ),
    );
  }
}
