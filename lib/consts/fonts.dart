import 'package:doctors_appt/consts/consts.dart';

class AppFonts {
  static String nunitoLight = "Nunito-Light", nunitoBold = "Nunito_Bold";
}

class AppSizes{
  static const size12 = 12, size14 =14, size16 =16, size18 =18, size20 =20, size22 =22, size34 =34;
}

class AppStyles{
  static  normal({String? title, Color? color = Colors.black, double? size =14, TextAlign? alignment}){
   return title!.text.size(size).color(color).make();
  }
  static  bold({String? title, Color? color = Colors.black, double? size =14, TextAlign alignment = TextAlign.left, required TextStyle textStyle}){
  return   title!.text.size(size).color(color).fontFamily(AppFonts.nunitoBold).align(alignment).make();
  }
}