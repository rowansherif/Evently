import 'package:events_app/providers/app_theme_provider.dart';
import 'package:events_app/utils/app_colors.dart';
import 'package:events_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef MyValidator = String? Function(String?)?;

class CustomTextfield extends StatelessWidget {
  Color? borderColor;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  bool obscureText;
  int maxLines;
  MyValidator validator;
  TextEditingController? controller;

  CustomTextfield(
      {this.borderColor,
      this.prefixIcon,
      this.suffixIcon,
      required this.hintText,
      this.hintStyle,
      this.validator,
      this.controller,
      this.maxLines = 1,
      this.labelText,
      this.labelStyle,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obscureText,
      obscuringCharacter: '*',
      style: themeProvider.appTheme == ThemeMode.light
          ? AppStyles.medium16Black
          : AppStyles.medium16White,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ??
            (themeProvider.appTheme == ThemeMode.light
                ? AppStyles.medium16Grey
                : AppStyles.medium20White),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle ??
            (themeProvider.appTheme == ThemeMode.light
                ? AppStyles.medium16Grey
                : AppStyles.medium16White),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ??
                (themeProvider.appTheme == ThemeMode.light
                    ? AppColors.greyColor
                    : AppColors.primaryLight),
            width: 2,
          ),
        ),
        errorStyle: AppStyles.medium16Red,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: borderColor ??
                (themeProvider.appTheme == ThemeMode.light
                    ? AppColors.greyColor
                    : AppColors.primaryLight),
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.redColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
