import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function(BuildContext) onPressed;
  final String text;
  final Color backgroundColor = Color.fromARGB(255, 18, 180, 82);
  final Color foregroundColor = Colors.white;
  final double fontSize = 20.0;
  final double paddingVertical = 15.0;
  final double paddingHorizontal = 30.0;

  CustomButton({super.key, required this.onPressed, required this.text});

  @override
  State<StatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    child: OutlinedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical: widget.paddingVertical,
            horizontal: widget.paddingHorizontal,
          ),
        ),
      ),
      onPressed: () => widget.onPressed(context),
      child: Text(
        widget.text,
        style: TextStyle(fontSize: widget.fontSize, color: widget.foregroundColor),
      ),
    ),
  );
}
