import 'package:doctors_appt/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textController;
  final String hint;
  final Color textColor;
  final Color borderColor;
  const CustomTextField({super.key, this.textController, required this.hint,  this.textColor = Colors.black,  this.borderColor = Colors.black});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.blueColor,
      decoration:  InputDecoration(
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor
          )
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor)),
        border:  OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor,)),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: widget.textColor,
        ),
      ),
    );
  }
}
