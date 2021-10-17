import 'package:flutter/material.dart';

class ContainerTextField extends StatelessWidget {
  final Widget child;
  final double padding;
  const ContainerTextField({
    @required this.child,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding == null ? 0.0 : padding),
      decoration: BoxDecoration(
        color: Colors.grey[350],
        borderRadius: BorderRadius.circular(12)
      ),
      child: child, 
    );
  }
}