import 'package:doctors_appt/consts/consts.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget progressIndicator () {
  return CircularProgressIndicator(
    color: Colors.white,
    backgroundColor: Colors.blue,
  );
}

Widget authButton (BuildContext context, String buttonText, bool condition, Function()? onTap) {
  return SizedBox(
    width: context.screenWidth,
    height: 44,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: const Color(0xFF1055E5),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: condition ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [progressIndicator(), 16.widthBox, buttonText.text.make()],
        ) : buttonText.text.make()
    ),
  );
}

void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColors.blueTheme,
    textColor: Colors.white,
    gravity: ToastGravity.CENTER
  );
}