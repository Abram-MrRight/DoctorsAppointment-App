import 'package:doctors_appt/consts/consts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textController;
  final String hint;
  final Color textColor;
  final Color borderColor;
  // final GlobalKey<FormState>? formKey;
  final TextEditingController? refTextController;
  const CustomTextField({super.key, this.textController, required this.hint,  this.textColor = Colors.black,  this.borderColor = Colors.black, this.refTextController});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscurePassword = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      focusNode: _focusNode,
      cursorColor: AppColors.blueColor,
      keyboardType: widget.hint == "Phone Number" ? TextInputType.phone :
      widget.hint == "Rating" ? const TextInputType.numberWithOptions(
        signed: false,
        decimal: false
      ) : null,
      obscureText: widget.hint == AppStrings.password || widget.hint == "Confirm Password" ? _obscurePassword : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.hint == AppStrings.email) {
          if (value!.isEmpty) {
            return "Email field cannot be empty";
          } else if (!RegExp(r'[a-zA-Z]\w+@[a-zA-Z]+\.[a-zA-Z]{2,7}').hasMatch(value)) {
            return "Invalid email format";
          }
        }
        if (widget.hint == AppStrings.password || widget.hint == "Confirm Password") {
          if (value!.isEmpty) {
            return "Password field cannot be empty";
          }
          else if (value.length < 6) {
            return "Passwords must be at least 6 characters";
          }
        }
        if (widget.hint == "Confirm Password") {
          if (value != widget.refTextController!.text) {
            return "Passwords do not match";
          }
        }
        if (widget.hint == "Phone Number") {
          if (value!.isEmpty) {
            return "Phone field is mandatory";
          }
        }
        return null;
      },
      onEditingComplete: () {
        // switch to next form field
        _focusNode.nextFocus();
      },
      decoration: InputDecoration(
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
        suffixIcon: widget.hint == AppStrings.password || widget.hint == "Confirm Password" ? IconButton(
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
