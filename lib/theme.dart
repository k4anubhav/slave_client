import 'package:flutter/material.dart';

Color parseColor(String color) {
  String hex = color.replaceAll("#", "");
  if (hex.isEmpty) hex = "ffffff";
  if (hex.length == 3) {
    hex =
        '${hex.substring(0, 1)}${hex.substring(0, 1)}${hex.substring(1, 2)}${hex.substring(1, 2)}${hex.substring(2, 3)}${hex.substring(2, 3)}';
  }
  Color col = Color(int.parse(hex, radix: 16)).withOpacity(1.0);
  return col;
}

Color appDarkColor() {
  return parseColor('#272638');
}

Color lightAppDarkColor() {
  return parseColor('#504e62');
}

Color mediumAppDarkColor() {
  return parseColor('#272638');
}

Color lightAppDarkColorOpacity() {
  return lightAppDarkColor().withOpacity(0.4);
}

Color greenColor() {
  return parseColor('#00e5a9');
}

Color appLogoDark() {
  return parseColor('#000013');
}

Icon unselectedIcon(IconData icon) {
  return Icon(
    icon,
    color: Colors.white,
  );
}

Icon selectedIcon(IconData icon) {
  return Icon(
    icon,
    color: Colors.white,
  );
}

TextStyle? captionText(BuildContext context,
    {FontWeight? fontWeight, Color? color, double? fontSize}) {
  return Theme.of(context).textTheme.bodyText2!.copyWith(
      color: color ?? captionColor(context),
      fontWeight: fontWeight,
      fontSize: fontSize);
}

TextStyle? smallCaptionText(BuildContext context,
    {FontWeight? fontWeight, Color? color, double? fontSize}) {
  return Theme.of(context).textTheme.bodyText2!.copyWith(
      color: color ?? captionColor(context),
      fontWeight: fontWeight,
      fontSize: 12);
}

Color? captionColor(BuildContext context) {
  return Colors.white38;
}

Padding paddingV2({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: child,
  );
}

//paddingV4
Padding paddingV4({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: child,
  );
}

//paddingV6
Padding paddingV6({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: child,
  );
}

//paddingV8
Padding paddingV8({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: child,
  );
}

//paddingH4
Padding paddingH4({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: child,
  );
}

//paddingH16
Padding paddingH8({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: child,
  );
}

//paddingH12
Padding paddingH12({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: child,
  );
}

//padding16
Padding paddingH16({Widget? child, double? vertical, double? horizontal}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: horizontal ?? 16,
    ),
    child: child,
  );
}

//margin16
Container marginH16({Widget? child}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: child,
  );
}

Padding paddingL4({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.only(left: 4),
    child: child,
  );
}

Padding paddingL8({Widget? child, double? left}) {
  return Padding(
    padding: EdgeInsets.only(left: left ?? 8),
    child: child,
  );
}

Padding paddingL12({Widget? child}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12),
    child: child,
  );
}

//margingv8
Container marginV8({Widget? child, double? horizontal}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: horizontal ?? 0),
    child: child,
  );
}

//margingv4
Container marginV4({Widget? child, double? horizontal, double? vertical}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: horizontal ?? 0),
    child: child,
  );
}

Container marginB4({Widget? child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: child,
  );
}

//margingv6
Container marginV6({Widget? child}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    child: child,
  );
}

Container marginV12({Widget? child, double? horizontal}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12, horizontal: horizontal ?? 0),
    child: child,
  );
}

Container marginV16({Widget? child}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    child: child,
  );
}
