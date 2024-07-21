import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final double padding;
  final bool inProgress;
  final bool? isEnabled;
  const MainButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.color,
      required this.inProgress,
      required this.padding,
      this.isEnabled,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: const StadiumBorder(),
        elevation: 0,
      ),
      onPressed: (isEnabled ?? true) ? onTap : null,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Center(
          child: inProgress
              ? Container(
                  width: 23,
                  height: 23,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}

class IntegratedAuthButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final String iconRoute;
  final bool inProgress;
  const IntegratedAuthButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.iconRoute,
    this.color,
    this.textColor,
    required this.inProgress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        shape: const StadiumBorder(),
        side: BorderSide(color: Colors.black, width: 1),
        elevation: 0,
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Image.asset(
            iconRoute,
            width: 25,
            height: 25,
          ),
          Expanded(
            child: Padding(
              padding: !inProgress
                  ? const EdgeInsets.only(
                      left: 9,
                      bottom: 15,
                      top: 15,
                    )
                  : const EdgeInsets.symmetric(vertical: 14.2),
              child: Center(
                child: inProgress
                    ? Container(
                        width: 21,
                        height: 21,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                          strokeWidth: 2.5,
                        ))
                    : Text(
                        text,
                        style: TextStyle(
                          color: textColor ?? Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
