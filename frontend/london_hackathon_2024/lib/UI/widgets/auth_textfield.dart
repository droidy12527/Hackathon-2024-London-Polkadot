import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Function? onSubm;
  final bool? autoFocus;
  final IconData? prefixIcon;
  final Function(String value)? validator;

  AuthTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.autoFocus,
      this.prefixIcon,
      this.onSubm,
      this.validator});

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _textVisibility = true;

  void initstate() {
    _textVisibility = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus ?? false,
      onFieldSubmitted: (value) => widget.onSubm ?? {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Cannot leave the fields empty";
        }
        if (widget.validator == null) {
          return null;
        }
        String res = widget.validator!(value.trim());
        if (res.isEmpty) {
          return null;
        }
        return res;
      },
      obscureText: widget.obscureText ? _textVisibility : widget.obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red, fontSize: 0.01),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(
            widget.prefixIcon,
            size: 18,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          labelText: widget.hintText,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _textVisibility ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _textVisibility = !_textVisibility;
                    });
                  },
                )
              : null),
    );
  }
}
