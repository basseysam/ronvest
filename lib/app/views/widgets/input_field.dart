
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/fonts.dart';
import '../../styles/app_colors.dart';
import '../../styles/fonts.dart';
import 'note_text.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.placeholder,
    required this.label,
    this.enterPressed,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.additionalNote,
    this.onChanged,
    this.formatter,
    this.maxLines = 1,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.isReadOnly = false,
    this.smallVersion = true,
    this.suffix,
    this.onTap,
    this.maxLength,
    this.prefix,
    this.validationColor = const Color(0xff00000000),
    this.height = 60,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool password;
  final bool isReadOnly;
  final String placeholder;
  final String? validationMessage;
  final Function? enterPressed;
  final bool smallVersion;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? additionalNote;
  final Function? onTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? formatter;
  final int maxLines;
  final int? maxLength;
  final Widget? suffix;
  final Widget? prefix;
  final Color validationColor;
  final String label;
  final double height;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isPassword;
  double fieldHeight = 64;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
       // TextBody(widget.label),
       // const Gap(12),
        Container(
          height: widget.height,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xfff7f7f7),
            border: Border.all(color: widget.validationColor, width: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              widget.prefix ?? const SizedBox(),
              Expanded(
                child: TextField(
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  controller: widget.controller,
                  keyboardType: widget.textInputType,
                  focusNode: widget.fieldFocusNode,
                  cursorColor: AppColors.primaryColor,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  inputFormatters: widget.formatter ?? [],
                  onEditingComplete: () {
                    if (widget.enterPressed != null) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      widget.enterPressed!();
                    }
                  },
                  obscureText: isPassword,
                  readOnly: widget.isReadOnly,
                  style: const TextStyle(color: AppColors.grey),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 5),
                    hintText: widget.placeholder,
                    border: InputBorder.none,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontFamily: AppFonts.nunitoSansRegular,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff667085),
                    ),
                  ),
                ),
              ),
              widget.suffix ??
                  GestureDetector(
                    onTap: () => setState(() {
                      isPassword = !isPassword;
                    }),
                    child: widget.password
                        ? Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      child: Icon(
                        isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(0xffD0D5DD),
                        size: 25,
                      ),
                    )
                        : Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                    ),
                  ),
            ],
          ),
        ),
        if (widget.validationMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: NoteText(
              widget.validationMessage!,
              color: Colors.red,
            ),
          )
        else
          const SizedBox(),
        if (widget.additionalNote != null) const Gap(1) else const SizedBox(),
        if (widget.additionalNote != null)
          NoteText(widget.additionalNote!)
        else
          const SizedBox(),
      ],
    );
  }
}
