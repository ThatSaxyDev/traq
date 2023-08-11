// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';
import 'package:traq/shared/app_grafiks.dart';
import 'package:traq/theme/palette.dart';
import 'package:traq/utils/app_extensions.dart';
import 'package:traq/utils/widgets/click_button.dart';
import 'package:traq/utils/widgets/myicon.dart';

class BButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final void Function()? onTap;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final Widget? item;
  final String? text;
  final bool isText;
  final EdgeInsetsGeometry? padding;
  const BButton({
    Key? key,
    this.height,
    this.width,
    this.radius,
    required this.onTap,
    this.color,
    this.borderColor,
    this.textColor,
    this.item,
    this.text,
    this.isText = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 52,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 4),
            ),
          ),
          padding: padding ?? EdgeInsets.zero,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: color ?? const Color(0xFF294EAB),
        ),
        child: Center(
          child: isText == true
              ? Text(
                  text ?? '',
                  style: TextStyle(
                    color: textColor ?? Pallete.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : item,
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final void Function()? onTap;
  final Color? color;
  final Widget? item;
  final String? text;
  final bool isText;
  final Color? backgroundColor;
  final Color? textColor;
  const TransparentButton({
    Key? key,
    this.height,
    this.width,
    this.radius,
    required this.onTap,
    this.color,
    this.item,
    this.text,
    this.isText = true,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: color ?? Pallete.greey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 8),
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor ?? Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: isText == true
              ? Text(
                  text ?? '',
                  style: TextStyle(
                    color: textColor ?? Pallete.blackColor,
                    fontSize: 14.sw,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : item,
        ),
      ),
    );
  }
}

class GButton extends ConsumerWidget {
  final bool? isFromLogin;
  const GButton({
    Key? key,
    this.isFromLogin,
  }) : super(key: key);

  void signInWithGoogle(
      {required BuildContext context, required WidgetRef ref}) {
    ref
        .read(authControllerProvider.notifier)
        .signInWithGoogle(context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TransparentButton(
      height: 60,
      width: 300,
      onTap: () => signInWithGoogle(context: context, ref: ref),
      isText: false,
      item: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyIcon(icon: AppGrafiks.google, height: 20),
          15.wSpace,
          'Continue With Google'.txt16(
            fontWeight: FontWeight.w600,
            isheader: true,
          ),
        ],
      ),
    );
  }
}

class AppleButton extends ConsumerWidget {
  final bool? isFromLogin;
  const AppleButton({
    Key? key,
    this.isFromLogin,
  }) : super(key: key);

  void signInWithGoogle(
      {required BuildContext context, required WidgetRef ref}) {
    // ref
    //     .read(authControllerProvider.notifier)
    //     .signInWithGoogle(context: context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return ClickButton(
      onTap: () => signInWithGoogle(context: context, ref: ref),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          60.wSpace,
          Image.asset(
            'apple'.png,
            height: 23.sh,
            color: currentTheme.textTheme.bodyMedium!.color,
          ),
          15.wSpace,
          Text(
            'Continue With Apple',
            style: TextStyle(
              fontSize: 16.sw,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TTransparentButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? padding;
  final void Function()? onTap;
  final Color color;
  final Widget child;
  const TTransparentButton({
    Key? key,
    this.height,
    this.width,
    this.padding,
    required this.onTap,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33.3.sh,
      width: 40.sw,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: color,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.sw),
              ),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.symmetric(
              vertical: padding ?? 0,
            )),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
