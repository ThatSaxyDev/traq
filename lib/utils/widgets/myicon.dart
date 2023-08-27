// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIcon extends StatelessWidget {
  final void Function()? onTap;
  final String icon;
  final double? height;
  final Color? color;

  const MyIcon({
    Key? key,
    required this.icon,
    this.height,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        icon.iconSvg,
        // ignore: deprecated_member_use
        color: color,
        height: height ??
            getValueForScreenType(context: context, mobile: 24.h, desktop: 24),
      ),
    );
  }
}

class BackIcon extends StatelessWidget {
  final void Function()? onTap;
  const BackIcon({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: SvgPicture.asset(
        'back'.iconSvg,
        height: 24,
      ),
    );
  }
}
