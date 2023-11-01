// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class DockedFAB extends StatefulWidget {
  final bool loading;
  final List<Color> gradient;
  Function onPressed;
  final String text;
  final IconData? icon;
  DockedFAB(
      {Key? key,
      required this.loading,
      required this.text,
      required this.gradient,
      this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DockedFABState createState() => _DockedFABState();
}

class _DockedFABState extends State<DockedFAB> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: widget.gradient,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.loading)
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              if (widget.loading)
                const SizedBox(
                  width: 8,
                ),
              Text(
                widget.text,
                style: heading1Style(Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
