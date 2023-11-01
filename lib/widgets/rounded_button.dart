import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class RoundedButton extends StatefulWidget {
  double? width;
  double? height;
  Color? bgColor;
  double? borderRadius;
  Function onClick;
  String? label;
  Widget? icon;
  Color? labelColor;
  List<Color>? gradient;
  TextStyle? labelStyle;

  double? elevation;
  // ignore: use_super_parameters
  RoundedButton(
      {Key? key,
      this.width,
      this.height,
      this.bgColor,
      this.borderRadius,
      required this.label,
      this.icon,
      required this.onClick,
      this.labelColor,
      this.gradient,
      this.elevation,
      this.labelStyle})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
        onTap: () {
          widget.onClick();
        },
        child: AnimatedContainer(
          width: widget.width,
          height: widget.height,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInSine,
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Material(
              elevation: widget.elevation ?? 0,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              child: Container(
                width: widget.width ?? 140,
                height: widget.height ?? 40,
                decoration: BoxDecoration(
                  color: widget.bgColor ?? Colors.white,
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 50),
                  boxShadow: null,
                  gradient: widget.gradient != null
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: widget.gradient!)
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.icon != null) widget.icon!,
                    if (widget.label != null)
                      const SizedBox(
                        width: 5,
                      ),
                    if (widget.label != null)
                      Text(
                        widget.label!,
                        style: widget.labelStyle ??
                            heading2Style(widget.labelColor ?? Colors.black),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
