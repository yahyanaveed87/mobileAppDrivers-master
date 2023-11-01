// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class RoundedButtonToggle extends StatefulWidget {
  double? width;
  double? height;
  Color? bgColor;
  double? borderRadius;
  Function onClick;
  String? label;
  bool active;
  Color? labelColor;
  List<Color>? gradient;
  TextStyle? labelStyle;

  double? elevation;
  RoundedButtonToggle(
      {Key? key,
      this.width,
      this.height,
      required this.active,
      this.bgColor,
      this.borderRadius,
      required this.label,
      required this.onClick,
      this.labelColor,
      this.gradient,
      this.elevation,
      this.labelStyle})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RoundedButtonToggleState createState() => _RoundedButtonToggleState();
}

class _RoundedButtonToggleState extends State<RoundedButtonToggle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
            elevation: widget.active ? 5 : 0,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInSine,
              width: widget.width ?? 140,
              height: widget.height ?? 40,
              decoration: BoxDecoration(
                color: widget.active ? Colors.red : Colors.white,
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
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
                  if (widget.active)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                  if (widget.label != null)
                    const SizedBox(
                      width: 8,
                    ),
                  if (widget.label != null)
                    Text(
                      widget.label!,
                      style: widget.labelStyle ??
                          heading2Style(
                              widget.active ? Colors.white : Colors.black),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
