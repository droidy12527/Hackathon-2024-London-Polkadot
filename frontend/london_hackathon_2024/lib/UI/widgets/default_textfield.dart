import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? autofocus;
  final Function? onSubm;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final Function(String text) onChange;
  const DefaultTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textAlign,
    this.onSubm,
    this.autofocus,
    this.focusNode,
    required this.onChange,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus ?? false,
      onFieldSubmitted: (value) => widget.onSubm ?? {},
      controller: widget.controller,
      onChanged: (value) => widget.onChange(value),
      textCapitalization: TextCapitalization.words,
      textAlign: widget.textAlign ?? TextAlign.start,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500] ?? Colors.grey)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[500] ?? Colors.grey)),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
