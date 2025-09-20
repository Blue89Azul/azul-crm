import 'package:azul_crm/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTag extends StatelessWidget {
  final String _text;
  final Color _backgroundColor;
  final Color _textColor;

  const AppTag(
    text, {
    super.key,
    required backgroundColor,
    textColor = Colors.white,
  }) : _text = text,
       _backgroundColor = backgroundColor,
       _textColor = textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
      ),
      child: Text(
        _text,
        style: AppTextStyle.bodyMedium.copyWith(color: _textColor),
      ),
    );
  }
}
