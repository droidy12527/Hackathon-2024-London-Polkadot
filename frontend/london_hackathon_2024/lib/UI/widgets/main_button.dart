import 'dart:ffi';

import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double padding;
  final IconData? iconData;
  final bool? rtl;
  final Color? iconColor;
  const StartButton(
      {super.key,
      this.rtl,
      this.iconColor,
      required this.onTap,
      this.iconData,
      required this.text,
      this.color,
      required this.padding,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: (rtl ?? false) == true ? TextDirection.rtl : TextDirection.ltr,
        child: iconData != null
            ? ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color ?? Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                  elevation: 1,
                ),
                onPressed: onTap,
                icon: Icon(
                  iconData,
                  color: iconColor,
                ),
                label: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color ?? Theme.of(context).primaryColor,
                  shape: const StadiumBorder(),
                  elevation: 1,
                ),
                onPressed: onTap,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ));
  }
}
