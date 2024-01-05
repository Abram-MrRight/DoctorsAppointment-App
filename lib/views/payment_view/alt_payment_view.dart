import 'package:doctors_appt/consts/consts.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentOption = -1; // -1 represents no option selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options', style: TextStyle(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPaymentOption('Credit/Debit Card', 0),
              16.heightBox,
              _buildPaymentOption('PayPal', 1),
              16.heightBox,
              _buildPaymentOption('Mobile Money', 2),
              _buildExpandedContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentOption = _selectedPaymentOption == index ? -1 : index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blueTheme,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: AppColors.blueTheme)),
            Icon(
              _selectedPaymentOption == index
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: AppColors.blueTheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    if (_selectedPaymentOption == -1) {
      return Container(); // No option selected, no expanded content
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blueTheme,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_selectedPaymentOption == 0) ...[
            _buildTextField('Card Number'),
            _buildTextField('CVC'),
            _buildTextField('Date of Expiry'),
          ] else if (_selectedPaymentOption == 1) ...[
            _buildTextField('PayPal Email'),
          ] else if (_selectedPaymentOption == 2) ...[
            _buildTextField('Mobile Money Phone Number'),
          ],
          ElevatedButton(
            onPressed: () {
              // Add payment functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blueTheme,
              foregroundColor: AppColors.whiteColor
            ),
            child: const Text('Make Payment'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.blueTheme),
          border: InputBorder.none
        ),
      )
    );
  }
}
