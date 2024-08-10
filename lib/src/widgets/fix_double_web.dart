import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FixDoubleWebWidget extends StatelessWidget {
  const FixDoubleWebWidget({super.key,required this.number});
  final double number;
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.read_more);
  }
}