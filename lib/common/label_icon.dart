import 'package:flutter/material.dart';


class LabelIcon extends StatelessWidget {
  final label;
  final icon;
  final iconColor;
  final onPressed;

  LabelIcon({
    this.label,
    this.icon,
    this.iconColor = Colors.grey,
    this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed,
      child: Row(
        children: <Widget>[
          Icon(
            icon, color: iconColor,
            size: 15.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            label, style: TextStyle(fontWeight: FontWeight.w700),
          )
        ]
      ),
    );
  }
}