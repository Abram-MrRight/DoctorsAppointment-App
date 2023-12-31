import 'package:doctors_appt/consts/colors.dart';
import 'package:doctors_appt/consts/consts.dart';
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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      cursorColor: AppColors.blueColor,
      obscureText: widget.hint == AppStrings.password ? _obscurePassword : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.hint == AppStrings.email) {
          if (value!.isEmpty) {
            return "Email field cannot be empty";
          } else if (!RegExp(r'[a-zA-Z]\w+@[a-zA-Z]+\.[a-zA-Z]{2,7}').hasMatch(value)) {
            return "Invalid email format";
          }
        }
        else if (widget.hint == AppStrings.password) {
          if (value!.isEmpty) {
            return "Password field cannot be empty";
          }
          else if (value.length < 6) {
            return "Passwords must be at least 6 characters";
          }
        }
        return null;
      },
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
        suffixIcon: widget.hint == AppStrings.password ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ) : null,
      ),
    );
  }
}
