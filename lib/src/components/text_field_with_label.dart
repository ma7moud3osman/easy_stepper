import 'package:easy_stepper/src/colors.dart';
import 'package:easy_stepper/src/constants/dimensions.dart';
import 'package:flutter/material.dart';

class UnderLineTextFieldWithLabel extends StatelessWidget {
  const UnderLineTextFieldWithLabel({
    Key? key,
    this.labelText,
    this.hintText,
    this.validator,
    this.onSaved,
    this.onSubmit,
    this.onTap,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.inputBorder,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.inputAction = TextInputAction.next,
    this.autofocus = false,
    this.capitalization = TextCapitalization.none,
    this.labelColor,
    this.filled,
    this.fillColor,
    this.autoValidateMode,
    this.maxLines = 1,
    this.initialValue,
    this.maxLength,
    this.counterText,
    this.requiredField = false,
    this.autofillHint,
    this.textDirection,
  }) : super(key: key);

  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onSubmit;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final InputBorder? inputBorder;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final bool autofocus;
  final TextCapitalization capitalization;
  final Color? labelColor;
  final bool? filled;
  final Color? fillColor;
  final AutovalidateMode? autoValidateMode;
  final int? maxLines;
  final String? initialValue;
  final int? maxLength;
  final String? counterText;
  final bool requiredField;
  final String? autofillHint;
  final bool enabled;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: prefixIcon != null
                ? const EdgeInsetsDirectional.only(start: 10)
                : EdgeInsets.zero,
            child: RichText(
              text: TextSpan(
                text: labelText,
                style: Theme.of(context).textTheme.bodyText2,
                children: requiredField
                    ? [
                        TextSpan(
                          text: ' *',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.red),
                        )
                      ]
                    : null,
              ),
            ),
          ),
          SizedBox(height: vVerySmallPadding),
        ],
        TextFormField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          readOnly: readOnly,
          enabled: enabled,
          validator: validator,
          onSaved: onSaved,
          onTap: onTap,
          onFieldSubmitted: onSubmit,
          textInputAction: inputAction,
          obscureText: obscureText,
          obscuringCharacter: '*',
          keyboardType: keyboardType,
          autovalidateMode: autoValidateMode,
          autofocus: autofocus,
          textCapitalization: capitalization,
          maxLines: maxLines,
          maxLength: maxLength,
          initialValue: initialValue,
          textDirection: textDirection,
          autofillHints: autofillHint != null ? [autofillHint!] : null,
          decoration: customInputDecoration(
            filled: filled,
            fillColor: fillColor,
            context: context,
            hintText: hintText,
            inputBorder: inputBorder,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            counterText: counterText,
          ),
        ),
      ],
    );
  }

  static InputDecoration customInputDecoration({
    required BuildContext context,
    String? hintText,
    InputBorder? inputBorder,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? filled,
    Color? fillColor,
    String? counterText,
  }) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: Theme.of(context)
          .textTheme
          .caption!
          .copyWith(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize),
      filled: filled,
      fillColor: fillColor,
      counterText: counterText,
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: inputBorder ??
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
              width: 1.5,
            ),
          ),
      border: inputBorder ??
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).cardColor.withOpacity(0.05),
            ),
          ),
      enabledBorder: inputBorder ??
          UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).cardColor.withOpacity(0.05),
            ),
          ),
    );
  }
}

class FilledTextFieldWithLabel extends StatelessWidget {
  const FilledTextFieldWithLabel({
    Key? key,
    this.validator,
    this.onSaved,
    this.onTap,
    this.onSubmit,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.name,
    this.controller,
    this.inputBorder,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.inputAction = TextInputAction.next,
    this.autofocus = false,
    this.capitalization = TextCapitalization.none,
    this.labelColor,
    this.filled,
    this.fillColor,
    this.autoValidateMode,
    this.maxLines = 1,
    this.initialValue,
    this.maxLength,
    this.counterText,
    this.requiredField = false,
    this.onChange,
    this.autofillHints,
    this.shadow = false,
    this.textAlignVertical,
    this.textAlign,
    this.height,
    this.forceHeight = false,
    this.style,
    this.hintSize,
    this.onEditingComplete,
    this.textDirection,
    this.radius,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function(String)? onSubmit;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final InputBorder? inputBorder;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputAction? inputAction;
  final bool autofocus;
  final TextCapitalization capitalization;
  final Color? labelColor;
  final bool? filled;
  final Color? fillColor;
  final AutovalidateMode? autoValidateMode;
  final int maxLines;
  final String? initialValue;
  final int? maxLength;
  final String? counterText;
  final bool requiredField;
  final void Function(String value)? onChange;
  final String? autofillHints;
  final bool shadow;
  final TextAlignVertical? textAlignVertical;
  final TextAlign? textAlign;
  final double? height;
  final bool forceHeight;
  final TextStyle? style;
  final double? hintSize;
  final TextDirection? textDirection;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Padding(
            padding: prefixIcon != null
                ? const EdgeInsetsDirectional.only(start: 10)
                : EdgeInsets.zero,
            child: RichText(
              text: TextSpan(
                text: labelText,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.normal, color: labelColor),
                children: requiredField
                    ? [
                        TextSpan(
                          text: ' *',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.red),
                        )
                      ]
                    : null,
              ),
            ),
          ),
          SizedBox(height: vSmallPadding),
        ],
        Container(
          height: validator != null && !forceHeight
              ? null
              : (height ?? 50) * maxLines,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? verySmallRadius),
            boxShadow: shadow
                ? [
                    BoxShadow(
                      color:
                          isDark ? Colors.grey.shade900 : Colors.grey.shade300,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: const Offset(1, 2),
                    ),
                  ]
                : null,
          ),
          child: TextFormField(
            key: key,
            controller: controller,
            focusNode: focusNode,
            readOnly: readOnly,
            validator: validator,
            onSaved: onSaved,
            onTap: onTap,
            onChanged: onChange,
            onFieldSubmitted: onSubmit,
            onEditingComplete: onEditingComplete,
            textInputAction: inputAction,
            obscureText: obscureText,
            obscuringCharacter: '●',
            keyboardType: keyboardType,
            autovalidateMode: autoValidateMode,
            autofocus: autofocus,
            textCapitalization: capitalization,
            maxLines: maxLines,
            maxLength: maxLength,
            initialValue: initialValue,
            textAlign: textAlign ?? TextAlign.start,
            textDirection: textDirection,
            textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
            autofillHints: autofillHints != null ? [autofillHints!] : null,
            style: style ??
                Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontFamily: keyboardType == TextInputType.phone ||
                              keyboardType == TextInputType.number ||
                              keyboardType == TextInputType.emailAddress
                          ? 'Roboto'
                          : null,
                    ),
            decoration: customInputDecoration(
              filled: filled,
              fillColor: fillColor,
              context: context,
              hintText: hintText ?? (obscureText ? '● ● ● ● ● ● ● ●' : null),
              hintSize: hintSize,
              inputBorder: inputBorder,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              counterText: counterText,
              isDark: isDark,
              maxLines: maxLines,
              textDirection: textDirection,
            ),
          ),
        ),
      ],
    );
  }

  static InputDecoration customInputDecoration({
    required BuildContext context,
    String? hintText,
    InputBorder? inputBorder,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? filled,
    Color? fillColor,
    String? counterText,
    required bool isDark,
    double? hintSize,
    required int maxLines,
    TextDirection? textDirection,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(
        horizontal: hMediumPadding * 0.8,
        vertical: vVerySmallMargin,
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.caption!.copyWith(
            fontSize:
                hintSize ?? Theme.of(context).textTheme.bodyText1!.fontSize,
            height: maxLines > 1 ? 1 : 0.7,
          ),
      filled: true,
      fillColor: fillColor ?? (authBackgroundColor),
      counterText: counterText,
      focusedBorder:
          inputBorder ?? const OutlineInputBorder(borderSide: BorderSide.none),
      border:
          inputBorder ?? const OutlineInputBorder(borderSide: BorderSide.none),
      isDense: true,
      hintTextDirection: textDirection,
    );
  }
}

OutlineInputBorder outlinedBorderAll({required bool isDark}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: isDark ? darkTextColor : lightTextColor,
      width: 0.5,
    ),
  );
}
