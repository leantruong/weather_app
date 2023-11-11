import 'package:flutter/material.dart';


class ContainerCustom extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final double? radiusCircular;
  final Widget? child;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const ContainerCustom(
      {Key? key,
      this.width,
      this.height,
      this.color,
      this.radiusCircular,
      this.border,
      this.borderRadius,
      this.child,
      this.onTap,
      this.padding,
      this.decoration,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius ??
              BorderRadius.circular(radiusCircular ?? 0),
          color: color,
        ),
        child: child,
      ),
    );
  }
}
