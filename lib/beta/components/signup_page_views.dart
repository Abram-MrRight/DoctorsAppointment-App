
import 'package:doctors_appt/beta/components/widgets.dart';
import 'package:flutter/material.dart';

class SignUpPageView extends StatelessWidget {
  final String description;
  final TextEditingController? textController;
  final VoidCallback? onEditingComplete;
  final List<String>? dropdownData;
  final bool isLastPage;
  final VoidCallback? onSkipPressed;
  final VoidCallback? onNextPressed;
  final VoidCallback? onFinishPressed;
  final VoidCallback? onUploadPressed;
  final String labelText;
  final Widget? customDatePicker;
  bool? isConnecting;

  SignUpPageView({
    required this.description,
    this.textController,
    this.onEditingComplete,
    this.dropdownData,
    required this.isLastPage,
    this.onSkipPressed,
    this.onNextPressed,
    this.onFinishPressed,
    required this.labelText,
    this.customDatePicker,
    this.isConnecting,
    this.onUploadPressed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          description,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        if (textController != null && dropdownData == null)
          _buildTextField()
        else if (dropdownData != null)
          _buildDropdownMenu()
        else if (customDatePicker != null)
          customDatePicker!,
        SizedBox(height: 30),
        // Buttons
        _buildButtons(this.isConnecting),
      ],
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: textController,
      maxLines: labelText == 'Services' ? 3 : 1,
      textInputAction: isLastPage ? TextInputAction.done : TextInputAction.next,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget _buildDropdownMenu() {
    return SizedBox(
      width: 300,
      child: DropdownButtonFormField<String>(
        items: dropdownData?.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item.length > 25 ? '${item.substring(0, 26)}...' :
                item,
              overflow: TextOverflow.ellipsis
            ),
          );
        }).toList(),
        onChanged: (value) {
          // Handle dropdown selection
          textController?.text = value!;
        },
        decoration: InputDecoration(
          labelText: 'Select value',
          // Add more styling options as needed
        ),
      ),
    );
  }

  Widget _buildButtons(bool? isConnecting) {
    if (isLastPage) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onUploadPressed,
            child: const Text('Upload'),
          ),
          ElevatedButton(
            onPressed: onFinishPressed,
            child: isConnecting != null ? isConnecting! ? progressIndicator() : const Text('Finish') : const Text('Finish'),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onSkipPressed,
            child: Text('Skip'),
          ),
          ElevatedButton(
            onPressed: onNextPressed,
            child: Text('Next'),
          ),
        ],
      );
    }
  }
}
