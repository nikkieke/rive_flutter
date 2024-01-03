import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'around_custom_painter.dart';
import 'circular_notched_cornered_rectangle_clipper.dart';
import 'circular_notched_cornered_shape.dart';

class BottomNavBar extends StatefulWidget {
  final double? leftCornerRadius;

  final double? rightCornerRadius;

  final Color? backgroundColor;

  final Shadow? shadow;

  final Widget? child;


  const BottomNavBar({Key? key,
    this.leftCornerRadius,
    this.rightCornerRadius,
    this.backgroundColor,
    this.shadow, this.child}) :
        super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late ValueListenable<ScaffoldGeometry> geometryListenable;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    geometryListenable = Scaffold.geometryOf(context);
  }


  @override
  Widget build(BuildContext context) {
    final clipper = CircularNotchedAndCorneredRectangleClipper(
      shape: CircularNotchedAndCorneredRectangle(
        leftCornerRadius: widget.leftCornerRadius ?? 0.0,
        rightCornerRadius: widget.rightCornerRadius ?? 0.0,
      ),
      geometry: geometryListenable,
      notchMargin: 8,
    );
    return PhysicalShape(
      elevation: 8,
      color: Colors.transparent,
      clipper: clipper,
      child: AroundCustomPainter(
        clipper: clipper,
        shadow: widget.shadow,
        borderColor: Colors.transparent,
        borderWidth: 2,
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: widget.backgroundColor ?? Colors.white,
          child: Container(
            height: 100,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
