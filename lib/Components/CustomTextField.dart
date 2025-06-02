import 'package:flutter/material.dart';

class StyledTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
    final void Function()? onTap;
  final String? hintText;
  final String? labelText;
  final Widget? icon;
  final bool isMultiline;
  final bool? readOnly;
  final bool isFloating;
  final bool isFilled;
  final Color? fillColor;
  const StyledTextFormField(
      {Key? key,
      required this.controller,

      this.validator,
      this.onChanged,
      this.hintText,
      this.labelText,
      required this.isMultiline,
      required this.isFilled,
      this.fillColor,
      this.onTap,
            this.readOnly,
            required this.isFloating,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isMultiline? 
    TextFormField(
      controller: controller,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '* $labelText required';
            }
            return null;
          },
          onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly?? false,
      
      style: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 12,
        fontStyle: FontStyle.italic,
      ),
      decoration: InputDecoration(
        filled: isFilled,
   hoverColor: fillColor?? Colors.white,
        floatingLabelBehavior: isFloating? FloatingLabelBehavior.always : FloatingLabelBehavior.never,
        labelStyle: TextStyle(color: Colors.white),
        hintText: hintText ?? 'Hint',
        hintStyle: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontSize: 12,
        ),
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: labelText ?? 'Label',
        suffixIcon: icon ??
            Icon(
              Icons.timer,
              color: Colors.white,
            ),
      ),
    ):
       TextFormField(
      controller: controller,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return '* $labelText required';
            }
            return null;
          },
      onChanged: onChanged,
      style: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 12,
        fontStyle: FontStyle.italic,
      ),
       keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null, // Expands as the user types
      decoration:  InputDecoration(
         filled: isFilled,
          hoverColor: fillColor?? Colors.white,
        floatingLabelBehavior:  isFloating? FloatingLabelBehavior.always : FloatingLabelBehavior.never ,
        labelStyle: TextStyle(color: Colors.white),
        hintText: hintText ?? 'Hint',
        hintStyle: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontSize: 12,
        ),
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        labelText: labelText ?? 'Label',
        suffixIcon: icon ??
            Icon(
              Icons.timer,
              color: Colors.white,
            ),
      ),
    );
 
 
 
  }
}
