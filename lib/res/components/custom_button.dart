import '../../consts/consts.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.buttonText, required this.onTap});

  final String buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {

    return  SizedBox(
      width: context.screenWidth,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xFF1055E5),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: buttonText.text.make()
      ),
    );
  }
}
