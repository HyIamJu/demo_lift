import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_styles.dart';
import 'spacer.dart';

class CustomTextFormField extends StatelessWidget {
  final AutovalidateMode? validateMode;
  final String? hintText;
  final String? title;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final void Function(String? value)? onSaved;
  final int maxLines;
  final int? maxLength;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;
  final TextStyle titleStyle;
  final Color? backgroundColor;

  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.title,
    this.controller,
    this.maxLength,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.titleStyle = AppStyles.body2Regular,
    this.backgroundColor,
    this.prefixIcon,
    this.validateMode,
    this.inputFormatters,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title ?? "",
            style: titleStyle,
          ),
          SpacerHeight(spacer),
        ],
        SizedBox(
          child: TextFormField(
            inputFormatters: inputFormatters,
            autovalidateMode: validateMode,
            maxLength: maxLength,
            textCapitalization: textCapitalization,
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onSaved: onSaved,
            keyboardType: keyboardType,
            onChanged: onChanged,
            readOnly: readOnly,
            maxLines: maxLines,
            onTap: onTap,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              fillColor: backgroundColor,
              filled: backgroundColor != null,
              hintText: hintText,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              border: _borderStyle,
              suffixIcon: suffixIcon,
              focusedBorder: _borderStyle,
              enabledBorder: _borderStyle,
              errorBorder: _borderStyle,
              focusedErrorBorder: _borderStyle,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder get _borderStyle => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        borderSide: BorderSide(
          color: AppColors.grey.shade600,
          width: AppSizes.s1,
        ),
      );
}

class CustomTextFormFieldComment extends StatelessWidget {
  final AutovalidateMode? validateMode;
  final String? hintText;
  final String? title;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final int? maxLength;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;
  final TextStyle titleStyle;
  final Color? backgroundColor;

  const CustomTextFormFieldComment({
    super.key,
    this.hintText,
    this.title,
    this.controller,
    this.maxLength,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.titleStyle = AppStyles.body2Regular,
    this.backgroundColor,
    this.prefixIcon,
    this.validateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) // Check if title is not null
          Text(
            title!,
            style: titleStyle,
          ),
        SpacerHeight(spacer),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                autovalidateMode: validateMode,
                maxLength: maxLength,
                textCapitalization: textCapitalization,
                cursorColor: AppColors.black,
                controller: controller,
                obscureText: obscureText,
                validator: validator,
                keyboardType: keyboardType,
                onChanged: onChanged,
                readOnly: readOnly,
                maxLines: maxLines,
                onTap: onTap,
                decoration: InputDecoration(
                  fillColor: backgroundColor,
                  filled: backgroundColor != null,
                  hintText: hintText,
                  errorText: errorText,
                  contentPadding: const EdgeInsets.all(AppPaddings.p12),
                  border: _borderStyle,
                  focusedBorder: _borderStyle,
                  enabledBorder: _borderStyle,
                  errorBorder: _borderStyle,
                  focusedErrorBorder: _borderStyle,
                ),
              ),
            ),
            if (suffixIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: AppPaddings.p8),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.red,
                    ),
                    padding: const EdgeInsets.all(AppPaddings.p10),
                    child: suffixIcon!,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  OutlineInputBorder get _borderStyle => OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
        borderSide: BorderSide(
          color: AppColors.grey.shade600,
          width: AppSizes.s1,
        ),
      );
}

class OldCustomTextFormField3 extends StatelessWidget {
  final String? hintText;
  final String title;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;
  const OldCustomTextFormField3({
    super.key,
    this.hintText,
    required this.title,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.body2Regular,
        ),
        SpacerHeight(spacer),
        SizedBox(
          child: TextFormField(
            textCapitalization: textCapitalization,
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: TextInputType.text,
            onChanged: onChanged,
            readOnly: readOnly,
            maxLines: maxLines,
            onTap: onTap,
            // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            textInputAction: TextInputAction.join,

            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              suffixIcon: suffixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OldCustomTextFormField4 extends StatelessWidget {
  final String? hintText;

  final Widget? prefix;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;
  const OldCustomTextFormField4({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.prefix,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: TextFormField(
            textCapitalization: textCapitalization,
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: TextInputType.text,
            onChanged: onChanged,
            readOnly: readOnly,
            maxLines: maxLines,
            onTap: onTap,
            // inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],

            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              prefixIcon: prefix,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OldCustomTextFormField2 extends StatelessWidget {
  final String? hintText;
  final String title;
  final Widget? suffixIcon;

  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;
  final bool mainAxisColumnSizeIsMax;
  final String? prefixText;
  final String? initialText;
  final List<TextInputFormatter>? inputFormatters;

  const OldCustomTextFormField2({
    super.key,
    this.hintText,
    required this.title,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.mainAxisColumnSizeIsMax = true,
    this.prefixText,
    this.inputFormatters,
    this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          mainAxisColumnSizeIsMax ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: AppStyles.body2Regular,
          ),
        SpacerHeight(spacer),
        SizedBox(
          child: TextFormField(
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            cursorColor: AppColors.black,
            controller: controller,
            initialValue: initialText,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            readOnly: readOnly,
            maxLines: maxLines,
            onTap: onTap,
            decoration: InputDecoration(
              prefixText: prefixText,
              isDense: true,
              hintText: hintText,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OldCustomTextField extends StatelessWidget {
  final String? hintText;

  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;
  final Widget? title;
  const OldCustomTextField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) title!,
        SpacerHeight(spacer),
        SizedBox(
          child: TextFormField(
            textCapitalization: textCapitalization,
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            readOnly: readOnly,
            maxLines: maxLines,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              suffixIcon: suffixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextArea extends StatelessWidget {
  final AutovalidateMode? validateMode;
  final String? hintText;
  final String title;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final void Function(String? value)? onSaved;
  final int maxLines;
  final int minLines;
  final double height;
  final bool readOnly;
  final Function()? onTap;
  final double spacer;
  final TextCapitalization textCapitalization;

  const CustomTextArea({
    super.key,
    this.hintText,
    required this.title,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.readOnly = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.height = AppSizes.s41,
    this.onTap,
    this.spacer = AppSizes.s8,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.minLines = 1,
    this.maxLines = 8,
    this.onSaved,
    this.validateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: AppStyles.body2Regular,
          ),
        SpacerHeight(spacer),
        SizedBox(
          child: TextFormField(
            autovalidateMode: validateMode,
            onSaved: onSaved,
            textCapitalization: textCapitalization,
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            readOnly: readOnly,
            minLines: minLines,
            maxLines: maxLines,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              suffixIcon: suffixIcon,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextFormFieldPassword extends StatefulWidget {
  final AutovalidateMode? validateMode;
  final String? hintText;
  final String title;
  final TextEditingController? controller;
  final bool intialHideStatus;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final void Function(String? value)? onSaved;
  final String? errorText;
  final double height;
  const CustomTextFormFieldPassword({
    super.key,
    this.hintText,
    required this.title,
    this.controller,
    this.intialHideStatus = true,
    this.validator,
    this.errorText,
    this.onChanged,
    this.height = AppSizes.s41,
    this.validateMode,
    this.onSaved,
  });

  @override
  State<CustomTextFormFieldPassword> createState() =>
      _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState
    extends State<CustomTextFormFieldPassword> {
  late ValueNotifier<bool> isShowingTxt;
  @override
  void initState() {
    isShowingTxt = ValueNotifier(widget.intialHideStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppStyles.body2Regular,
        ),
        const SpacerHeight(AppSizes.s8),
        SizedBox(
          child: ValueListenableBuilder(
              valueListenable: isShowingTxt,
              builder: (context, value, _) {
                return TextFormField(
                  onSaved: widget.onSaved,
                  autovalidateMode: widget.validateMode,
                  cursorColor: AppColors.black,
                  controller: widget.controller,
                  obscureText: value,
                  obscuringCharacter: '●',
                  validator: widget.validator,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    errorText: widget.errorText,
                    contentPadding: const EdgeInsets.all(AppPaddings.p12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        isShowingTxt.value = !isShowingTxt.value;
                      },
                      icon: Icon(
                        value == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.black.shade200,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                      borderSide: BorderSide(
                        color: AppColors.grey.shade600,
                        width: AppSizes.s1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                      borderSide: BorderSide(
                        color: AppColors.grey.shade600,
                        width: AppSizes.s1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                      borderSide: BorderSide(
                        color: AppColors.grey.shade600,
                        width: AppSizes.s1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                      borderSide: BorderSide(
                        color: AppColors.grey.shade600,
                        width: AppSizes.s1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r12),
                      borderSide: BorderSide(
                        color: AppColors.grey.shade600,
                        width: AppSizes.s1,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class CustomDateFormField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final double height;
  final bool isReadOnly;
  final Function()? onTap;
  const CustomDateFormField({
    super.key,
    required this.title,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.body2Regular,
        ),
        const SpacerHeight(AppSizes.s8),
        SizedBox(
          child: TextFormField(
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            maxLines: maxLines,
            onTap: onTap,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: 'DD/MM/YYYY',
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              suffixIcon: Icon(
                Icons.calendar_month_outlined,
                color: AppColors.black.shade200,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDateFormField2 extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final double height;
  final bool isReadOnly;
  final Function()? onTap;
  const CustomDateFormField2({
    super.key,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.height = AppSizes.s41,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpacerHeight(AppSizes.s8),
        SizedBox(
          child: TextFormField(
            cursorColor: AppColors.black,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            maxLines: maxLines,
            onTap: onTap,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: 'DD/MM/YYYY',
              errorText: errorText,
              contentPadding: const EdgeInsets.all(AppPaddings.p12),
              suffixIcon: Icon(
                Icons.calendar_month_outlined,
                color: AppColors.black.shade200,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.r12),
                borderSide: BorderSide(
                  color: AppColors.grey.shade600,
                  width: AppSizes.s1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CodeOTPField extends StatefulWidget {
  final ValueNotifier<String> valueListener;

  const CodeOTPField({
    super.key,
    required this.valueListener,
  });

  @override
  State<CodeOTPField> createState() => _CodeOTPFieldState();
}

class _CodeOTPFieldState extends State<CodeOTPField> {
  String field1 = "";
  String field2 = "";
  String field3 = "";
  String field4 = "";

  String get otpCode => field1 + field2 + field3 + field4;

  TextEditingController box1 = TextEditingController();
  TextEditingController box2 = TextEditingController();
  TextEditingController box3 = TextEditingController();
  TextEditingController box4 = TextEditingController();

  @override
  void initState() {
    listenerOnRightCursor();
    super.initState();
  }

  void listenerOnRightCursor() {
    box1.addListener(() {
      box1.selection = TextSelection.collapsed(offset: box1.text.length);
    });
    box2.addListener(() {
      box2.selection = TextSelection.collapsed(offset: box2.text.length);
    });
    box3.addListener(() {
      box3.selection = TextSelection.collapsed(offset: box3.text.length);
    });
    box4.addListener(() {
      box4.selection = TextSelection.collapsed(offset: box4.text.length);
    });
  }

  @override
  void dispose() {
    box1.dispose();
    box2.dispose();
    box3.dispose();
    box4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        field(
          controller: box1,
          onChanged: (value) {
            field1 = value;
            widget.valueListener.value = otpCode;

            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).unfocus();
            }
          },
        ),
        const Gap(10),
        field(
          controller: box2,
          onChanged: (value) {
            field2 = value;
            widget.valueListener.value = otpCode;
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
        const Gap(10),
        field(
          controller: box3,
          onChanged: (value) {
            field3 = value;
            widget.valueListener.value = otpCode;
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
        const Gap(10),
        field(
            controller: box4,
            onChanged: (value) {
              field4 = value;
              widget.valueListener.value = otpCode;
              if (value.length == 1) {
                FocusScope.of(context).unfocus();
              } else if (value.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            }),
      ],
    );
  }

  Widget field(
      {void Function(String value)? onChanged,
      required TextEditingController controller}) {
    return SizedBox(
      width: 50,
      height: 70,
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.grey, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.red, width: 2.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        style: AppStyles.heading1Regular,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorOpacityAnimates: false,
        cursorWidth: 1.5,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          SingleDigitInputFormatter(),
        ],
      ),
    );
  }
}

class SingleDigitInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Hanya mengizinkan satu karakter angka
    if (newValue.text.length > 1) {
      return TextEditingValue(
        text: newValue.text.substring(newValue.text.length - 1),
        selection: TextSelection.fromPosition(
          const TextPosition(offset: 1),
        ),
      );
    }
    return newValue;
  }
}
