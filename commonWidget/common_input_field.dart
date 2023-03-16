import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonInputField extends StatefulWidget {

  final String? hintText;
  final String? labelText;
  final Function? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isAutoCompleteEnabled;
  final double? width;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final int? maxLines;
  final Color? backgroundColor;
  final TextInputType keyboardType;
  final TextEditingController? textEditingController;
  final Color? textColor;
  final bool isTextObscured;
  final bool isSuffixIcon;
  final Widget? suffixIcon;
  final Function? onSuffixClick;
  final bool isAutoFocus;
  final String? validator;
  final bool isFinalKeyboard;
  final FocusNode? focus;
  final FocusNode? nextFocus;
  final Widget? prefix;
  final bool? readOnly;
  final bool? enable;
  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validators;
  final Iterable<String>? autoFillHints;
  final int? maxLength;
  final Color? hintTextColor;
  final Color? labelTextColor;

  const CommonInputField(
      {Key? key,
        this.hintText,
        this.onTap,
        this.errorText,
        this.onChanged,
        this.onSubmitted,
        this.width,
        this.suffix,
        this.backgroundColor,
        this.keyboardType = TextInputType.text,
        this.textCapitalization = TextCapitalization.none,
        this.textEditingController,
        this.isAutoCompleteEnabled = true,
        this.textColor,
        this.isTextObscured = false,
        this.isSuffixIcon = false,
        this.suffixIcon,
        this.onSuffixClick,
        this.isAutoFocus = false,
        this.validator,
        this.isFinalKeyboard = false,
        this.focus,
        this.nextFocus,
        this.prefix,
        this.maxLines = 1,
        this.readOnly = false,
        this.enable = true,
        this.inputFormatters,
        this.labelText = '',
        this.validators,
        this.maxLength,
        this.autoFillHints,
        this.labelTextColor,
        this.hintTextColor,
      })
      : super(key: key);

  @override
  _CommonInputFieldState createState() =>
      _CommonInputFieldState(isTextObscured);
}

class _CommonInputFieldState extends State<CommonInputField> {
  bool _isTextObscured = false;
  bool isValidValue = true;
  Color kNormalColor = const Color(0xff223039);
  Color kErrorColor = const Color(0xffe11313);
  Color kHintColor = const Color(0xff6b6565);
  Color kSelectColor = const Color(0xffFF5F99);

  _CommonInputFieldState(bool isTextObscured) {
    _isTextObscured = isTextObscured;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        mouseCursor: MouseCursor.defer,
        autofillHints: widget.autoFillHints,
        maxLength: widget.maxLength,
        enabled: widget.enable,
        readOnly: widget.readOnly!,
        autofocus: widget.isAutoFocus,
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: widget.isFinalKeyboard
            ? TextInputAction.done
            : TextInputAction.next,
        cursorColor: kNormalColor,
        textCapitalization: widget.textCapitalization,
        obscureText: _isTextObscured,
        validator: widget.validators ?? (value) => value!.isEmpty ? widget.validator : null,
        focusNode: widget.focus,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onChanged: (text) {
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        onFieldSubmitted: (v) {
          if(widget.onSubmitted != null){
            widget.onSubmitted!(v);
          }
          if (widget.nextFocus != null) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          }
        },
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
            counterText: '',
            prefix: widget.prefix,
            isDense: true,
            contentPadding: const EdgeInsets.all(15),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: isValidValue ? kSelectColor : kErrorColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: kErrorColor, width: 2),
            ),
            labelStyle: TextStyle(
              color: widget.labelTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
            hintStyle: TextStyle(
              color: widget.hintTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            labelText: widget.labelText??'',
            hintText:widget.hintText ?? '',
            suffixIcon: widget.suffixIcon == null
                ? widget.isSuffixIcon
                ? IconButton(
                color: kHintColor,
                icon: _isTextObscured
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isTextObscured = !_isTextObscured;
                  });
                })
                : null
                : GestureDetector(
                onTap: () {
                  if (widget.onSuffixClick != null) {
                    widget.onSuffixClick!();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: widget.suffixIcon,
                ) /*Icon(
                    widget.suffixIcon,
                    color: kNormalColor,
                  ),*/
            ),
            errorStyle: TextStyle(
                color: kErrorColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            suffix: widget.suffix,
            errorText: widget.errorText,
            errorMaxLines: 2
        ),
        controller: widget.textEditingController,
        maxLines: widget.maxLines,
      ),
    );
  }
}
