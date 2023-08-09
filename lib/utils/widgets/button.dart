// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:traq/features/auth/controller/auth_controller.dart';

// import 'package:stream/features/auth/controller/auth_controller.dart';
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
  final Widget? item;
  final String? text;
  final bool isText;
  final Color? textColor;
  const BButton({
    Key? key,
    this.height,
    this.width,
    this.radius,
    required this.onTap,
    this.color,
    this.item,
    this.text,
    this.isText = true,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40.sh,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius ?? 8.sw),
            ),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: color ?? Pallete.blueColor,
        ),
        child: Center(
          child: isText == true
              ? Text(
                  text ?? '',
                  style: TextStyle(
                    fontSize: 15.sw,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                )
              : item,
        ),
      ),
    );
  }
}

class TransparentButton extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData currentTheme = ref.watch(themeNotifierProvider);
    return SizedBox(
      height: height ?? 40.sh,
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
              Radius.circular(radius ?? 8.sw),
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
                    color:
                        textColor ?? currentTheme.textTheme.bodyMedium!.color,
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

    return ClickButton(
      onTap: () => signInWithGoogle(context: context, ref: ref),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          60.wSpace,
          const MyIcon(icon: AppGrafiks.google, height: 20),
          15.wSpace,
          const Text(
            'Continue With Google',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
